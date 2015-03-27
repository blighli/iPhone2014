//
//  nearByViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseTableViewController.h"

typedef void (^SelectDownBlock)(NSDictionary *);

@interface NearByViewController : BaseTableViewController
@property (nonatomic, strong)SelectDownBlock selectDownBlock;
@end
 