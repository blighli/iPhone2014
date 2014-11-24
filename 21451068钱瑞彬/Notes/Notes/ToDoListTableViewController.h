//
//  ToDoListTableViewController.h
//  ToDoList
//
//  Created by apple on 14-11-8.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ToDoListTableViewController : UITableViewController


// todolist 每一项
@property NSMutableArray* toDoItems;

// 选中了哪一行
@property int selectedItem;


@property (weak, nonatomic) IBOutlet UIBarButtonItem *addItem;

// 导入数据
- (void)loadListData;

// 沙盒
NSString* docPath();

@end
