//
//  Calculator.h
//  Machine
//
//  Created by Chen.D.guanhong on 14/11/8.
//  Copyright (c) 2014年 Chen.D.guanhong. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Calculator : NSObject
-(NSMutableArray *)stringParser:(NSString *)str;
-(double)evaluate:(NSMutableArray *)expression;
@end
