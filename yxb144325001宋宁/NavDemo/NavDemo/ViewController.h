//
//  ViewController.h
//  NavDemo
//
//  Created by NimbleSong on 14/11/17.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Detailview;
@interface ViewController : UIViewController<UIApplicationDelegate,UITableViewDataSource,UITableViewDelegate,UIAlertViewDelegate>

@property (nonatomic, retain) NSMutableArray *dataList;
@property (nonatomic, retain) UITableView *myTableView;

@end

