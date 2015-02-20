//
//  DXSemiViewControllerCategory.h
//  MyMusicPlayer
//
//  Created by 张榕明 on 15/01/01.
//  Copyright (c) 2015年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DXSemiViewController;

@interface UIViewController (SemiViewController)

@property (nonatomic, strong) DXSemiViewController *leftSemiViewController;
@property (nonatomic, strong) DXSemiViewController *rightSemiViewController;


@end
