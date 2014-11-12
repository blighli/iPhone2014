//
//  AppDelegate.h
//  TaskList
//
//  Created by 樊博超 on 14-11-10.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);

@interface AppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource>
{
    UITableView *taskList;
    UITextField *inputText;
    UIButton * insert;
    NSMutableArray *tasks;
    UITextField *textField;
    NSUInteger row;
}
-(void)addTask:(id)sender;
-(void)tableView:(UITableView*)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@property (strong, nonatomic) UIWindow *window;


@end

