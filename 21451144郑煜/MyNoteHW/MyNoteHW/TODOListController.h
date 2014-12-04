//
//  TODOListController.h
//  TODOListHW
//
//  Created by StarJade on 14-11-10.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TODOListController : UITableViewController <UIAlertViewDelegate>

@property(nonatomic) NSInteger index;
@property(nonatomic) BOOL isAdd;



- (void)viewWillAppear:(BOOL)animated;
- (void)alertView:(UIAlertView *)alertView willDismissWithButtonIndex:(NSInteger)buttonIndex; //新建任务 逻辑判断
- (void)alertView:(UIAlertView *)alertView willChangeWithButtonIndex:(NSInteger)buttonIndex cellForRowAtIndexPath:(NSIndexPath *)indexPath; //修改任务 逻辑判断
@end
