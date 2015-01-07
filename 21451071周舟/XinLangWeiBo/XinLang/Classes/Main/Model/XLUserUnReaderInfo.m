//
//  XLUserUnReaderInfo.m
//  XinLang
//
//  Created by 周舟 on 14-10-12.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLUserUnReaderInfo.h"
#import "MJExtension.h"

@implementation XLUserUnReaderInfo


-(int)messageCount
{
    return  self.dm + self.cmt + self.mention_cmt + self.mention_status;
}
@end
