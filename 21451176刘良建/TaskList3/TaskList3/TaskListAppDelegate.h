//
//  TaskListAppDelegate.h
//  TaskList3
//
//  Created by JANESTAR on 14-11-9.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <UIKit/UIKit.h>

NSString * docPath(void);


@interface TaskListAppDelegate : UIResponder <UIApplicationDelegate,UITableViewDataSource>
{
    UITableView *taskTable;
    UITextField *taskField;
    UIButton * insertButton;
    NSMutableArray *tasks;

}

-(void)addTask:(id)sender;
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
;

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
;


@property (strong, nonatomic) UIWindow *window;

@end
