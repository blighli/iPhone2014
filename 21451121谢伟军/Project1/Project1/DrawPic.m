//
//  DrawPic.m
//  Project1
//
//  Created by xvxvxxx on 14-10-8.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import "DrawPic.h"
@interface DrawPic()
{
    int dayNumber;
    int lineNumber;
}
@end
@implementation DrawPic
//日历图像绘制
-(void)draw{
    char *theMonth[12] = {"一","二","三","四","五","六","七","八","九","十","十一","十二"};
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
            printf("     %s月 %ld     \n",theMonth[self.month-1],self.year);
            printf("日 一 二 三 四 五 六\n");
            
            dayNumber = 1;
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
            break;
            //当月份非法时 eg 13 12.5
        default:
            break;
    }
    
}

+(void)drawTag1{
    printf("        一月                  二月                  三月\n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
}
+(void)drawTag2{
    printf("        四月                  五月                  六月\n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
}
+(void)drawTag3{
    printf("        七月                  八月                  九月\n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
}
+(void)drawTag4{
    printf("        十月                 十一月                十二月\n");
    printf("日 一 二 三 四 五 六  日 一 二 三 四 五 六  日 一 二 三 四 五 六\n");
}

//打印各行的方法 i即表示第几行
-(void)drawLine:(int)i{
    if (i == 1) {
        dayNumber = 1;
        switch (self.month) {
            case 1:
            case 2:
            case 4:
            case 5:
            case 7:
            case 8:
            case 10:
            case 11:
            {   NSInteger theWeekDay = [self weekDay]%7;
                NSInteger firstRowBlank = [self weekDay]%7;
                //打印第一行
                while (firstRowBlank--) {
                    printf("   ");
                }
                for (; theWeekDay <= 6; theWeekDay++,dayNumber++) {
                    printf("%2d ",dayNumber);
                    if (theWeekDay == 6) {
                        printf(" ");
                    }
                }
            }
                break;
            case 3:
            case 6:
            case 9:
            case 12:
            {   NSInteger theWeekDay = [self weekDay]%7;
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
            }
                break;
                
            default:
                break;
        }

    }

    if (i == 2 || i ==3 || i ==4) {
        switch (self.month) {
            case 1:
            case 2:
            case 4:
            case 5:
            case 7:
            case 8:
            case 10:
            case 11:
            {   for ( int i=0; i<=6&&dayNumber<=[self numberOfDayInMonth]; i++,dayNumber++) {
                printf("%2d ",dayNumber);
                if (i == 6) {
                    printf(" ");
                }
            }
            }
                break;
            case 3:
            case 6:
            case 9:
            case 12:
            {   for ( int i=0; i<=6&&dayNumber<=[self numberOfDayInMonth]; i++,dayNumber++) {
                printf("%2d ",dayNumber);
                if (i == 6) {
                    printf("\n");
                }
            }
            }
                break;
                
            default:
                break;
        }

    }

    if (i == 5){
        switch (self.month) {
            case 1:
            case 2:
            case 4:
            case 5:
            case 7:
            case 8:
            case 10:
            case 11:
            {
                if (dayNumber == self.weekDay) {
                    int i = 7;
                    while (i--) {
                        printf("   ");
                    }
                    printf(" ");
                    break;
                }
                for ( int i=0; i<=6; i++,dayNumber++) {
                    if (dayNumber <= [self numberOfDayInMonth]) {
                        printf("%2d ",dayNumber);
                    }
                    else if(i<=6 && dayNumber >= [self numberOfDayInMonth]){
                        printf("   ");
                    }
                    if (i == 6 && dayNumber >= [self numberOfDayInMonth]){
                        printf(" ");
                    }
                }
            }
                break;
            case 3:
            case 6:
            case 9:
            case 12:
            {
                if (dayNumber == self.weekDay) {
                    int i = 7;
                    while (i--) {
                        printf("   ");
                    }
                    printf(" ");
                    printf("\n");
                    break;
                }
                for ( int i=0; i<=6; i++,dayNumber++) {
                    if (dayNumber <= [self numberOfDayInMonth]) {
                        printf("%2d ",dayNumber);
                    }
                    else if(i<=6 && dayNumber >= [self numberOfDayInMonth]){
                        printf("   ");
                    }
                    if (i == 6 && dayNumber >= [self numberOfDayInMonth]){
                        printf(" ");
                    }
                }
                printf("\n");
            }
                break;
                
            default:
                break;
        }
    }

    if (i == 6) {
        switch (self.month) {
        case 1:
        case 2:
        case 4:
        case 5:
        case 7:
        case 8:
        case 10:
        case 11:
        {
            for ( int i=0; i<=6; i++,dayNumber++) {
                if (dayNumber <= [self numberOfDayInMonth]) {
                    printf("%2d ",dayNumber);
                }
                else if(i<=6 && dayNumber >= [self numberOfDayInMonth]){
                    printf("   ");
                }
                if (i == 6 && dayNumber >= [self numberOfDayInMonth]){
                    printf(" ");
                }
        }
}
            break;
        case 3:
        case 6:
        case 9:
        case 12:
        {
            if (dayNumber == self.weekDay) {
                int i = 7;
                while (i--) {
                    printf("   ");
                }
                printf(" ");
                printf("\n");
                break;
            }
            for ( int i=0; i<=6; i++,dayNumber++) {
                if (dayNumber <= [self numberOfDayInMonth]) {
                    printf("%2d ",dayNumber);
                }
                else if(i<=6 && dayNumber >= [self numberOfDayInMonth]){
                    printf("   ");
                }
                if (i == 6 && dayNumber >= [self numberOfDayInMonth]){
                    printf(" ");
                }
            }
            printf("\n");
        }
            break;
            
        default:
            break;
    }

}
}
@end

