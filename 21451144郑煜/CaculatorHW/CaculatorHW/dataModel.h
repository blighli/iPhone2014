//
//  dataModel.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <Foundation/Foundation.h>

// 该类的作用是将得到的字符转化为字符串表达式，并返回需要显示的函数
@interface DataModel : NSObject

/// 初始化
- (instancetype)init;


/*处理输入*/

/// 处理数字和小数点
- (void)addDigit:(char)digit;

/// 处理括号
- (void)addBracket:(char)bracket;

/// 处理运算符
- (void)addOperator:(char)operatr;

/// 处理存储操作
- (void)clearNumberStr;


/*计算 result */
- (void)caculate;


/*提供输出*/

/// 提供当前的运算表达式 expression
@property (copy,nonatomic)NSString* expression;

/// 提供当前运算结果 result
@property (copy,nonatomic)NSString* resultStr;


@end
