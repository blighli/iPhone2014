//
//  SongTableViewController.h
//  NetMusic
//
//  Created by xsdlr on 14/12/6.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QCBSongModel.h"

@interface SongTableViewController : UITableViewController<UITableViewDataSource,UITableViewDelegate>
/**
 *  频道id
 */
@property(strong,nonatomic) NSString *channelId;
/**
 *  当前歌曲下标
 */
@property(assign,nonatomic) NSUInteger songIndex;
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
 *  通知界面大小变化
 */
- (void) fireResize;
/**
 *  根据下标获得歌曲信息
 *
 *  @param index 下标
 *
 *  @return QCBSongModel 若index越界则返回nil
 */
- (QCBSongModel*) getSongByIndex:(NSUInteger) index;
/**
 *  根据下标选中tableview
 *
 *  @param index 下标
 */
- (void) selectRowAtIndex:(NSUInteger) index;
@end
