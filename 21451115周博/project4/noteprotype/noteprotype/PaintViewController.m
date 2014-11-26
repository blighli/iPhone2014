//
//  PaintViewController.m
//  noteprotype
//
//  Created by zhou on 14/11/24.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "PaintViewController.h"
#import "PaintView.h"
#import "ApplicationConstants.h"
#import "CoreDataHelper.h"
#import "PaintHelper.h"
#import "AppDelegate.h"
#import "HRColorPickerViewController.h"

@interface PaintViewController ()
@property (weak, nonatomic) IBOutlet UIBarButtonItem *savePaint;
@property (nonatomic, strong) NSManagedObjectContext *manageContext;
@property (weak, nonatomic) IBOutlet PaintView *paintView;

@end

@implementation PaintViewController

- (IBAction)colorButtonAction:(id)sender
{
    HRColorPickerViewController *controller;
    controller = [[HRColorPickerViewController alloc] initWithColor:[UIColor blueColor] fullColor:YES];
    controller.delegate = self.paintView;
    [self.navigationController pushViewController:controller animated:YES];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    self.manageContext = [appDelegate managedObjectContext];
    
    if (self.isUpdate)
    {
        self.paintView.image = [self.paint getImage];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender == self.savePaint)
    {
        PaintView *paintView = self.paintView;

        if (paintView.image != nil)
        {
            Paint *paint = nil;

            //if in update paint mode, init paint to note's paint and do the update
            if (self.isUpdate && self.paint != nil)
            {
                paint = self.paint;
            }
            // in add mode , create a new paint using coredata helper
            else
            {
                paint = (Paint *)[CoreDataHelper CreateEntityFactory:kPaint inContext:self.manageContext];
            }

            NSDate *date = [NSDate date];
            NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
            [formatter setDateFormat:@"yyyyMMddHHmmss"];

            paint.paintName = [[formatter stringFromDate:date] stringByAppendingPathExtension:@"png"];
            paint.paintOwner = self.note;

            //Do not forget to release the Imagecontext here.
            
            //TODO
            //not elegent to do the beginContext and endContext in separate class
            UIGraphicsEndImageContext();
            
            
            NSURL *docPath = [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];

            NSURL *path = [docPath URLByAppendingPathComponent:paint.paintName];

           // NSLog(@"%@", path);

            paint.paintUrl = [path absoluteString];

            //if in add paint mode, add paint to note's paint container
            if (!self.isUpdate)
            {
                NSMutableSet *set = [self.note.paintContainer mutableCopy];
                [set addObject:paint];
                self.note.paintContainer = [NSSet setWithSet:set];
            }
            else
            {
                //do nothing , core data will auto update the paint of note
            }

            [UIImagePNGRepresentation(paintView.image) writeToURL:path atomically:YES];
        }
    }
}

@end
