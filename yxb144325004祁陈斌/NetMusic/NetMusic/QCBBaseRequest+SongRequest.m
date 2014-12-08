//
//  QCBBaseRequest+SongRequest.m
//  NetMusic
//
//  Created by xsdlr on 14/12/5.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import "QCBBaseRequest+SongRequest.h"

@implementation QCBBaseRequest (SongRequest)

+ (void)songList:(NSString *)path
       channelId:(NSString *)channelId
            type:(NSString *)type
         success:(songListSuccess)success
            fail:(songlistError)fail {
    
    NSDictionary* parameters = @{@"app_name":@"radio_desktop_win",@"version":@"100",@"channel":channelId,@"type":type,@"from":@"mainsite"};
    NSMutableArray *result = [NSMutableArray array];
    //转交全局线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        [QCBBaseRequest GETRequestWithPath:path parameters:parameters success:^(NSDictionary *jsonObject) {
            if (jsonObject) {
                NSArray *songs = [jsonObject objectForKey:@"song"];
                for (NSDictionary *dic in songs) {
                    QCBSongModel *song = [QCBSongModel new];
                    [song setValuesForKeysWithDictionary:dic];
                    [result addObject:song];
                }
                dispatch_async(dispatch_get_main_queue(), ^{
                    success(result);
                });
            }
        } fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                fail(error);
            });
        }];
    });
    
}

+ (NSURLSessionDownloadTask *)downloadSongCoverPic:(NSString *)path
                                            rename:(NSString *)rename
                                           success:(songCoverPicDownloadSuccess)success
                                              fail:(songCoverPicDownloadError)fail {
    __block NSURLSessionDownloadTask *task;
    //转交全局线程
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0), ^{
        task = [QCBBaseRequest downloadFile:path rename:rename success:^(NSURL *filePath) {
            dispatch_async(dispatch_get_main_queue(), ^{
                success(filePath);
            });
        } fail:^(NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                fail(error);
            });
        }];
    });
    return task;
}
@end
