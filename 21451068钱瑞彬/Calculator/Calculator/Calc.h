//
//  Calc.h
//  Calculator
//
//  Created by apple on 14-11-6.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#ifndef Calculator_Calc_h
#define Calculator_Calc_h

@interface Calc : NSObject

- (int)cmp: (char)ch;
- (void)change: (NSString*)s1 : (NSMutableString*)s2;
- (double)value: (NSMutableString*)s2;
- (double)cal: (NSString*)s1;

@end

#endif
