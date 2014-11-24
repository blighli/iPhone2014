//
//  AppDelegate.h
//  Edc
//
//  Created by SXD on 14/11/8.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import <UIKit/UIKit.h>


NSString*docPath(void);


@interface AppDelegate : UIResponder<UIApplicationDelegate>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
- (void)addTask: (id)sender;
@property (strong, nonatomic) UIWindow *window;


@end

