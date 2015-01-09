//
//  InfoCenterViewController.h
//  EasyCount
//
//  Created by yingxl1992 on 14/12/20.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SlideNavigationController.h"

@interface InfoCenterViewController : UIViewController<SlideNavigationControllerDelegate>
{
    NSUserDefaults *userInfo;
}

@property (weak, nonatomic) IBOutlet UILabel *userLable;
@property (weak, nonatomic) IBOutlet UIButton *logoutBtn;

@end
