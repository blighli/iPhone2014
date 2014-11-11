//
//  ViewController.h
//  TodoList
//
//  Created by 陈聪荣 on 14/11/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TodoDao.h"

@interface ViewController : UIViewController <UITableViewDataSource , UITableViewDelegate , UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UINavigationItem *navgationItem;
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UITextField *txtField;
@property (nonatomic , strong) NSMutableArray *list;
@property (nonatomic , strong) TodoDao *sharedManager;

@end

