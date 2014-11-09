//
//  Cal.h
//  Project2
//
//  Created by Cocoa on 14/11/9.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject


//中缀表达式转后缀表达式
-(NSString*)inFix2PostFix:(NSString*) inFixString;

//运算符优先级
-(int)precedence:(NSString *) op;

//计算后缀表达式的值
-(NSDecimalNumber*) compute:(NSString*) postFixString;

@end
