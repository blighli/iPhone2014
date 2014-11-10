//
//  AppDelegate.h
//  iPhone_2
//
//  Created by 王路尧 on 14/11/9.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

- (void)addTask:(id)sender;
@property (strong, nonatomic) UIWindow *window;


@end

