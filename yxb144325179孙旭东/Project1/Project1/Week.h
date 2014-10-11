//
//  Week.h
//  Project1
//
//  Created by  sephiroth on 14-10-7.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Module : NSObject
{
    int month;
    int firstDay;
    int posation;
    int days;
    int year;
    NSString *output;
}

- (void) setFirstDay:(int) day andMonth:(int) m andYear:(int) y;
- (void) setOutput;
- (void) resetPosation;

@end
//月份模块，将每个月的输出都进行模块化，posiation用于确定模块位置以方便调整光标位置
//二次改版后出现部分冗余数据

@interface Week : NSObject
{
    int year;
    int month;
    int num;
    Module *md[12];
}

- (void) setYear:(int) newYear;
- (void) setMonth:(int) newMonth;
- (void) setNum:(int) newNum;
- (int) forFirstDay:(int) d andMonth:(int) m;
- (void) print;
@end
//日历类，控制整个日历的输出格式


