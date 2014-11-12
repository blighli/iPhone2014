//
//  AppDelegate.h
//  Project3
//
//  Created by 江山 on 11/11/14.
//  Copyright (c) 2014 jiangshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ViewController;

NSString *docPath(void);
@interface MyAppDelegate : UIResponder<UIApplicationDelegate, UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
-(void)addTask: (id)sender;

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) ViewController *viewController;

@end
