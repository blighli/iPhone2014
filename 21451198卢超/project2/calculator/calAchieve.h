//
//  calAchieve.h
//  calculator
//
//  Created by ___FULLUSERNAME___ on 14-11-5.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface calAchieve : NSObject

-(NSString *)result:(NSString *)expression;
-(void)mClear;
-(void)mPlus:(double)m;
-(void)mMinus:(double)m;
-(double)mRead;
-(BOOL)operate1:(NSString *)op1 operate2:(NSString *)op2;

@end
