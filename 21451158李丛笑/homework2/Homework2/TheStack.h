//
//  TheStack.h
//  Homework2
//
//  Created by 李丛笑 on 14/11/7.
//  Copyright (c) 2014年 lcx. All rights reserved.
//

#ifndef Test_TheStack_h
#define Test_TheStack_h
@interface TheStack : NSObject


-(void) Push : (char *)s Ch : (char)ch Top:(int)top;
-(char) Pop : (char *)s Top:(int)top;
-(int)PriorityCompare:(char *)new Str2:(char *)old;

@end

#endif
