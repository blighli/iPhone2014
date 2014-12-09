//
//  BBWebService.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "BBTVListModel.h"

typedef void(^responseTVListModelArray)(NSArray *array);
typedef void(^failReason)(NSString *failReason);

@interface BBWebService : NSObject


/**
 *  连接服务器，并获取节目源
 *
 *  @param callbackData 节目源数组
 *  @param failed       连接失败原因
 */
+(void)connectToServer:(responseTVListModelArray) callbackData requestFailed:(failReason) failed;

/**
 *  从服务器下载电视台LOGO
 *
 *  @param tvlistArray BBTVListModel数组
 *  @param isUpdate    是否强制更新本地Logo
 */

+(void)downloadTVLogo:(NSArray *)tvlistArray withUpdate:(BOOL)isUpdate;

@end
