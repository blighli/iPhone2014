//
//  MainViewController.h
//  NetMusic
//
//  Created by xsdlr on 14/12/1.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaseViewController.h"
#import "ShadeView.h"
#import "QCBSongModel.h"
#import "SongTableViewController.h"

@interface MainViewController : BaseViewController<ShadeViewDelegate>
/**
 *  关闭遮罩
 */
- (void) closeShadeView;
/**
 *  添加歌曲信息
 *
 *  @param songs 歌曲信息数组
 */
- (void) addSongs:(NSArray*) songs;
/**
 *  添加单个歌曲
 *
 *  @param song 歌曲信息
 */
- (void) addSong:(QCBSongModel*) song;
/**
 *  移除所有歌曲信息
 */
- (void) removeAllSongs;
/**
 *  设置频道id
 *
 *  @param cid 频道id
 */
- (void) setChannelId:(NSString*) cid;
/**
 *  播放歌曲
 *
 *  @param song 歌曲
 */
- (void) playSong:(QCBSongModel*) song;
/**
 *  获得下一首歌
 *
 *  @return QCBSongModel
 */
- (QCBSongModel*) getNextSong;
/**
 *  获得前一首歌
 *
 *  @return QCBSongModel
 */
- (QCBSongModel *)getPreviousSong;
@end
