//
//  MainViewController.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/4.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>

/**
 *  电视源数据
 */
@property (strong,nonatomic) NSMutableArray *tvlistData;

@end
