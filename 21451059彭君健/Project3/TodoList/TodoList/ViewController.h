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
@property (weak, nonatomic) IBOutlet UIButton *buttonAdd;

@property BOOL isModifying;
@property NSInteger modifyingRow;

- (IBAction)buttonAddPushed:(id)sender;
- (IBAction)buttonEditPushed:(id)sender;
@end

