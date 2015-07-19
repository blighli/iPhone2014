//
//  ViewController.h
//  NavDemo
//
//  Created by hanxue on 14/11/17.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Detailview;
@interface ViewController : UIViewController<UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, retain) UITableView *myTableView;

@end

