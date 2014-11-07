//
//  TaskViewController.h
//  task
//
//  Created by 黄盼青 on 14/11/6.
//  Copyright (c) 2014年 docee. All rights reserved.
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
