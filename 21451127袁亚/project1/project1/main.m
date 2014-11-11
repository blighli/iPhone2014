//
//  main.m
//  project1
//
//  Created by Frank Yuan on 10/25/12.
//  Copyright (c) 2012 Frank Yuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "print_result.h"

void output_month_year(int month,int year){
    print_result* result=[[print_result alloc]init];
    [result setM_year:year];
    [result setM_month:month];
    printf("<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
    [result showResult];
}
void output_all_month_of_year(int year){
    for (int i=1; i<=12; i++) {
        output_month_year(i, year);
    }
}
void output_month_of_current_year(int month){
    output_month_year(month, 2014);
}


int main(int argc, const char * argv[])
{
    @autoreleasepool {
        int totalargs=argc;
        //NSDate* now=[NSDate date];
        NSDateComponents* comps=[[NSCalendar currentCalendar]components:NSMonthCalendarUnit|NSYearCalendarUnit fromDate:[NSDate date]];
        NSInteger month=[comps month];
        NSInteger year=[comps year];
        if (argc==1) {
            return 0;
        }
        NSString* firstarg=[NSString stringWithCString:argv[1] encoding:NSUTF8StringEncoding];
        if(![firstarg isEqualToString:@"cal"]){
            NSLog(@"Invalid arguments");
            return 0;
        }
        if (totalargs==2) {
            output_month_year(month, year);
            return 0;
        }else if(totalargs==3){
            int tmp= atoi(argv[2]);
            if(tmp<0){
                NSLog(@"Invalid input!\n");
            }else{
                output_all_month_of_year(tmp);
            }
        }else if(totalargs==4){
            NSString* string=[NSString stringWithCString:argv[2] encoding:NSUTF8StringEncoding];
            
            if([string isEqualToString:@"-m"]){
                @try {
                    output_month_year(atoi(argv[3]),year);
                }
                @catch (NSException *exception) {
                    NSLog(@"wrong happened");
                }
                @finally {
                    
                }
            }else
            @try {
                output_month_year(atoi(argv[2]),atoi(argv[3]));
                
            }
            @catch (NSException *exception) {
                NSLog(@"something wrong");
            }
            @finally {
                //NSLog(@"something wrong happened!");
            }
            
        }
        printf("<<<<<<<<<<<<<<<<<<<<<<<<<<\n");
    }
    return 0;
}
