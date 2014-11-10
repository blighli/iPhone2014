//
//  Stack.m
//  Calculator
//
//  Created by 葛 云波 on 14/11/8.
//  Copyright (c) 2014年 葛 云波. All rights reserved.
//

#import "Stack.h"

@implementation Stack
-(void)init:(NSMutableArray *)s{
    s = [[NSMutableArray alloc]init];
    count = 0;
}
-(void)push:(NSMutableArray *)s element:(NSString *)a{
    [s addObject:a];
    count++;
}
-(NSString*)pop:(NSMutableArray *)s{
    NSString* temp = [s lastObject];
    count--;
    return temp;
}
-(BOOL)isEmpty:(NSMutableArray *)s{
    if(count==0)
        return YES;
    else
        return NO;
}

@end
