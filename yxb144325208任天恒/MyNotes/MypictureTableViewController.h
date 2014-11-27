//
//  MypictureTableViewController.h
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MypictureTableViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource>
- (IBAction)back:(id)sender;
@property (nonatomic, retain) NSArray *listData;

@end
