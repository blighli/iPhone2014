//
//  AppDelegate.h
//  MyTaskList
//
//  Created by cstlab on 14-11-10.
//  Copyright (c) 2014年 Tan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton * insertBtn;
    NSMutableArray * tasks;
}

@property (strong, nonatomic) UIWindow *window;
-(void)addTask:(id)sender;


@end

