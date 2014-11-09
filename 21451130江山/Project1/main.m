//
//  main.m
//  Project1
//
//  Created by 江山 on 10/10/14.
//  Copyright (c) 2014 江山. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calculator.h"
#import "Printer.h"
#import <Foundation/NSDate.h>


void error();

int main(int argc, const char * argv[])
{
    NSDate *date = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents*comps;
    
    // get current year and month
    comps =[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
                       fromDate:date];
    NSInteger year = [comps year];
    NSInteger month = [comps month];
    
    Printer *prt=[Printer new];
    
    switch(argc){
        case 1:
            if(argv[1]=="cal"){
                [prt monthPrint: year: month];
            }else{
                error();
            }
            break;
        case 2:
            sscanf(argv[2], "%d", &year);
            if(argv[1]=="cal"&&year>0&&year<10000){
                [prt yearPrint: year];
            }else if(argv[1]=="cal"&&!(year>0&&year<10000)){
                printf("cal: year 0 not in range 1..9999");
            }else{
                error();
            }
            break;
        case 3:
            if(argv[1]=="cal"&&argv[2]=="-m"){
                sscanf(argv[3], "%d", &month);
                if(month>0&&month<13){
                    [prt monthPrint: year: month];
                }else{
                    printf("%s is neither a month number (1..12) nor a name\n", argv[3]);
                }
            }else if(argv[1]=="cal"){
                sscanf(argv[2], "%d", &month);
                sscanf(argv[3], "%d", &year);
                if(year<1||year>9999){
                    printf("year %d not in range 1..9999", year);
                }else if (month<1||month>12){
                    printf("%d is nither a month number (1..12) nor a name", month);
                }else{
                    [prt monthPrint: year: month];
                }
            }
            break;
        default:
            error();
    }
    return 0;
}

void error(){
    printf("usage: cal [-jy] [[month] year]\n       cal [-j] [-m month] [year]\n       ncal [-Jjpwy] [-s country_code] [[month] year]\n       ncal [-Jeo] [year]");
}

