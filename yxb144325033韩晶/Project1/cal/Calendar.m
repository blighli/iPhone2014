//
//  Calendar.m
//  cal
//
//  Created by hanxue on 14-10-11.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar
 char *Month[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
 NSInteger Day[]={31,28,31,30,31,30,31,31,30,31,30,31};

-(NSString *) getTodayDate
{
    // NSDate *data = [NSDate date];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyy-MM"];
    
    NSString *str = [df stringFromDate:[NSDate date]];

    return str;
}

-(void) printCal:(NSString*) dateForm andDecYear:(BOOL) dec
{
    BOOL firstDec = true;
    BOOL addDec =false;
    
    NSInteger weekday[3];
    NSInteger year[3];
    NSInteger month[3];
    
    NSDate *date;
    NSCalendar *cal2 = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
//    NSCalendar *cal3 = [[NSCalendar alloc] init];
    
    if (dec) {
        int count=1;
        int num=0;
        while (count<=12) {
            NSString *StringInt =[NSString stringWithFormat:@"%d",count];
            NSString *dateFormTemp;
            dateFormTemp = [[[dateForm stringByAppendingString:@"-"] stringByAppendingString:StringInt] stringByAppendingString:@"-1 00:00:00 +0"];
            
            //NSLog(dateFormTemp);
            printf("\n");
            date = [[NSDate alloc] initWithString:dateFormTemp];
            NSDateComponents *weekdayComonents = [cal2 components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit) fromDate:date];
            if (year[0]/4==0 && year[0]%100!=0 && firstDec) {
                Month[1]=Month[1]+1;
                addDec =true;
            }
            weekday[num] = [weekdayComonents weekday];
            year[num] = [weekdayComonents year];
            month[num] = [weekdayComonents month];
            num++;
            count++;
            if (num==3) {
                [self printDia:year andMonth:month andWeekDay:weekday andDecAllYear:true andDecFirstTime:firstDec];
                num=0;
                firstDec=false;
            }
        }
    }else{
        date = [[NSDate alloc] initWithString:dateForm];
        
        NSDateComponents *weekdayComonents = [cal2 components:(NSDayCalendarUnit | NSWeekdayCalendarUnit | NSYearCalendarUnit | NSMonthCalendarUnit ) fromDate:date];

        weekday[0] = [weekdayComonents weekday];
//        [weekdayComonents week]
        year[0] = [weekdayComonents year];
        month[0] = [weekdayComonents month];
        
        if (year[0]/4==0 && year[0]%100!=0) {
            Month[1]=Month[1]+1;
            addDec =true;
        }
        [self printDia:year andMonth:month andWeekDay:weekday andDecAllYear:false andDecFirstTime:false];
    }
    if (addDec) {
        Month[1]=Month[1]-1;
    }
//    NSLog(dateForm);
}

-(void) printDia:(NSInteger[]) year andMonth:(NSInteger[]) month andWeekDay:(NSInteger[]) weekday andDecAllYear:(BOOL) decOneYear andDecFirstTime:(BOOL) decFirstTime
{
    //NSLog(@"xyc");
    //NSLog(@"%li %li %li",weekday,year,month);
    NSInteger day[3];
    NSInteger startDay[3]={1,1,1};
    //BOOL firstDec=true;
    BOOL dec[]={true,true,true};
    //BOOL proDataIsNull=false;
    if (decOneYear && decFirstTime) {
        printf("                             %li\n\n",year[0]);
    }
    else if(!decOneYear){
        printf("     %s %li\n",Month[month[0]-1],year[0]);
        printf("日 一 二 三 四 五 六\n");
        day[0]=Day[month[0]-1];
        dec[1]=false;
        dec[2]=false;
    }
    
    if (decOneYear) {
        printf("        %s                  %s                  %s\n",
               Month[month[0]-1],Month[month[1]-1],Month[month[2]-1]);
        printf("日 一 二 三 四 五 六     日 一 二 三 四 五 六     日 一 二 三 四 五 六\n");
        day[0]=Day[month[0]-1];
        day[1]=Day[month[1]-1];
        day[2]=Day[month[2]-1];
    }
    
    while (dec[0]||dec[1]||dec[2]) {
        
        for (int j=0; j<3; j++) {
            if (dec[j]) {
                for (int i=1; i<weekday[j]; i++) {
                    printf("   ");
                }
                
                dec[j] = [self printOneRow: startDay[j] andEndNum:day[j] andWeekNum:weekday[j]];
                startDay[j]=startDay[j]+ 7 -weekday[j]+1;
                weekday[j] = 1;
                printf(" ");
            }else
            {
                printf("                      ");
            }
            
        }
        printf("\n");
        /*
        if (firstDec) {
            for (int j=0; j<3; j++) {
                if (dec[j]) {
                    for (int i=1; i<weekday[j]; i++) {
                        printf("   ");
                    }
                }
                [self printOneRow: startDay[j] andEndNum:day[j] andWeekNum:weekday[j]];
                startDay[j]=startDay[j]+7;
                weekday[j] = 1;
            }
            //
        }
        else
        {
            for (int j=0; j<3; j++) {
                if (!dec[j]) {
                    printf("                      ");
                    continue;
                }else
                {
                    dec[j]=[self printOneRow: startDay[j] andEndNum:day[j] andWeekNum:weekday[j]];
                    if(dec[j])
                    {
                        startDay[j]=startDay[j]+7;
                        weekday[j] = 1;
                    }
                }
            }
            
        }*/
    }
    /*
    printf("     %s %li\n",Month[month-1],year);
    printf("日 一 二 三 四 五 六\n");
    
    NSInteger day = Day[month-1];
    
    if (month==2 && year/4==0 && year%100!=0) {
        day++;
    }
    for (int i=1; i<weekday; i++) {
        printf("   ");
    }
    int i=1;
    while (true) {
        if (i>day) {
            break;
        }
        else if (i<10) {
            printf(" %d ",i);
        }
        else{
            printf("%d ",i);
        }
        i++;
        weekday++;
        if (weekday>7) {
            printf("\n");
            weekday=1;
        }
    }
    
    printf("%li\n",day);
    //NSLog(@"%li",month-1);
    //NSLog(@"     %s",Month[month-1]);
    */
}

-(BOOL) printOneRow:(NSInteger) start andEndNum:(NSInteger) end andWeekNum:(NSInteger) week
{
    while (week<=7) {
        if (start>end) {
            for (NSInteger i=week; i<=7; i++) {
                printf("   ");
            }
            return false;
        }
        else if (start<10) {
            printf(" %li ",start);
        }
        else{
            printf("%li ",start);
        }
        start++;
        week++;
    }
    return true;
}

-(NSString *) getTodayDateHaveTwoData:(NSString*)first andSecond:(NSString*)second
{
    
    if ([first isEqualToString:@"-m"]) {
        NSString *today = [self getTodayDate];
        NSRange rang = NSMakeRange(0, 5);
        return [[today substringWithRange:rang] stringByAppendingString:second];
    }else
    {
        int month = [first intValue];
        if (month>=1 && month<=12) {
            return [[second stringByAppendingString:@"-"] stringByAppendingString:first];
        }
    }
    return NULL;
}

-(void) printByYear:(NSString *)first
{
    [self printCal:first andDecYear:true];
}
@end
