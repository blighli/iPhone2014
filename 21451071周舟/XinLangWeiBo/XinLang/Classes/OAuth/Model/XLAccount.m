//
//  XLAccount.m
//  XinLang
//
//  Created by 周舟 on 14-9-29.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLAccount.h"

@implementation XLAccount

+ (instancetype)accountWithDict:(NSDictionary *)dict
{
    return [[self alloc] initWithDict:dict];
    
}

- (instancetype)initWithDict:(NSDictionary *)dict
{
    if(self = [super init]){
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
    
}

/**
 @brief	从文件中解析对象的时候调用
 
 @param aDecoder [IN|OUT]
 
 @return self
 */
- (id)initWithCoder:(NSCoder *)aDecoder
{
    if(self = [super init])
    {
        self.access_token = [aDecoder decodeObjectForKey:@"access_token"];
        self.expires_in = [aDecoder decodeInt64ForKey:@"expires_in"];
        self.remind_in = [aDecoder decodeInt64ForKey:@"remind_in"];
        self.uid = [aDecoder decodeInt64ForKey:@"uid"];
 
    }
    
    return self;
}


/**
 @brief	将对象写人文件的时候调用
 
 @param aCoder [IN|OUT] 
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:self.access_token forKey:@"access_token"];
    [aCoder encodeInt64:self.expires_in forKey:@"expires_in"];
    [aCoder encodeInt64:self.remind_in forKey:@"remind_in"];
    [aCoder encodeInt64:self.uid forKey:@"uid"];
    
}
@end
