//
//  AppDelegate.h
//  Project3
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TaskViewController : UIViewController

@property (assign,nonatomic) NSIndexPath* taskIndex;
@property (assign,nonatomic) id delegate;
@property (strong, nonatomic) IBOutlet UITextField *editingTask;
- (IBAction)close:(id)sender;
- (IBAction)deleteTask:(id)sender;
- (IBAction)saveTask:(id)sender;

@end
