//
//  MyFriendViewController.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/2.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
#import "DetailWeiboInfoViewController.h"
#import "WeiboTableCell.h"
@interface MyFriendViewController : UITableViewController<UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate>{
    bool nibRegistered;
   @private
    Weibo *_weibo;
    NSDictionary *_friendWeibo;
    NSMutableArray *_weiboInfo;
    bool _isLoading;
    DetailWeiboInfoViewController *dev;
    UIWebView *webVew;
    
}
@property (strong,nonatomic)NSMutableData *receiveData;
@end
