//
//  LeftMenuViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/23.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface LeftMenuViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (nonatomic, strong) IBOutlet UITableView *tableView;
@property (nonatomic, assign) BOOL slideOutAnimationEnabled;

@end
