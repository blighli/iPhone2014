//
//  AppDelegate.h
//  TaskListDemo
//
//  Created by YilinGui on 14-11-9.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate,UIAlertViewDelegate,UITableViewDelegate,UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

- (void)addTask:(id)sender;

@property (strong, nonatomic) UIWindow *window;


@end

