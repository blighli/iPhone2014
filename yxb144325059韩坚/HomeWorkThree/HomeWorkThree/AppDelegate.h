//
//  AppDelegate.h
//  HomeWorkThree
//
//  Created by HJ on 14/11/5.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
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

