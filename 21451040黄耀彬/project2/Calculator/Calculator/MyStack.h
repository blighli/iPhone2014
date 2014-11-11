//
//  MyStack.h
//  Calculator
//
//  Created by 黄耀彬 on 14-11-8.
//  Copyright (c) 2014年 黄耀彬. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStack : NSObject
{
@private
    int size;
    NSMutableArray *stack;
}

- (id) top;
- (id) topAndPop;
- (void) pop;
- (void) push: (id) element;
- (BOOL) isEmpty;
- (void) clear;

@end