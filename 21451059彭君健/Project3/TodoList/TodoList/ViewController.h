//
//  ViewController.h
//  TodoList
//
//  Created by Mz on 14-11-7.
//  Copyright (c) 2014年 mz. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) AppDelegate* appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;

- (IBAction)buttonAdd:(id)sender;
- (IBAction)buttonEdit:(id)sender;
@end

