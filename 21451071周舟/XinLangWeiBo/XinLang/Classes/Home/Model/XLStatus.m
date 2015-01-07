//
//  XLStatus.m
//  XinLang
//
//  Created by 周舟 on 14-10-2.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLStatus.h"
#import "XLUser.h"
#import "XLPhoto.h"
#import "MJExtension.h"
#import "NSDate+MJ.h"

@implementation XLStatus



/**
 *  使MJExtension识别这个类
 *
 *  @return
 */
- (NSDictionary *)objectClassInArray
{
    return @{@"pic_urls" : [XLPhoto class]};
}

- (void)setSource:(NSString *)source
{
    //NSLog(@"source:%@",source);
    if (source.length <= 0) {
        _source = @"未知来源";
    }else
    {
        int jianLoc = (int)[source rangeOfString:@">"].location;
        if (jianLoc == NSNotFound)
        {
       
            _source = [source copy];
            //NSLog(@"######source_1:%@",_source);
        }
        else
        {
            int loc = jianLoc + 1;
            int length = (int)[source rangeOfString:@"</"].location - loc;
            source = [source substringWithRange:NSMakeRange(loc, length)];
        
            _source = [NSString stringWithFormat:@"来自%@", source];
            //NSLog(@"######source_2:%@",_source);
        }
    }
}
- (NSString *)createdTime
{
    // _created_at == Fri May 09 16:30:34 +0800 2014
    // 1.获得微博的发送时间
    NSDateFormatter *fmt = [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"EEE MMM dd HH:mm:ss Z yyyy";
#warning 真机调试下, 必须加上这段
    fmt.locale = [[NSLocale alloc] initWithLocaleIdentifier:@"en_US"];
    NSDate *createdDate = [fmt dateFromString:_created_at];
    
    // 2..判断微博发送时间 和 现在时间 的差距
    if (createdDate.isToday) { // 今天
        if (createdDate.deltaWithNow.hour >= 1) {
            return [NSString stringWithFormat:@"%d小时前", (int)createdDate.deltaWithNow.hour];
        } else if (createdDate.deltaWithNow.minute >= 1) {
            return [NSString stringWithFormat:@"%d分钟前", (int)createdDate.deltaWithNow.minute];
        } else {
            return @"刚刚";
        }
    } else if (createdDate.isYesterday) { // 昨天
        fmt.dateFormat = @"昨天 HH:mm";
        return [fmt stringFromDate:createdDate];
    } else if (createdDate.isThisYear) { // 今年(至少是前天)
        fmt.dateFormat = @"MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    } else { // 非今年
        fmt.dateFormat = @"yyyy-MM-dd HH:mm";
        return [fmt stringFromDate:createdDate];
    }
}

-(NSString *)description
{
    return [NSString stringWithFormat:@"createdTime:%@, created_at:%@, source:%@",self.createdTime, self.created_at,self.source];
}

MJCodingImplementation
@end






