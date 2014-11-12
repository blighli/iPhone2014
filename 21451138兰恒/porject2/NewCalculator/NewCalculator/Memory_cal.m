//
//  Memory_cal.m
//  NewCalculator
//
//  Created by lh on 14-11-6.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "Memory_cal.h"
@interface Memory_cal()
@property (nonatomic,strong)NSNumber* memory_number;
@end

@implementation Memory_cal
@synthesize memory_number = _memory_number;
-(NSNumber*)memory_number
{
    if(_memory_number == nil)
        _memory_number = [[NSNumber alloc]initWithDouble:0.0];
    return _memory_number;
}
-(void) memory_add:(double) num
{
    double x = [self.memory_number doubleValue];
    x += num;
    self.memory_number = [[NSNumber alloc]initWithDouble:x];
    
}
-(void) memory_minus:(double) num
{
    double x = [self.memory_number doubleValue];
    x -= num;
    self.memory_number = [[NSNumber alloc]initWithDouble:x];
    
}
-(void) memory_clean
{
    self.memory_number = [[NSNumber alloc]initWithDouble:0];
}
-(double) memory_recall
{
    return [self.memory_number doubleValue];
    
}
@end
