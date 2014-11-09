//
//  cal.m
//  cal
//
//  Created by zhou on 14-10-9.
//  Copyright (c) 2014年 zhou. All rights reserved.
//

#import "cal.h"




@implementation Cal


//计算该月有几天
- (int ) DayCountOfMonth:(int) month ofYear: (int)year
{
    int count =0;
    // component => calendar => date 获得该年该月的第一天的date
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    
    //NSLog(@"%@",components);
    
    NSCalendar *calendar = [[NSCalendar alloc]
                            initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    
    // NSLog(@"%@",date);
    
    //获得该年该月的一个月后的date
    NSDateComponents *comAddMonth = [[NSDateComponents alloc] init];
    [comAddMonth setMonth:1];
    NSDate *oneMonthFromNow = [calendar dateByAddingComponents:comAddMonth
                                                        toDate:date
                                                       options:0];
    //NSLog(@"%@",oneMonthFromNow);
    NSCalendarUnit units = NSDayCalendarUnit;
    NSDateComponents *compCalculate = [calendar components:units
                                                  fromDate:date
                                                    toDate:oneMonthFromNow
                                                   options:0];
    // NSLog(@"It has been %ld day ",[compCalculate day]);
    
    count = (int)[compCalculate day];
    return count;
    
}


//计算该月的数组表示
- (void) getArrayOfMonth: (int) month ofYear: (int) year theArray:(int [])array
{
    // component => calendar => date 获得该年该月的第一天的date
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setMonth:month];
    [components setYear:year];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate *date = [calendar dateFromComponents:components];
    
    // date => component => 获得该天是星期几
    NSCalendarUnit units = NSWeekdayCalendarUnit;
    NSDateComponents *weekCom = [calendar components:units fromDate:date];
    
    int weekDayOnDay1 = (int)[weekCom weekday]-1;
    
    int DaysCountOfMonth =[self DayCountOfMonth :month ofYear:year];
    
    //init the month array
    for (int i= weekDayOnDay1 ,j = 1 ; i<MAXSIZE; ++i,++j) {
        if (j<=DaysCountOfMonth) {
            array[i] = j;
        }
    }
    
    
    
}

//获得一年的数组表示
- (void) getArrayOfYear: (int) year theArray:(int [][MAXSIZE])array
{
    for(int i =0;i<12;i++)
    {
        [self getArrayOfMonth:i+1 ofYear:year theArray:array[i]] ;
    }
    
}



// terminal 输出函数
// 无需实例化
// 如果输出某一年的月历，请将month 设为0；（oc 函数参数没有默认值 = =||）
+ (void ) showCal:(int) month ofYear: (int)year
{
    id cal = [[Cal alloc] init];
    
    int array[MAXSIZE]={};
    int arrayOfYear[12][MAXSIZE] = {};
    
    if (month == 0) { // 输出该年的月历
        
        printf("                            %4d\n\n",year);
        [cal getArrayOfYear:year theArray:arrayOfYear];
        for(int k =0;k<12;k+=3)
        {
            for(int l =0; l<3;l++)
            {
                printf("        %s         ",MonthArray[k+l+1]);
                
            }
            printf("\n");
            
            for(int l =0; l<3;l++)
            {
                printf("日 一 二 三 四 五 六  ");
            }
            printf("\n");
            
            
            for (int i=0; i<MAXSIZE; i+=7) {
                for(int l =0; l<3;l++)
                {
                    for (int j=0; j<7; ++j) {
                        if(arrayOfYear[k+l][i+j]==0)
                        {
                            printf("   ");//just 3 space
                        }
                        else{
                            printf("%2d ",arrayOfYear[k+l][i+j]);
                        }
                    }
                    printf(" ");
                    
                }
                printf("\n");
            }
        }
    }
    else  // 输出某一个月的月历
    {
        printf("     %5s %5d\n",MonthArray[month],year);
        printf("日 一 二 三 四 五 六 \n");
        [cal getArrayOfMonth:month ofYear:year theArray:array];
        
        for (int i=0; i<MAXSIZE; i+=7) {
            for (int j=0; j<7; ++j) {
                if(array[i+j]==0)
                {
                    printf("   ");//just 3 space
                }
                else{
                    printf("%2d ",array[i+j]);
                }
            }
            printf("\n");
        }
        
    }
    
    
    
    
}
@end
