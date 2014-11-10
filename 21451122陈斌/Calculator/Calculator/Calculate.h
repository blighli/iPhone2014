//
//  NSDecimalNumber+Calculate.h
//  Calculator
//
//  Created by lqynydyxf on 14/11/7.
//  Copyright (c) 2014年 lqynydyxf. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculate : NSObject 
- (NSDecimalNumber *) add :(NSString*) str1 :(NSString*) str2;
- (NSDecimalNumber *) minus :(NSString*) str1 :(NSString*) str2;
- (NSDecimalNumber *) multiply :(NSString*) str1 :(NSString*) str2;
- (NSDecimalNumber *) devide :(NSString*) str1 :(NSString*) str2;
- (NSDecimalNumber *) calculate :(NSString *) operator :(NSMutableArray *) num;
@end
