//
//  main.m
//  cal
//
//  Created by jianggongliang on 14-10-11.
//  Copyright (c) 2014年  All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isProperMonth(const char *monthStr){
    NSString *str=[[NSString alloc] initWithUTF8String:monthStr];
    NSInteger month=[str integerValue];
    if(month>13||month<=0){
        return NO;
    }
    return YES;
}

BOOL isProperYear(const char *yearStr){
    NSString *str=[[NSString alloc] initWithUTF8String:yearStr];
    NSInteger year=[str integerValue];
    if(year>9999||year<=0){
        return NO;
    }
    return YES;
}

BOOL isLeapYear(NSInteger year){
    return ((year & 3)==0)&&((year%100)!=0 || (year%400)==0);
}

NSInteger lengthOfMonth(NSInteger month,NSInteger year){
    switch (month) {
        case 2:
            return (isLeapYear(year)?29:28);
        case 4:
        case 6:
        case 9:
        case 11:
            return 30;
        default:
            return 31;
    }
}
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSArray *months=[NSArray arrayWithObjects:
                         @" ",@"January",@"February",@"March",
                         @"April",@"May",@"June",@"July",
                         @"Augest",@"September",@"October",@"November",@"December",nil];
        NSArray *weeks=[NSArray arrayWithObjects:@" ",@"Su",@"Mo",@"Tu",
                                                 @"We",@"Th",@"Fr",@"Sa", nil];
        NSInteger lengthOfWeek=7;
        //日期组件，用于取出具体得月份，年份
        unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
        //用于标识输出多少月份
        NSInteger howManyMonth=1;
        
         //  用于清空 output 的内容
        NSRange deleteRect;
        
        
        //获取当前时间，作为默认日期
        NSDate *now=[NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        

        NSDateComponents *components = [gregorian components:units fromDate:now];
        
        NSInteger presentMonth=[components month];
        NSInteger presentYear=[components year];
        
        //用于缓存日期格式
        NSMutableString *string=[[NSMutableString alloc] init];
        
        
        if(argc==1){//cal
            [string appendFormat:@"%ld-%ld-%d 08:00:00 +0000",presentYear,presentMonth,1];
        }else if(argc==2){//cal 2014
            if(isProperYear(argv[1])==NO){
                NSLog(@"year not in range 1..9999!");
                exit(0);
            }
            howManyMonth=12;
            [string appendFormat:@"%s-%d-%d 08:00:00 +0000",argv[1],1,1];
        }else if(argc==3){
            if(strcmp(argv[1],"-m")==0){ //cal -m 10
                if(isProperMonth(argv[2])==NO){
                    NSLog(@"the month not in range 1..12!");
                    exit(0);
                }
               [string appendFormat:@"%ld-%s-%d 08:00:00 +0000",presentYear,argv[2],1];
            }else{ //cal 10 2014
                if(isProperMonth(argv[1])==NO){
                    NSLog(@"the month not in range 1..12!");
                    exit(0);
                }
                if(isProperYear(argv[2])==NO){
                    NSLog(@"year not in range 1..9999!");
                    exit(0);
                }
                [string appendFormat:@"%s-%s-%d 08:00:00 +0000",argv[2],argv[1],1];
            }
        }
        
        NSDate *startDate=[[NSDate alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
        
        NSInteger lengthofThisMonth;// 每月多少天
        NSInteger firstWeekDay;//每月第一天星期几
        
        // 保存输出内容
        NSMutableString *output=[[NSMutableString alloc] init];
        
        do{
            
            components = [gregorian components:units fromDate:startDate];
            //[components setHour:8];
            
            lengthofThisMonth=lengthOfMonth([components month], [components year]);
            
            firstWeekDay=[components weekday];
            
            
            [output appendString:@"\n"];
            [output appendFormat:@"   %@ %ld\n",months[[components month]],[components year]];
            for(NSInteger i=1;i<=lengthOfWeek;i++){
                [output appendFormat:@"%@ ",weeks[i]];
            }
            [output appendString:@"\n"];
            
            BOOL firstLine=YES;
            for(NSInteger i=1;i<lengthofThisMonth;){
                NSInteger j=1;
                //找到每月的第一天
                if(firstLine==YES){
                    for( j=1;j<=lengthOfWeek;j++){
                        if(j==firstWeekDay) break;
                        [output appendString:@"   "];
                        
                    }
                    firstLine=NO;
                }
                
                for(;j<=lengthOfWeek;j++){
                    if(i>=10){
                        [output appendFormat:@"%ld ",i];
                    }else{
                        [output appendFormat:@" %ld ",i];
                    }
                    i++;
                    if(i>lengthofThisMonth) break;
                    
                }
                [output appendString:@"\n"];
            }
            NSLog(@"%@",output);
            
            deleteRect.location=0;
            deleteRect.length=[output length]-1;
            //清空缓存，并为下一个月做准备
            [output deleteCharactersInRange:deleteRect];
            [components setMonth:([components month]+1)];
            [components setDay:1];
            startDate=[gregorian dateFromComponents:components];
            howManyMonth--;
        }while (howManyMonth>=1);
    }
    return 0;
}


