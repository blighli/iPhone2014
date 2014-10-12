//
//  main.m
//  homework1
//
//  Created by jingcheng407 on 14-10-11.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "main.h"

@implementation myCal
-(NSInteger) weekOfDay_Zeller:(NSInteger)  year: (NSInteger)  month: (NSInteger)  day{
    if(month == 1 || month == 2)
    {
        year--;
        month += 12;
    }
    NSInteger c = year / 100;
    NSInteger y = year - c * 100;
    NSInteger week = ( c / 4 ) - 2 * c + ( y + y / 4) + (13 * ( month + 1 ) / 5 ) + day - 1;
    while(week < 0){
        week += 7;
    }
    return week %= 7;
}

-(NSInteger) dayOfMonth: (NSInteger)year: (NSInteger)month{
    NSInteger num = 0;
    if (month == 1 || month == 3 || month == 5 || month == 7 || month == 8 || month == 10 || month == 12 ) {
        num = 31;
    }else if (month ==4 || month == 6 || month == 9 || month == 11) {
        num = 30;
    }else if ((year % 4 == 0 && year % 100 != 0) || ( year % 400 == 0)){
        num = 29;
    }else{
        num = 28;
    }
    return num;
}
-(void) myCal1: (NSString*)year: (NSString*)month{
    NSString *dateFormat = @"";
    dateFormat = [dateFormat stringByAppendingString:year];
    dateFormat = [dateFormat stringByAppendingString:@"-"];
    dateFormat = [dateFormat stringByAppendingString:month];
    dateFormat = [dateFormat stringByAppendingString:@"-01 00:00:00 +0000"];
    //NSDate *newDate = [ [ NSDate alloc] initWithString:@"2014-10-01 00:00:00 +0000" ];
    //NSLog(@"%@",newDate);
    NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
    [dateformat setDateFormat:@"yyyy-MM"];
    NSLog(@"%@月 %@",month,year);
    NSLog(@"日 一 二 三 四 五 六");
    myCal *new1 = [[myCal alloc]init];
    NSInteger weekOfDay = [new1 weekOfDay_Zeller:[year integerValue] :[month integerValue]:1];
    NSInteger numOfMonth = [new1 dayOfMonth:[year integerValue] :[month integerValue]];
    
    //NSLog(@"%d",weekOfDay);
    NSString *str = @"";
    if (weekOfDay != 0) {
        for (int j = 0; j < weekOfDay; j++) {
            str = [str stringByAppendingString:@"   "];
        }
        //        NSLog(@"%@",str);
    }
    //NSLog(@"%d",numOfMonth);
    NSInteger printCount = 0;
    while (numOfMonth > printCount) {
        for (int i = weekOfDay; i <= 6; i++) {
            if (printCount < numOfMonth) {
                //str=[str stringByAppendingString:@""];
                str = [str stringByAppendingString:[NSString stringWithFormat:@"%d  ",printCount+1]];
                printCount++;
                weekOfDay++;
            }
            
        }
        NSLog(@"%@",str);
        str = @"";
        weekOfDay = 0;
    }
    NSLog(@"%@",str);
}
@end
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        if (argc == 1 ) {//cal
            NSDate * newDate = [NSDate date];
            NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"yyyy-MM"];
            NSString *newDateOne = [dateformat stringFromDate:newDate];
            NSString *month = [newDateOne substringWithRange:NSMakeRange(5, 2)];
            NSString *year = [newDateOne substringToIndex:4];
            myCal *new1 = [[myCal alloc]init];
            [new1 myCal1:year:month];
        }else if (argc == 2){//cal 2014
            myCal *new1 = [[myCal alloc]init];
            for (int i = 1; i <= 12; i++) {
                [new1 myCal1:[NSString stringWithFormat:@"%d", atoi(argv[1])] :[NSString stringWithFormat:@"%d", i]];
            }
        }else if (argc == 3 && strcmp(argv[1], "-m") == 0){//cal -m 10
            NSDate * newDate = [NSDate date];
            NSDateFormatter *dateformat = [[NSDateFormatter alloc] init];
            [dateformat setDateFormat:@"yyyy-MM"];
            NSString *newDateOne = [dateformat stringFromDate:newDate];
            NSString *year = [newDateOne substringToIndex:4];
            myCal *new1= [[myCal alloc]init];
            [new1 myCal1:year:[NSString stringWithFormat:@"%d", atoi(argv[2])] ];
        }else if(argc == 3 && 1 <= atoi(argv[1])&& atoi(argv[1])<=12){//cal 10 2014
            myCal *new1 = [[myCal alloc]init];
            [new1 myCal1:[NSString stringWithFormat:@"%d", atoi(argv[2])]:[NSString stringWithFormat:@"%d", atoi(argv[1])]];
        }else{
            NSLog(@"参数错误，请重新输入");
        }
    }
    return 0;
}
