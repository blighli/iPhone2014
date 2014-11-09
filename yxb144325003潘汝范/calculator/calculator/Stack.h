//
//  Stack.h
//  calculator
//
//  Created by Van on 14/11/9.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
    NSMutableArray *array;
}

@property (readonly, retain) NSMutableArray *array;
- (Stack*) init;
- (void) push:(id) object;
- (id) pop;
- (int) size;
- (BOOL) empty;
- (id) peek;
@end
