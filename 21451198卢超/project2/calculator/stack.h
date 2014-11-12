//
//  stack.h
//  calculator
//
//  Created by ___FULLUSERNAME___ on 14-11-5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject {
    NSMutableArray* stack_array;
    int count;
}
- (void)push:(id)anObject;
- (NSString *)pop;
-(NSString *)top;
- (void)clear;
-(BOOL)empty;
@property (nonatomic, readonly) int count;
@end
