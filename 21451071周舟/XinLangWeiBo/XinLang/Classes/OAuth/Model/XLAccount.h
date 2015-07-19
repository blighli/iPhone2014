//
//  XLAccount.h
//  XinLang
//
//  Created by 周舟 on 14-9-29.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLAccount : NSObject <NSCoding>

@property (nonatomic,copy) NSString *access_token;
@property (nonatomic, assign) long long expires_in;
@property (nonatomic, assign) long long remind_in;
@property (nonatomic, assign) long long uid;

+ (instancetype) accountWithDict:(NSDictionary *)dict;

- (instancetype) initWithDict:(NSDictionary *)dict;


@end
