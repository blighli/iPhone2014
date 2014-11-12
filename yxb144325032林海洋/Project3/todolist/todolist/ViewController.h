//
//  ViewController.h
//  todolist
//
//  Created by xufei on 14/11/9.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDelegate;

@interface ViewController : UIViewController<UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) AppDelegate* appDelegate;

@property (weak, nonatomic) IBOutlet UITextField *taskField;
@property (weak, nonatomic) IBOutlet UITableView *taskTable;
@property (weak, nonatomic) IBOutlet UIButton *insert;

@property BOOL Moding;
@property NSInteger Row;

- (IBAction)buttonInsert:(id)sender;
@end
