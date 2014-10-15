//
//  main.m
//  cal
//
//  Created by TOM on 14-10-11.
//  Copyright (c) 2014年 TOM. All rights reserved.
//

#import <Foundation/Foundation.h>

BOOL isMonth(const char *monthStr){
    NSString *str=[[NSString alloc] initWithUTF8String:monthStr];
    NSInteger month=[str integerValue];
    if(month>=13||month<1){
        return 0;
    }
    return 1;
}


BOOL isYear(const char *yearStr){
    NSString *str=[[NSString alloc] initWithUTF8String:yearStr];
    NSInteger year=[str integerValue];
    if(year>9999||year<1){
        return 0;
    }
    return 1;
}


BOOL ruinian(NSInteger year){
    return ((year%4)==0)&&((year%100)!=0 || (year%400)==0);
}


NSInteger lengthOfMonth(NSInteger month,NSInteger year){
    switch (month) {
        case 2:
            return (ruinian(year)?29:28);
        case 4: case 6: case 9:
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
        NSArray *weeks=[NSArray arrayWithObjects:@" ",@"日",@"一",@" 二",
                        @"三",@" 四",@"五",@"六", nil];
        NSInteger lengthOfWeek=7;
        
        unsigned units  = NSMonthCalendarUnit|NSDayCalendarUnit|NSYearCalendarUnit|NSWeekdayCalendarUnit;
        
        NSInteger howManyMonth=1;
        NSRange deleteRect;
        NSDate *now=[NSDate date];
        
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        
        NSDateComponents *components = [gregorian components:units fromDate:now];
        
        NSInteger presentMonth=[components month];
        NSInteger presentYear=[components year];
        NSMutableString *string=[[NSMutableString alloc] init];
        
        
        if(argc==1){
            [string appendFormat:@"%ld-%ld-%d 08:00:00 +0000",presentYear,presentMonth,1];
        }else if(argc==2){
            if(isYear(argv[1])==NO){
                NSLog(@"不合格的年份!");
                exit(0);
            }
            howManyMonth=12;
            [string appendFormat:@"%s-%d-%d 08:00:00 +0000",argv[1],1,1];
        }else if(argc==3){
            if(strcmp(argv[1],"-m")==0){
                if(isMonth(argv[2])==NO){
                    NSLog(@"不合格的月份!");
                    exit(0);
                }
                [string appendFormat:@"%ld-%s-%d 08:00:00 +0000",presentYear,argv[2],1];
            }else{
                if(isMonth(argv[1])==NO){
                    NSLog(@"不合格的月份!");
                    exit(0);
                }
                if(isYear(argv[2])==NO){
                    NSLog(@"不合格的年份!");
                    exit(0);
                }
                [string appendFormat:@"%s-%s-%d 08:00:00 +0000",argv[2],argv[1],1];
            }
        }
        
        NSDate *startDate=[[NSDate alloc] initWithString:[NSString stringWithFormat:@"%@",string]];
        
        NSInteger lengthofThisMonth;
        NSInteger firstWeekDay;
        
    
        NSMutableString *output=[[NSMutableString alloc] init];
        
        do{
            
            components = [gregorian components:units fromDate:startDate];
            
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
            [output deleteCharactersInRange:deleteRect];
            [components setMonth:([components month]+1)];
            [components setDay:1];
            startDate=[gregorian dateFromComponents:components];
            howManyMonth--;
        }while (howManyMonth>=1);
    }
    return 0;
}


