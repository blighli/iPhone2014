//
//  DrawPic.m
//  Project1
//
//  Created by xvxvxxx on 14-10-8.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "DrawPic.h"

@implementation DrawPic
//日历图像绘制
-(void)draw{
    char *theMonth[12] = {"一","二","三","四","五","六","七","八","九","十","十一","十二"};
    printf("     %s月 %ld     \n",theMonth[self.month-1],self.year);
    printf("日 一 二 三 四 五 六\n");
    int dayNumber = 1;
    NSInteger theWeekDay = [self weekDay]%7;
    NSInteger firstRowBlank = [self weekDay]%7;
    //打印第一行
    while (firstRowBlank--) {
        printf("   ");
    }
    for (; theWeekDay <= 6; theWeekDay++,dayNumber++) {
        printf("%2d ",dayNumber);
        if (theWeekDay == 6) {
            printf("\n");
        }
    }
    //打印剩下几行
    while (dayNumber<=[self numberOfDayInMonth]) {
        for ( int i=0; i<=6&&dayNumber<=[self numberOfDayInMonth]; i++) {
            printf("%2d ",dayNumber);
            dayNumber++;
            if (i==6) {
                printf("\n");
            }
        }
    }
    printf("\n\n\n");
}
@end