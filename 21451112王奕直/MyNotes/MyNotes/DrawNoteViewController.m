//
//  DrawNoteViewController.m
//  MyNotes
//
//  Created by alwaysking on 14/11/24.
//  Copyright (c) 2014年 alwaysking. All rights reserved.
//

#import "DrawNoteViewController.h"
#import "ViewController.h"
#import "AppDelegate.h"
#import "DrawingNote.h"
#import "YYView.h"
#import "UIImage+YYcaptureView.h"

@interface DrawNoteViewController ()

@end

@implementation DrawNoteViewController
@synthesize imageView,drawFetchRequest,managedObjectContext,textField,imageNameStr,customView;
@synthesize btnBack,btnClear;
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewWillAppear:(BOOL)animated
{
    DrawingNote *note;
    if (tableItemClick) {
        [imageView setHidden:NO];
        [btnClear setHidden:YES];
        [btnBack setHidden:YES];
        note = [drawNoteArray objectAtIndex:[drawNoteArray count] - tableDataRow - 1];
        textField.text = [NSString stringWithFormat:@"%@",note.name];
        NSString *drawDirectory = [self documentsPathForFileName:nil];
        NSString *drawPath = [drawDirectory stringByAppendingPathComponent:note.drawingRoot];
        NSData *pngData = [NSData dataWithContentsOfFile:drawPath];
        NSLog(note.drawingRoot);
        UIImage *image = [UIImage imageWithData:pngData];
        imageView.image = image;
    }
    else{
        [imageView setHidden:YES];
        [btnClear setHidden:NO];
        [btnBack setHidden:NO];
    }
}


- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (IBAction)btnCancle:(id)sender{
    tableItemClick = false;
    [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)btnOk:(id)sender{
    UIImage *newImage =    [UIImage YYcaptureImageWithView:self.customView];
    if (newImage != nil) {
        if (tableItemClick) {
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            NSError * error;
            self.managedObjectContext = [appDelegate managedObjectContext];
            
            drawFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"DrawingNote"
                                                      inManagedObjectContext:self.managedObjectContext];
            [drawFetchRequest setEntity:entity];
            NSMutableArray *noteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:drawFetchRequest error:nil]];
            DrawingNote *note = (DrawingNote *)[noteArray objectAtIndex:[drawNoteArray count] - tableDataRow - 1];
            [note setValue:textField.text forKey:@"name"];
            if (![note.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            
        }else{
            AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
            self.managedObjectContext = [appDelegate managedObjectContext];
            
            DrawingNote * drawNote = [NSEntityDescription insertNewObjectForEntityForName:@"DrawingNote"
                                                                   inManagedObjectContext:self.managedObjectContext];
            drawNote.tagId = [NSString stringWithFormat:@"%lu",(unsigned long)[drawNoteArray count]];
            if (![textField.text isEqual:@""]) {
                drawNote.name = textField.text;
            }else{
                drawNote.name = [NSString stringWithFormat:@"Drawing%@",drawNote.tagId];
            }
            imageNameStr = [NSString stringWithFormat:@"Draw%@.png",drawNote.tagId];
            drawNote.drawingRoot = imageNameStr;
            NSLog(drawNote.drawingRoot);
            drawFetchRequest = [[NSFetchRequest alloc] init];
            NSEntityDescription *entity = [NSEntityDescription entityForName:@"DrawingNote"
                                                      inManagedObjectContext:self.managedObjectContext];
            
            NSError *error;
            if (![self.managedObjectContext save:&error]) {
                NSLog(@"Whoops, couldn't save: %@", [error localizedDescription]);
            }
            [drawFetchRequest setEntity:entity];
            
            NSMutableArray *noteArray = [NSMutableArray arrayWithArray:[self.managedObjectContext executeFetchRequest:drawFetchRequest error:&error]];
            [drawNoteArray addObject:[noteArray objectAtIndex:[noteArray count] - 1]];
            
            NSData *pngData = UIImagePNGRepresentation(newImage);
            NSFileManager *fileManager = [NSFileManager defaultManager];
            NSString *picDirectory = [self documentsPathForFileName:nil];
            // 创建目录
            if (![fileManager fileExistsAtPath:picDirectory]) {
                [fileManager createDirectoryAtPath:picDirectory withIntermediateDirectories:YES attributes:nil error:nil];
            }
            NSString *picPath = [picDirectory stringByAppendingPathComponent:imageNameStr];
            [fileManager createFileAtPath:picPath contents:pngData attributes:nil];
        }
        tableItemClick = false;
        [self.presentingViewController dismissViewControllerAnimated:YES completion:nil];
    }
}

//获得文件路径
- (NSString *)documentsPathForFileName:(NSString *)name
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSLog(@"documentsDirectory%@",documentsDirectory);
    NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"drawing"];
    return testDirectory;
}

- (IBAction)clearOnClick:(UIButton *)sender {
    //调用清理方法
    [self.customView clearView];
}

- (IBAction)backOnClick:(UIButton *)sender {
    //调用回退方法
    [self.customView backView];
}


/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end
