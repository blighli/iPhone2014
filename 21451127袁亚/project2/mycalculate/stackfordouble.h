//
//  stackfordouble.h
//  mycalculate
//
//  Created by Frank Yuan on 14-11-6.
//  Copyright (c) 2014年 Frank Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface stackfordouble : NSObject
@property int top;
@property int size;

-(id)init;
-(void)push:(double)element;
-(BOOL)IsFull;
-(BOOL)IsEmpty;
-(double)pop;
-(BOOL)AddSize;
-(double)gettop;
@end