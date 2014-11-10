//
//  main.m
//  HomeworkOne
//
//  Created by HJ on 14-10-7.
//  Copyright (c) 2014年 HJ. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Printcalendar.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date=[NSDate date];
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        
        NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit |
        NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;
        
        comps = [calendar components:unitFlags fromDate:date];
        int nowmonth = (int)[comps month];
        int nowyear = (int)[comps year];
        id print = [Printcalendar new];
        
        //NSLog(@"%d",year);
        
        if(argc==1){
            [print Printmounthcalendar:nowyear : nowmonth];
        }else if(argc==2){ //cal year
            
            NSString *argvOne = [NSString stringWithUTF8String:argv[1]];
            NSInteger year = [argvOne integerValue];
            
            if (year >0 && year < 10000) {
               [print Printyearcalendar: (int)year];
            }else{
                    printf("cal: year %ld not in range 1..9999\n",(long)year);
            }
            
            
        }else if(argc==3){ //cal -m mounth     and     call mounth year
            NSString *argvOne = [NSString stringWithUTF8String:argv[1]];
            NSString *argvTwo = [NSString stringWithUTF8String:argv[2]];
            NSInteger one = [argvOne integerValue];
            NSInteger two = [argvTwo integerValue];
  
                if ([argvOne isEqualToString:@"-m"] ){
                    if (two>0 && two<=12) {
                        [print Printmounthcalendar:nowyear : (int)two ];
                    }else{
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
                    }
                }else if(one>0 && one<=12){
                    
                    if (two >0 && two < 10000) {
                        [print Printmounthcalendar:(int)two : (int)one ];
                    }else{
                        printf("cal: year %ld not in range 1..9999\n",(long)two);
                    }
                }else{
                    printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
                }
 
            
        }else{ //不是0 1 2 个参数
            printf("usage: cal [year]\n");
            printf("       cal [-m month] [year]\n");
        }
        
    
    }
    return 0;
}
