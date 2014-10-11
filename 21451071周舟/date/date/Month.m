//
//  Month.m
//  date
//
//  Created by 周舟 on 14-10-10.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "Month.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation Month

+ (void)year:(int)year month:(int)month weekday:(int)day
{
    int days = 0;
    if(month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12)
    {
        days = 31;
    }else if (month == 2){
        if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0){
            days = 29;
        }else{
            days = 28;
        }
    }else{
        days = 30;
    }
    NSString *yue;
    switch(month){
        case 1:
            yue = @"一";
            break;
        case 2:
            yue = @"二";
            break;
        case 3:
            yue = @"三";
            break;
        case 4:
            yue = @"四";
            break;
        case 5:
            yue = @"五";
            break;
        case 6:
            yue = @"六";
            break;
        case 7:
            yue = @"七";
            break;
        case 8:
            yue = @"八";
            break;
        case 9:
            yue = @"九";
            break;
        case 10:
            yue = @"十";
            break;
        case 11:
            yue = @"十一";
            break;
        case 12:
            yue = @"十二";
            break;
    }
    printf("\n");
    NSLog(@"     %@ 月  %d",yue, year);
    printf(" 日 一 二 三 四 五 六\n");
    int number = 0;
    int temp = day - 1 ;
    //printf(" ");
    while(temp--){
        printf("   ");
    }
    for(int i = 1;i <= days; i ++)
    {
        int row = (i - 1 + day) / 7;
        if(i > 9){
            printf(" %i", i);
        }else{
            printf("  %i", i);
        }
        
        if(number != row)
        {
            printf("\n");
            number = row;
        }
       
        
        
    }
}
@end
