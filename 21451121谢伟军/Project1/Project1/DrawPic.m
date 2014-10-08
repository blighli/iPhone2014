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
    switch (self.month) {
            //当月份是正确时间时
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
        case 10:
        case 11:
        case 12:{
            printf("                  %2ld月  %ld年                      \n",self.month,self.year);
            printf("    ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~\n");
            printf("    Sun    Mon    Tue    Wed    Thu    Fri    Sat\n");
            //            printf("    日  一  二  三  四  五  六\n");
            int dayNumber = 1;
            
            int blankCount =[self weekDay] %7;
            int firstLineCount = (7-[self weekDay])%7;
            if (blankCount !=0) {
                printf("     ");
            }
            
            
            while (blankCount--) {
                printf("       ");
            }
            
            for ( ; dayNumber<=firstLineCount;dayNumber++) {
                printf("%2d     ",dayNumber);
                if (dayNumber == firstLineCount) {
                    printf("\n");
                }
            }
            while (dayNumber<=[self numberOfDayInMonth]) {
                for ( int i=0; i<=6&&dayNumber<=[self numberOfDayInMonth]  ; i++) {
                    printf("     %2d",dayNumber);
                    dayNumber++;
                    if (i==6) {
                        printf("\n");
                    }
                }
            }
            printf("\n\n\n");
        }
            break;
            //当月份非法时 eg 13 12.5
        default:
            printf("E~~~~~~~~~~~~~~~~R~~~~~~~~~~~~~~~~R~~~~~~~~~~~~~~~~O~~~~~~~~~~~~~~~~R   \nThere is something wrong with your input,Please check it!!!!!!!!!!!!!\n\n");
            break;
    }
    
}
@end