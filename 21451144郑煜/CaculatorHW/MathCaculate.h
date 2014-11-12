//
//  MathCaculate.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-9.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MathCaculate : NSObject

@end


@interface NSStack : NSObject {
    NSMutableArray* m_array;
    int count;
}

- (void)push:(int *)anObject;
- (char *)top;
- (void)pop;
- (int)empty;
- (void)clear;

@property (nonatomic, readonly) int count;

@end

