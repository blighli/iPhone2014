//
//  AppDelegate.h
//  TaskList
//
//  Created by 杨长湖 on 14/11/9.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource>{
    UITableView *taskTable; //
    UITextField *taskField; //
    UIButton *insertButton; //
    NSMutableArray *tasks;  //数据
}
-(void)addTask: (id)sender;
@property (strong, nonatomic) UIWindow *window;


@end

