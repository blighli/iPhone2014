//
//  DetailWeiboInfoViewController.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/3.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
@interface DetailWeiboInfoViewController : UIViewController<UITableViewDataSource,UITableViewDelegate>{
    @private
    Weibo *_weibo;
    NSString *weiboID;
    NSMutableArray *commentArray;
    NSMutableArray *headImage;
}

@property(strong,nonatomic) NSDictionary *detailWeiboInfo;

@end
