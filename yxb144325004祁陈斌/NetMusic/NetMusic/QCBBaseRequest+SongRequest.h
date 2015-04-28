//
//  QCBBaseRequest+SongRequest.h
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseRequest.h"
#import "QCBSongModel.h"

typedef void (^songListSuccess)(NSArray* songList);
typedef void (^songlistError)(NSError* error);
typedef void (^songCoverPicDownloadSuccess)(NSURL* filePath);
typedef void (^songCoverPicDownloadError)(NSError* error);
@interface QCBBaseRequest (SongRequest)
/**
*  请求歌曲列表
*
*  @param path      请求地址
*  @param channelId 频道id
*  @param type      类型
*  @param success   成功回调
*  @param fail      失败回调
*/
+ (void) songList:(NSString*)path
        channelId:(NSString*) channelId
             type:(NSString*) type
          success:(songListSuccess) success
             fail:(songlistError)fail;
/**
 *  下载歌曲封面图片
 *
 *  @param path    图片地址
 *  @param rename  图片重命名名称
 *  @param success 成功回调
 *  @param fail    失败回调
 *
 *  @return NSURLSessionDownloadTask 可通过该实例的cancel方法取消
 */
+ (NSURLSessionDownloadTask*) downloadSongCoverPic:(NSString*) path
                                            rename:(NSString*)rename
                                           success:(songCoverPicDownloadSuccess) success
                                              fail:(songCoverPicDownloadError) fail;
@end
