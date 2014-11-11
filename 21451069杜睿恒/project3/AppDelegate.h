//
//  AppDelegate.h
//  project3
//
//  Created by shazhouyouren on 14/11/6.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
- (void)addTask: (id)sender;
@property (strong, nonatomic) UIWindow *window;


@end

