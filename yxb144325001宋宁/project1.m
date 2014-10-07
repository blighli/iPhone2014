//
//  main.m
//  Cal
//
//  Created by NimbleSong on 14-10-7.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//



#import <Foundation/Foundation.h>

int daytoweek(int d,int m, int y){
    int a=0;
    if ((m==1)||(m==2)) {
        m+=12;
        y--;
    }
    a=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400)%7;//Important code.I dont know why,but it works.
    return a;
}

int DaysinYear(int year,int month){
    if (month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12) {
        return 31;
    }
    if (month == 4||month == 6||month == 9||month == 11) {
        return 30;
    }
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29;
    }
    return 28;
}



int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        char str[50] = {0};
        
        scanf("%[^\n]",str);
        
        NSString *Str = [NSString stringWithUTF8String:str];
        NSString *basic=@"cal";
        NSString *basicSpa=@"cal ";
        NSString *regM=@"cal -m ([0-1]{0,1}[0-9])";
        NSString *regYear=@"cal ([0-9]{0,4})";
        NSString *regYearandMonth=@"cal ([0-1]{0,1}[0-9]) ([0-9]{0,4})";
        
        
        
        NSPredicate *checkM=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regM];
        BOOL isM=[checkM evaluateWithObject:Str];
        
        NSPredicate *checkYear=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regYear];
        BOOL isYear=[checkYear evaluateWithObject:Str];
        
        NSPredicate *checkYearandMonth=[NSPredicate predicateWithFormat:@"SELF MATCHES %@",regYearandMonth];
        BOOL isYearandMonth=[checkYearandMonth evaluateWithObject:Str];
        
        NSDate *date = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
        
        int year =(int) [comps year];
        int month =(int) [comps month];
        //int day=(int) [comps date];
        
        
        
        
        if ([Str isEqualToString:basic ]||[Str isEqualToString:basicSpa ]) {
           
            //Mon,Tues,Wed,Thur,Fri,Sat,Sun
            printf("              %d年%d月\n\n",year,month);
            printf(" Mon  Tues Wed  Thur Fri  Sat  Sun \n");
            int a=daytoweek(1,month,year);
            int cont=0;
            for (int flag=0-a+1; flag<=DaysinYear(year,month); flag++) {
                if (flag>0) {
                    printf("  %02d ",flag);
                }else{
                    printf("     ");
                }
                if (cont==6) {
                    printf("\n");
                    cont=0;
                }else{
                    cont++;
                }
            }
            printf("\n\n");
            NSLog(@"%d",a);
            
        }else if (isM){
            //NSLog(@"-m");
            NSArray *array = [Str componentsSeparatedByString:@" "];
            int MonthValue=[[array objectAtIndex:2] intValue];
            printf("              %d年%d月\n\n",year,MonthValue);
            printf(" Mon  Tues Wed  Thur Fri  Sat  Sun \n");
            int a=daytoweek(1,MonthValue,year);
            int cont=0;
            for (int flag=0-a+1; flag<=DaysinYear(year,MonthValue); flag++) {
                if (flag>0) {
                    printf("  %02d ",flag);
                }else{
                    printf("     ");
                }
                if (cont==6) {
                    printf("\n");
                    cont=0;
                }else{
                    cont++;
                }
            }
            printf("\n\n");
            
        }else if (isYear){
            //NSLog(@"year");
            NSArray *array = [Str componentsSeparatedByString:@" "];
            int YearValue=[[array objectAtIndex:1] intValue];
            for (int i=1; i<=12; i++) {
                printf("              %d年%d月\n\n",YearValue,i);
                printf(" Mon Tues  Wed Thur  Fri  Sat  Sun \n");
                int a=daytoweek(1,i,year);
                int cont=0;
                for (int flag=0-a+1; flag<=DaysinYear(YearValue,i); flag++) {
                    if (flag>0) {
                        printf("  %02d ",flag);
                    }else{
                        printf("     ");
                    }
                    if (cont==6) {
                        printf("\n");
                        cont=0;
                    }else{
                        cont++;
                    }
                }
                printf("\n\n");
            }
        }else if (isYearandMonth){
            //NSLog(@"year and month");
            NSArray *array = [Str componentsSeparatedByString:@" "];
            int YearValue=[[array objectAtIndex:2] intValue];
            int MonthValue=[[array objectAtIndex:1] intValue];
            printf("              %d年%d月\n\n",YearValue,MonthValue);
            printf(" Mon Tues  Wed Thur  Fri  Sat  Sun \n");
            int a=daytoweek(1,MonthValue,YearValue);
            int cont=0;
            for (int flag=0-a+1; flag<=DaysinYear(YearValue,MonthValue); flag++) {
                if (flag>0) {
                    printf("  %02d ",flag);
                }else{
                    printf("     ");
                }
                if (cont==6) {
                    printf("\n");
                    cont=0;
                }else{
                    cont++;
                }
            }
            printf("\n\n");
        }else{
            NSLog(@"Please Check Your Input!");
        }
        
    }
    return 0;
}



