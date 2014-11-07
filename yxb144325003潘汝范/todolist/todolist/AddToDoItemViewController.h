//
//  AddToDoItemViewController.h
//  todolist
//
//  Created by Van on 14/11/6.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"


@interface AddToDoItemViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextField *textfiled;
@property (weak, nonatomic) IBOutlet UIBarButtonItem *doneButton;
@property (strong,nonatomic) AppDelegate *myDelegate;
@property NSManagedObjectContext *managedObjectContext;
@property TodoItem *item;
@property BOOL isEdit;
+ (void) editCell:(TodoItem *)item :(NSManagedObjectContext *)managedObjectContext :(NSString *)textfield;
@end
