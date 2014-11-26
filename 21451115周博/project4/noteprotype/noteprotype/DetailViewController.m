//
//  DetailViewController.m
//  noteprotype
//
//  Created by zhou on 14/11/21.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "DetailViewController.h"
#import "ImageAndRecordListTableViewController.h"
#import "PaintViewController.h"
#import "PhotoViewController.h"
#import "ApplicationConstants.h"
#import "CoreDataHelper.h"
#import "AppDelegate.h"

@interface DetailViewController ()
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *saveBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *paintToolBtn;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *photoToolBtn;
//@property (weak, nonatomic) IBOutlet UIBarButtonItem *recordToolBtn;
@property (nonatomic, strong) NSManagedObjectContext *context;
@end

@implementation DetailViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    if (self.note != nil)
    {
        //set title
        if (self.note.title != nil)
        {
            self.titleLabel.text = self.note.title;
        }
        else
        {
            self.titleLabel.text = @"click here to add the title";
        }
        
        //set content
        if (self.note.content != nil)
        {
            self.textView.text = self.note.content;
        }
        else
        {
            self.textView.text = @"type here to add some content";
        }
    }

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.context = [appDelegate managedObjectContext];

    //    [[NSNotificationCenter defaultCenter]
    //        addObserver:self
    //           selector:@selector(textFieldShouldBeginEditing:)
    //               name:UITextViewTextDidBeginEditingNotification
    //             object:self.textView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}


- (IBAction)changeTitle:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Change Title" message:@"" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"OK", nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        NSString *title = [alertView textFieldAtIndex:0].text;
        self.note.title = title;
        self.titleLabel.text = title;
    }
}

/**
 *  to resize the textView when input pan rise up, this is the delegate method 
 *  when UITextViewTextDidBeginEditingNotification broadcast
 *
 *  @param textField textField
 *
 *  @return always YES
 */

//TODO seems not working yet
//- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
//
//{
////    CGPoint origin = self.textView.frame.origin;
////    CGSize size = self.textView.frame.size;
////    [self.textView setFrame:CGRectMake(origin.x, origin.y, size.width, size.height - 200)];
////
//    //NSLog(@"hello ?");
//    return YES;
//}
//
//- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
//
//{
//    CGPoint origin = self.textView.frame.origin;
//    CGSize size = self.textView.frame.size;
//    [self.textView setFrame:CGRectMake(origin.x, origin.y, size.width, size.height)];
//    return YES;
//}



//the segue for unwind
//Nothing to do here ,because coredata store the data automatically once the context changed
//so, no need to do the saveing date action
- (IBAction)unWindFromPaintToDetail:(UIStoryboardSegue *)segue
{
    PaintViewController *source = [segue sourceViewController];

    if (source.note != nil)
    {
        //NSLog(@"%@", source.note.content);

        //[self.tableView reloadData];
    }
}

- (IBAction)unWindFromPhotoToDetail:(UIStoryboardSegue *)segue
{
    PhotoViewController *source = [segue sourceViewController];

    if (source.note != nil)
    {
       // NSLog(@"%@", source.note.content);

        // [self.tableView reloadData];
    }
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // prepar date for sub TabView Controller,
    // this is exectue on viewDidLoad automatical by storyboard
    if ([[segue identifier] isEqualToString:kMultiMediaTableInitSegue])
    {
        ImageAndRecordListTableViewController *multiMediaList = [segue destinationViewController];
        multiMediaList.note = self.note;
    }

    
    
    // ========
    // update before jumping betweem viewController
    // ========
    
    
    //save data
    if (sender == self.saveBtn)
    {
        self.note.title = self.titleLabel.text;
        self.note.content = self.textView.text;
        self.note.lastModifyTime = [NSDate date];
    }
    
    
    // create paint
    // in create mode, should set the isUpdate flag false.
    else if (sender == self.paintToolBtn)
    {
        PaintViewController *destination = [segue destinationViewController];
        destination.note = self.note;
        destination.isUpdate = NO;
    }
    //create photo
    else if (sender == self.photoToolBtn)
    {
        PhotoViewController *destination = [segue destinationViewController];
        destination.note = self.note;
        destination.isUpdate = NO;
    }
//    else if (sender == self.recordToolBtn)
//    {
//        //TODO
//    }

    // else a new empty note is return to notelist view
    // TODO  find a way to pervent this happen, maybe NSUndoManger ?
    else
    {
        if (self.note.title == nil) {
            self.note.title = @"click here to add the title";
            
        }
        if (self.note.content == nil) {
            self.note.content = @"type here to add some content";
        }
       
    }
}

@end
