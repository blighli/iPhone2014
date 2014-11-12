//
//  CalculatorMain.h
//  Calculator
//
//  Created by xiaoo_gan on 11/6/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorMain : NSObject
@property (strong, nonatomic) NSMutableArray *numberStack;
@property (strong, nonatomic) NSMutableArray *operationStack;
@property (strong, nonatomic) NSMutableArray *valueStack;
@property (readonly) double memeryNumber;
@property (readonly) double result;
@property (readonly) NSInteger bracketCount;
@property (readonly) NSInteger valueStackLacation;
- (BOOL) isOperation:(NSString *)op;
- (BOOL) isNumber:(NSString *) num;
- (NSInteger) priority:(NSString *)op;
- (void) postfixToSuffix:(NSString *) post;
- (void) addNumberStack:(double) number;
- (void) addOperationStack:(NSString *)operation;
- (NSString *) lastOperationStack;
- (NSString *) subValueStack:(NSString *) postfix index:(NSInteger) i;
- (double) readNumber;
- (void) evalPostfix;
- (NSString *) valueStackAtIndex:(NSInteger) index;
- (void) answerOperation:(NSString *) valueText;
- (void) addBracketCount;
- (void) subBrackCount;
- (void) memClear;
- (void) memAdd: (double) memNum;
- (void) memSub: (double) memNum;
- (void) clearAll;
@end
