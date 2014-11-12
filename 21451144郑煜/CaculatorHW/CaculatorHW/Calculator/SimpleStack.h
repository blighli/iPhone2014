//
//  SimpleStack.h
//  CaculatorHW
//
//  Created by StarJade on 14-11-8.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//


#import <Foundation/Foundation.h>


@interface SimpleStack : NSObject {
	NSMutableArray *array;
}

@property (readonly, retain) NSMutableArray *array;

- (instancetype) init;
- (void) push:(id) object;
- (id) pop;
- (int) size;
- (void) print;
- (BOOL) empty;
- (id) peek;

@end

