//
//  CalculatorBrain.h
//  Calculator
//
//  Created by JANESTAR on 14-11-5.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject{
    NSMutableArray *operandStack;
    NSMutableArray *operatorStack;
    NSMutableArray *result;
    NSMutableArray *origin;
    NSMutableArray *operandStack_copy;
    NSMutableArray *operatorStack_copy;
    
}
@property (nonatomic,strong)NSMutableArray *operandStack;
@property (nonatomic,strong)NSMutableArray *operatorStack;
@property (nonatomic,strong)NSMutableArray *result;
@property (nonatomic,strong)NSMutableArray *origin;
@property (nonatomic,strong)NSMutableArray *operandStack_copy;
@property (nonatomic,strong)NSMutableArray *operatorStack_copy;
-(void)pushOperand:(NSString*)operand;
-(void)pushOperator:(NSString*)oper;
-(void)pushResult:(double)re;
-(void)pushOrigin:(NSString*)ori;
-(int)getPrior:(NSString*)s;
-(double)popResult;

@end
