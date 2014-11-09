//
//  Calculator.h
//  Calculator
//
//  Created by turbobhh on 11/5/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject

+(NSString*)calculate:(NSString*)exp;
+(NSString*)mr;
+(void)mc;
+(void)mPlus:(NSString*)plus;
+(void)mSubtract:(NSString*)sub;

@end
