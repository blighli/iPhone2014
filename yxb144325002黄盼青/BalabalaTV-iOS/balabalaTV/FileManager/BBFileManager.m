//
//  BBFileManager.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBFileManager.h"

@implementation BBFileManager

+(BOOL)isFileExisted:(NSString *)fileName withPathDirectory:(NSSearchPathDirectory)directory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingFormat:@"/%@",fileName];
    
    NSFileManager *manager = [NSFileManager defaultManager];
    return [manager fileExistsAtPath:filePath];
}


+(void)writeDataToFile:(NSString *)fileName withData:(NSData *)data withPathDirectory:(NSSearchPathDirectory)directory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingFormat:@"/%@",fileName];
    
    [data writeToFile:filePath atomically:YES];
}


+(NSData *)readDataFromFile:(NSString *)fileName withPathDirectory:(NSSearchPathDirectory)directory{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(directory, NSUserDomainMask, YES);
    NSString *path = [paths objectAtIndex:0];
    
    NSString *filePath = [path stringByAppendingFormat:@"/%@",fileName];
    
    return [NSData dataWithContentsOfFile:filePath];
}

@end
