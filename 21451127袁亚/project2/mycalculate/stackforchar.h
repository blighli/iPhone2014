//
//  stack.h
//  mycalculate
//
//  Created by Frank Yuan on 14-11-5.
//  Copyright (c) 2014年 Frank Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "unit.h"
@interface stackforchar : NSObject
@property int top;
@property int size;

-(id)init;
-(void)push:(char)element;
-(BOOL)IsFull;
-(BOOL)IsEmpty;
-(char)pop;
-(BOOL)AddSize;
-(char)gettop;
@end
