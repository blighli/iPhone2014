//
//  tasklistAppDelegate.h
//  tasklist
//
//  Created by jiaoshoujie on 14-11-8.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface tasklistAppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

- (void)addTask: (id)sender;



@property (strong, nonatomic) UIWindow *window;

@end

