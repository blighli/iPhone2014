//
//  AppDelegate.h
//  Task List
//
//  Created by 王威 on 14/11/9.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);
@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource,
UIAlertViewDelegate, UITableViewDelegate>{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}

@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) NSIndexPath *indexPath;

- (void)addTask:(id)sender;

@end


