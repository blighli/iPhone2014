//
//  NSMutableArray+stack.h
//  MyCaculate
//
//  Created by LFR on 14/11/7.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSMutableArray (stack)
- (void)push:(id)parm;
- (BOOL)isEmpty;
- (id)top;
- (id)pop;
-(void)clear;
@end
