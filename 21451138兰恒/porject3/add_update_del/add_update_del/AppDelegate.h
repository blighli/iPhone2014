//
//  AppDelegate.h
//  add_update_del
//
//  Created by lh on 14-11-9.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *docPath(void);
@interface MyAppDelegate : UIResponder<UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate,UITableViewDataSource> {
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
- (void)addTask: (id)sender;
@property (strong, nonatomic) UIWindow *window;


@end
