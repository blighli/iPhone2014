//
//  XLBaseParam.h
//  XinLang
//
//  Created by 周舟 on 9/12/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XLBaseParam : NSObject

@property (nonatomic, copy)NSString *access_token;
+ (instancetype)param;

@end
