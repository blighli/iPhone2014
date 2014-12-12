//
//  ChannelViewController.h
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChannelViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *channelTableView;
- (IBAction)retunClick:(id)sender;
@property (strong , nonatomic) NSMutableArray *channelArray;

@end
