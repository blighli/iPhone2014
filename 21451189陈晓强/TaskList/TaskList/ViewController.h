//
//  ViewController.h
//  TaskList
//
//  Created by 陈晓强 on 14/11/9.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

