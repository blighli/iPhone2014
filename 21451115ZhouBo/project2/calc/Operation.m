//
//  Operation.m
//  calc
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "Operation.h"


@implementation Operation

- (id)initWithOPS:(OPTYPE)op
{
    switch (op)
    {
        case NUL:
            self.name = @"";
            self.priority = NullPri;
            self.isBinaryOperator = NO;
            
            break;

        case PLUS:
            self.name = @"+";
            self.priority = PlusPri;
            self.isBinaryOperator = YES;
            break;
        case MINUS:
            self.name = @"−";
            self.priority = MinusPri;
            self.isBinaryOperator = YES;
            break;
        case MULTIPLY:
            self.name = @"×";
            self.priority = MultiplyPri;
            self.isBinaryOperator = YES;
            break;
        case DIVIDE:
            self.name = @"÷";
            self.priority = DividePri;
            self.isBinaryOperator = YES;
            break;

        case EQUAL:
            self.name = @"=";
            self.priority = EqualPri;
            self.isBinaryOperator = NO;
            break;

        case SGN:
            self.name = @"±";
            self.priority = SgnPri;
            self.isBinaryOperator = NO;
            break;
        case PERCENT:
            self.name = @"%";
            self.priority = PercentPri;
            self.isBinaryOperator = NO;
            break;

        case LBRACE:
            self.name = @"(";
            self.priority = LBracePri;
            self.isBinaryOperator = YES;
            break;
        case RBRACE:
            self.name = @")";
            self.priority = RBracePri;
            self.isBinaryOperator = YES;
            break;
        default:
            break;
    }
    self.opType = op;

    return self;
}

@end
