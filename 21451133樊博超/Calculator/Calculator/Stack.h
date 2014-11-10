//
//  Stack.h
//  Calculator
//
//  Created by 樊博超 on 14-11-9.
//  Copyright (c) 2014年 樊博超. All rights reserved.
//
#import <Foundation/Foundation.h>
#ifndef Calculator_Stack_h
#define Calculator_Stack_h


@interface Stack : NSObject
-(id)init;
-(NSString *)pop;
-(void)push:(NSString*)obj;
-(void)clear;
-(NSString *)gettop;
-(BOOL)isEmpty;
@end

#endif
