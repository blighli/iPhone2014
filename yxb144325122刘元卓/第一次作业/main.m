//
//  main.m
//  Calendar
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 刘元卓. All rights reserved.
//

#import <Foundation/Foundation.h>

int cal(int day,int month,int year){
    int a=0;
    if ((month==1)||(month==2)) {
        month+=12;
        year--;
    }
    a=(day+2*month+3*(month+1)/5+year+year/4-year/100+year/400+1)%7;
    return a;
    
}

void print(int month,int year){
    int a=0,b=0,c=1;
    char *Month[]={"月","一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    printf("     %s,%d\n",Month[month],year);
    printf("日 一 二 三 四 五 六\n");
    a=cal(1, month, year);
    for (int i=0;c<=31; i++) {
        if (a-b>0) {
            printf("   ");
            b=b+1;
            
        }
        else {
            printf("%2d ",c);
            c=c+1;
        }
        if ((i+1)%7==0) {
            printf("\n");
        }
        
    }
    printf("\n");
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        
        NSDate *date = [NSDate date];
        
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        NSDateComponents *comps  = [calendar components:unitFlags fromDate:date];
        
        int month =(int) [comps month];
        int year =(int) [comps year];
        //char isMonth[]="-m";
        char m[]="-m";
        
        // insert code here...
        //NSLog(@"Hello, World!");
        switch (argc) {
            case 1:
                print(month, year);
                break;
            case 2:
                NSLog(@"%s",argv[1]);
                break;
            case 3:
                if (strcmp(argv[1],m)==0) {
                   print(atoi(argv[2]),year);
                }else{
                  print(atoi(argv[1]),atoi(argv[2]));
                }
                break;
                
            default:
                break;
        }
    
    }
    return 0;
}
