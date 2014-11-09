//
//  Stack.h
//  calc
//
//  Created by zhou on 14/11/6.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
@property NSMutableArray *stackArr;
- (id)init;
- (void)push:(id)item;
- (void)pop;
- (BOOL)isEmpty;
- (void)empty;
-(id) top;
@end
