//
//  Stack.h
//  Calculator
//
//  Created by Joker on 14/11/4.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Stack : NSObject
{
    NSMutableArray *data;
    NSString *top;
}
@property(strong, nonatomic) NSMutableArray *data;
@property(strong, nonatomic) NSString *top;

-(void) push : (NSString *) object;
-(NSString *) pop ;
-(BOOL) isEmpty;
-(NSString *) getStackTop;
-(void) clearStack;
-(int) getStackCount;

@end
