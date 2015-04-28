//
//  PlayerViewController.h
//  NetMusic
//
//  Created by xsdlr on 14/12/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBSongModel.h"

//typedef NS_OPTIONS(NSUInteger, QCBPlayerStatus) {
//    QCBPlayerStatusInit     = 0 ,
//    QCBPlayerStatusPlaying  = 1 ,
//    QCBPlayerStatusPause    = 1<<1
//};

@interface PlayerViewController : UIViewController
@property(weak,nonatomic) QCBSongModel *song;
@property(assign,nonatomic) BOOL isShowed;
/**
 *  设置歌曲
 *
 *  @param song 歌曲
 */
- (void)setSong:(QCBSongModel *)song;
/**
 *  展示player
 */
- (void) showPlayer;
/**
 *  播放音乐
 */
- (void) play;
/**
 *  停止音乐
 */
- (void) stop;
@end
