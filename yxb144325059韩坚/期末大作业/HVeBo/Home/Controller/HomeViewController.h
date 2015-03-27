//
//  HomeViewController.h
//  HVeBo
//  首页控制器
//
//  Created by HJ on 14/12/3.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LeftViewController.h"

@protocol HomeDelegate <NSObject>

- (void)didSelectedHidenSwitch:(BOOL)hidden;

@end

@interface HomeViewController : UITableViewController
@property (nonatomic, weak) id<HomeDelegate>delegate;

@end
