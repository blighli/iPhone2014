//
//  NSString+MJ.m
//  HVeBo
//
//  Created by HJ on 14/12/10.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "NSString+MJ.h"

@implementation NSString (MJ)

- (NSString *)fileAppend:(NSString *)append
{
    // 1.1.获得文件拓展名
    NSString *ext = [self pathExtension];
    
    // 1.2.删除最后面的扩展名
    NSString *imgName = [self stringByDeletingPathExtension];
    
    // 1.3.拼接-568h@2x
    imgName = [imgName stringByAppendingString:append];
    
    // 1.4.拼接扩展名
    return [imgName stringByAppendingPathExtension:ext];
}
@end
