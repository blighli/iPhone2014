//
//  Cal.h
//  cal
//
//  Created by rth on 14-10-12.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Cal : NSObject
-(NSMutableArray *) Year:(NSInteger) year andMonth:(NSInteger) month;
-(void) showYear:(NSInteger) year andMonth:(NSInteger) month;//（用于展现局部月份）
-(void) showYear:(NSInteger) year; //(用于展现全年)
-(void) Error; // 时间输入有误提示函数
-(NSInteger) maxa:(NSInteger) a andb:(NSInteger) b andc:(NSInteger) c;

@end

