//
//  Calc.h
//  Project2-calc
//
//  Created by  ws on 11/7/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calc : NSObject
+ (bool) isOperator:(unichar)c;
+ (bool) isNumber:(unichar)c;
+ (bool) isBrackets:(unichar)c;
+ (double) readNumber:(NSString*)s atIndex:(int*)index;
+ (double) multiplication:(NSString*)s atIndex:(int*)index;
+ (double) additon:(NSString*)s;
+ (double) calculate:(NSString*)s;

@end
