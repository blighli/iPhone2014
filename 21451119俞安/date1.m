//
//  date1.m
//  homework1
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "date1.h"
@interface date1()
{
    NSMutableArray *calofyear;
}
@end

@implementation date1

@synthesize monthinchinese;
@synthesize years;


-(int)daysOfMonth:(int)month inYear:(int)year {
    
    switch (month) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 10:
        case 12:
            return 31;
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        case 2:
            if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
                return 29;
            } else {
                return 28;
            }
    }
    return 0;
}

-(id)initWithyear:(int)year{
    
    self = [super init];
    
    
    if (self) {
        calofyear=[[NSMutableArray alloc]init];
        for (int i=1; i<=12; i++) {
        [calofyear addObject:[self makeCalanderAtMonth:i andYears:year]];
            
         monthinchinese= [[NSArray alloc] initWithObjects:@"一", @"二", @"三", @"四", @"五", @"六", @"七", @"八", @"九", @"十", @"十一", @"十二", nil];
        }
        years=year;
        
    }
    
    return self;
}

-(NSMutableArray*)makeCalanderAtMonth:(int)month andYears:(int)year
{
        NSMutableArray *calofmonth=[[NSMutableArray alloc]init];
    if (month > 0 && month<= 12 && year > 0 && year <= 9999)
    {
        
        NSCalendar *calendar=[[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        NSDateComponents *comp=[[NSDateComponents alloc]init];
        [comp setYear:year];
        [comp setMonth:month];
        
        NSDate *date=[calendar dateFromComponents:comp ];
       
             //计算当月的天数
        int days=[self daysOfMonth:month inYear:year];
     //第一天是礼拜几
        NSDateComponents *firstdayofmonth =
        [calendar components:NSWeekdayCalendarUnit fromDate:date];
        NSInteger firstday=[firstdayofmonth weekday];
     //每个月日历格式
        int j=1;
        for (int i=0; i<6; i++) {
        //第一行 的格式
            if (i==0) {
                NSMutableString *firstrow=[[NSMutableString alloc]init];
                int daysoffirstrow=8-firstday;
                int spaceoffirstrow=7-daysoffirstrow;
                for (int i=0; i<spaceoffirstrow; i++) {
                    [firstrow appendString:@"   "];
                }
                for (int i=0; i<daysoffirstrow; i++) {
                    [firstrow appendString:[NSString stringWithFormat:@" %d ",j]];
                    j++;
                    
                }
                [calofmonth addObject:firstrow];
               
                
            }
            else
            {
                NSMutableString *otherrow=[[NSMutableString alloc]init];
                for (int i=0; i<7; i++) {
                    if (j<=days) {
                        if (j<10) {
                            
                            [otherrow appendString:[NSString stringWithFormat:@" %d ",j]];
                            j++;
                        }
                        else{
                        [otherrow appendString:[NSString stringWithFormat:@"%d ",j]];
                        j++;
                        }
                    }
                    else
                        [otherrow appendString:@"   "];
                }
                [calofmonth addObject:otherrow];
            }
            
        }
            }
        
    else
        NSLog(@"输入错误 ");
    
    return calofmonth;
}


-(void)printallyear
{
    int currentMonth=1;
    printf("                             %d\n",years);
  
    for(int monthCountLine=0;monthCountLine<4;monthCountLine++)
    {
        int midMonth=currentMonth+monthCountLine*3;
        
        NSArray *firstMonth=[calofyear objectAtIndex:midMonth-1];
        NSArray *secondMonth=[calofyear objectAtIndex:midMonth];
        NSArray *thirdMonth=[calofyear objectAtIndex:midMonth+1];
        
        
        for(int i=0;i<=5;i++)
        {
            if(i==0)
            {
                printf("        %s月                  %s月                  %s月\n",
                         [[monthinchinese objectAtIndex:midMonth - 1] UTF8String]
                       , [[monthinchinese objectAtIndex:midMonth] UTF8String]
                       , [[monthinchinese objectAtIndex:midMonth + 1] UTF8String]);
                
                printf("日 一 二 三 四 五 六   日 一 二 三 四 五 六   日 一 二 三 四 五 六 \n");
            }
            
            NSMutableString *rows=[[NSMutableString alloc]init];
            [rows appendFormat:@"%@  ",[firstMonth objectAtIndex:i]];
            [rows appendFormat:@"%@  ",[secondMonth objectAtIndex:i]];
            [rows appendFormat:@"%@  ",[thirdMonth objectAtIndex:i]];
            [rows appendString:@"\r\n"];
            
            printf("%s",[rows UTF8String]);
        }
    }
}


-(void)printcalanderformonth:(int)month
{
    if (month > 0 && month <= 12) {
        printf("     %s月 %d\n", [[monthinchinese objectAtIndex:month - 1] UTF8String],years);
        printf("日 一 二 三 四 五 六\n");
        NSArray *currentMonthArray = calofyear;
        
        NSArray *rowMonthArray = [currentMonthArray objectAtIndex:month-1];
        for (int j = 0; j < rowMonthArray.count; j++) {
            printf("%s", [[rowMonthArray objectAtIndex:j] UTF8String]);
            printf("\r\n");
        }
    }    else
            NSLog(@"请输入1-12中的一个整数");


}





@end



