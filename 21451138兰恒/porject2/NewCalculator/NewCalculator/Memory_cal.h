//
//  Memory_cal.h
//  NewCalculator
//
//  Created by lh on 14-11-6.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Memory_cal : NSObject

-(void) memory_add:(double) num;
-(void) memory_minus:(double) num;
-(void) memory_clean;
-(double) memory_recall;
@end
