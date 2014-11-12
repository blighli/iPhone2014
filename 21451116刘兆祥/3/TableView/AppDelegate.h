//
//  AppDelegate.h
//  TableView
//
//  Created by Steve on 14-11-10.
//  Copyright (c) 2014年 Steve. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
     UIAlertView *myAlertView;
    int index;
}
- (void)addTask: (id)sender;
@property (strong, nonatomic) UIWindow *window;
@property (strong,nonatomic) UITableView *tableView;


@end

