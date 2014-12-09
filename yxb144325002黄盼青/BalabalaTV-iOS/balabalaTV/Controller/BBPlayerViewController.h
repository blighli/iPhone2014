//
//  BBPlayerViewController.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileVLCKit/MobileVLCKit.h>

@interface BBPlayerViewController : UIViewController

@property (strong,nonatomic,readonly) VLCMediaListPlayer *player;


/**
 *  设置视频源地址
 *
 *  @param url 视频地址
 */
-(void)setVideoURL:(NSURL *)url;


/**
 *  设置视频源地址数组
 *
 *  @param urls 字符串地址数组
 */
-(void)setVideoListURL:(NSArray *)urls;

/**
 *  开始播放
 */
-(void)play;

@end
