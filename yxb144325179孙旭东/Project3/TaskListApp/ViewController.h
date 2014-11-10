//
//  ViewController.h
//  TaskListApp
//
//  Created by  sephiroth on 14/11/9.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString *docPath(void);
@interface ViewController : UIViewController<UIApplicationDelegate, UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton *insertButton;
    NSMutableArray *tasks;
}
@property (copy) NSMutableArray * tasks;
- (void)addTask:(id)sender;
@end

