//
//  BBFileManager.h
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface BBFileManager : NSObject


/**
 *  判断文件是否存在
 *
 *  @param fileName  文件名，包含后缀
 *  @param directory 文档路径
 *
 *  @return 是否存在
 */
+(BOOL)isFileExisted:(NSString *)fileName withPathDirectory:(NSSearchPathDirectory)directory;

/**
 *  写入数据到文件
 *
 *  @param fileName  文件名，包括后缀
 *  @param data      数据
 *  @param directory 文档路径
 */
+(void)writeDataToFile:(NSString *)fileName withData:(NSData *)data withPathDirectory:(NSSearchPathDirectory)directory;

/**
 *  读取文件数据
 *
 *  @param fileName  文件名，包括后缀
 *  @param directory 文档路径
 *
 *  @return 文件数据
 */
+(NSData *)readDataFromFile:(NSString *)fileName withPathDirectory:(NSSearchPathDirectory)directory;


@end
