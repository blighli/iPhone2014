//
//  XLAccountTool.m
//  XinLang
//
//  Created by 周舟 on 14-9-29.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLAccountTool.h"
#import "XLAccount.h"

#define XLAccountFile [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0] stringByAppendingPathComponent:@"account.data"]

@implementation XLAccountTool


+(void)saveAccount:(XLAccount *)account
{

    //归档
    [NSKeyedArchiver archiveRootObject:account toFile:XLAccountFile];
}

+(XLAccount *)account
{
    //利用NSHomeDirectory()也能打印出文件路径
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    //NSLog(@"---XLAccountTool.h--paths:%@", paths);
    
    NSString *filePath = [paths objectAtIndex:0];
    
    NSString *fileName = [filePath stringByAppendingPathComponent:@"account.data"];
    //取出账号
    XLAccount *account = [NSKeyedUnarchiver unarchiveObjectWithFile:fileName];
    //NSLog(@"--XLAccount:%lld",account.remind_in);
    return account;
    
}
@end
