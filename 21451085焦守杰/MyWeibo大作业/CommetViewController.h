//
//  CommetViewController.h
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/3.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Weibo.h"
@interface CommetViewController : UIViewController{
    @private
    Weibo  *_weibo;
}

@property (strong,nonatomic) NSString *id;
//@property (strong,nonatomic) NSString *accessToken;

@end
