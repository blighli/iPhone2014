//
//  Stack.h
//  Calculator
//
//  Created by 葛 云波 on 14/11/8.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject{
    NSMutableArray* stackArray;
    NSInteger count;//记录栈中元素个数，初始值为0；
}
-(void)init:(NSMutableArray*) s;//初始化栈
-(void)push:(NSMutableArray*) s element:(NSString*) a;//压栈
-(NSString*)pop:(NSMutableArray*) s;//出栈
-(BOOL)isEmpty:(NSMutableArray*) s;//判断栈是否为空，是:返回YES

@end
