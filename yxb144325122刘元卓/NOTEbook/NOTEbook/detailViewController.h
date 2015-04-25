//
//  detailViewController.h
//  NOTEbook
//
//  Created by SXD on 14/12/3.
//  Copyright (c) 2014年 SXD. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "C5.h"
#import "PassValueDelegate.h"

@interface detailViewController : UITableViewController<PassValueDelegate>

@property (assign, nonatomic) NSInteger item;


@end