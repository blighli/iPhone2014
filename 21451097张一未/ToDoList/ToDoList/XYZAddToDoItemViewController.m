//
//  XYZAddToDoItemViewController.m
//  ToDoList
//
//  Created by Olivier Truong on 11/10/13.
//  Copyright (c) 2013 Olivier Truong. All rights reserved.
//

#import "XYZAddToDoItemViewController.h"

@interface XYZAddToDoItemViewController ()

@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (weak, nonatomic) IBOutlet UIDatePicker *reminderDate;

@end

@implementation XYZAddToDoItemViewController

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if (sender != self.doneButton) return;
    if (self.textField.text.length > 0) {
        self.toDoItem = [[XYZToDoItem alloc] init];
        self.toDoItem.itemName = self.textField.text;
        self.toDoItem.reminderDate = self.reminderDate.date;
        
        NSLog(@"reminderDate: %@", self.toDoItem.reminderDate);
        
        UILocalNotification *localNotif = [[UILocalNotification alloc] init];
        
        localNotif.fireDate = self.toDoItem.reminderDate;
        localNotif.timeZone = [NSTimeZone defaultTimeZone];
        localNotif.alertBody = self.toDoItem.itemName;
        localNotif.applicationIconBadgeNumber = 1;
        
        [[UIApplication sharedApplication] scheduleLocalNotification:localNotif];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
