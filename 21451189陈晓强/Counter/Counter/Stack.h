//
//  Stack.h
//  Counter
//
//  Created by 陈晓强 on 14/11/8.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
@property (strong, nonatomic) NSMutableArray *stack;
@property (nonatomic) NSUInteger stackTop;
- (NSString *)pop;
- (BOOL)isEmpty;
- (void)push:(NSString *)symbol;
- (NSString *)getTop;
@end
