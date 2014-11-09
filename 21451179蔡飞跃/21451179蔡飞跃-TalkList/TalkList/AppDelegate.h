//
//  AppDelegate.h
//  TalkList
//
//  Created by 蔡飞跃 on 14/11/8.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ViewController.h"

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
    ViewController *viewController;
}
-(void)addTask: (id)sender;

@property (strong, nonatomic) UIWindow *window;

@end

