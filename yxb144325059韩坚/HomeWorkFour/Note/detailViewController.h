//
//  detailViewController.h
//  Note
//
//  Created by HJ on 14/11/15.
//  Copyright (c) 2014年 cstlab.hj.NOTE. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "C5.h"
#import "PassValueDelegate.h"

@interface detailViewController : UITableViewController<PassValueDelegate>

@property (assign, nonatomic) NSInteger item;


@end
