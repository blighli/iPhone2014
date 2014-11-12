//
//  MyStack.h
//  Calculator
//
//  Created by turbobhh on 11/5/14.
//  Copyright (c) 2014 org.bhh.homework. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyStack : NSObject
@property (readonly,nonatomic) id top;
@property (readonly,nonatomic) BOOL isEmpty;
@property (readonly,nonatomic) int count;

-(void)push:(id)object;
-(id)pop;
-(BOOL)isEmpty;
@end
