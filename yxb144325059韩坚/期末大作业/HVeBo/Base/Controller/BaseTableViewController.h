//
//  BaseTableViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/19.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol BaseTableViewDelegate <NSObject>
@optional
- (void)disappear;
@end

@interface BaseTableViewController : UITableViewController
@property (nonatomic, weak) id<BaseTableViewDelegate> delegate;
@end
