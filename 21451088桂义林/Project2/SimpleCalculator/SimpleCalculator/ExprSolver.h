//
//  ExprSolver.h
//  SimpleCalculator
//
//  Created by YilinGui on 14-11-4.
//  Copyright (c) 2014年 Yilin Gui. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ExprSolver : NSObject

- (double)getValueOfExpr:(NSString *)expr;
- (NSString *)getValueOfExprInStringFormat:(NSString *)expr;

@end
