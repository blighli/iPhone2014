//
//  AppDelegate.h
//  cst.zju.guo
//
//  Created by cstlab on 14/11/6.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
NSString* docPath(void);
@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource>
{
    UITableView* taskTable;
    UITextField* taskField;
    UIButton* insertButton;
    UIButton* deleteButton;
    NSMutableArray* tasks;
}
-(void) addTask:(id)sender;
-(void)deleteTask:(id)sender;
//-(void) deleteTask:(id)sender;
@property (strong, nonatomic) UIWindow *window;


@end

