//
//  Calculator.h
//  Calculator
//
//  Created by 陈聪荣 on 14/11/12.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject{
    double momery;
}

//带括号的浮点型四则混合运算
- (double) multiStepOperation:(NSString *) expression;
//单步操作
- (double) singleStepOperation:(NSString *) oldValue withOper:(NSString *) oper;
@end
