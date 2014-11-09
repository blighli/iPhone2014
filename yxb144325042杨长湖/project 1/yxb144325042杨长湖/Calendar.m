//
//  Calendar.m
//  yxb144325042杨长湖
//
//  Created by 杨长湖 on 14-10-10.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

@implementation Calendar

//构建一个月
-(void) buildCalendar:(int)year andMonth:(int)month{
    int firstWeekDay = [self weekDayOfMonth:year andMonth:month];
    int totalDay = [self totalDayOfMonth:year andMonth:month];
    
    int column=firstWeekDay-1;
    int row= 0;
    for (int i=1; i<=totalDay; i++) {
        if(column < 7){
            calendar[row][column]=i;
        }else{
            row++;
            column = 0;
            calendar[row][column]=i;
        }
        column++;
    }

}

//输出一个月
- (void) showCalendar{
    int ifColumnLsat = 0;
    for (int i=0; i<6; i++) {
        for (int j=0; j<7; j++) {
//            if (ifColumnLsat > 6) {
//                printf("\n");
//                ifColumnLsat = 0;
//            }
//            ifColumnLsat++;
            if (calendar[i][j] != 0) {
                [self print:calendar[i][j]];
            }else{
            printf("   ");
            }
        }
        printf("\n");
    }
//    printf("\n");
}

//定义日期输出空格
-(void) print:(int)num{
    if (num < 10) {
        printf(" %d ",num);
    }else{
        printf("%d ",num);
    }
}

//当月第一天星期
-(int) weekDayOfMonth:(int)year andMonth:(int)month{
//1
//    NSDateComponents *comps = [[NSDateComponents alloc]init];
//    [comps setYear:year];
//    [comps setMonth:month];
//    NSDate *date = [calendar dateFromComponents:comps];
//2
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%d/%d/%d",month,1,year];
    NSDate *date = [formatter dateFromString:firstDay];
    
    //NSCalendar *calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDateComponents *compsForWeekday = [cal components:NSWeekdayCalendarUnit fromDate:date];
    
    return (int)[compsForWeekday weekday];
}

//当月天数
- (int) totalDayOfMonth:(int)year andMonth:(int)month{
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%d/%d/%d",month,1,year];
    NSDate *date = [formatter dateFromString:firstDay];

    NSCalendar *c = [NSCalendar currentCalendar];
    NSRange days = [c rangeOfUnit:NSDayCalendarUnit
                           inUnit:NSMonthCalendarUnit
                          forDate:date];
    
    return (int)days.length;
}
//得到属性值
- (int) getCalendarRC:(int)r andc:(int)c{
    
    return calendar[r][c];
}

@end




