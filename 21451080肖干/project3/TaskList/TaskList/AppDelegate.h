//
//  AppDelegate.h
//  TaskList
//
//  Created by xiaoo_gan on 11/9/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate, UITableViewDataSource,UIAlertViewDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
- (void) addTask:(id)sender;
@property (strong, nonatomic) UIWindow *window;
@end

