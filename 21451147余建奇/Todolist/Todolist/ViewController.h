//
//  ViewController.h
//  Todolist
//
//  Created by yjq on 14/11/8.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <UIKit/UIKit.h>

NSMutableArray *_list;
@interface ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

@property(weak,nonatomic)IBOutlet UITableView *tableView;
@property(readwrite,nonatomic)IBOutlet UITextField *textfiled;

-(IBAction)addtoList:(id)sender;
@end

