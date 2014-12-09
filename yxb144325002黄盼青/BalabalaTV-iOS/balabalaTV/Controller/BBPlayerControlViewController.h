//
//  BBPlayerControlViewController.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BBPlayerControlViewController : UIViewController

/**
 *  显示播放控件
 *
 *  @param vc rootViewController
 */
-(void)showPlayerControl:(UIViewController *)vc;

/**
 *  关闭播放控件
 */
-(void)closePlayerControl;

@end
