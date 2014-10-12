//
//  Utility.m
//  homework1_cal
//
//  Created by yingxl1992 on 14-10-10.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import "MyCal.h"
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String]) 

@implementation MyCal

-(NSString *)addSpace:(NSInteger)n string:(NSString *)str len:(NSInteger)len{
    int left=(n-len)/2;
    int i;
    NSMutableString *str1=[NSMutableString string];
    for (i=1; i<=left; i++) {
        [str1 appendString:@" "];
    }
    [str1 appendString:str];
    i+=len;
    for (; i<=n; i++) {
        [str1 appendString:@" "];
    }
    return str1;
}

-(int)calDayNums:(NSInteger)year month:(NSInteger)month{
    int daynums;
    NSArray *nums=[NSArray arrayWithObjects:@"31",@"28",@"31",@"30",@"31",@"30",@"31",@"31",@"30",@"31",@"30",@"31",nil];
    daynums=[[nums objectAtIndex:month-1] intValue];
    if(month==2){
        if((year%4==0 &&(year%100)!=0)||year%400==0){
            daynums=29;
        }
    }
    return daynums;
}

-(NSString *)printMonth:(NSInteger)month{
    NSArray *mons=[NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",nil];
    NSString *strm;
    strm=[mons objectAtIndex:month-1];
    return strm;
}

-(NSArray *) calOneMonth: (NSInteger)y month:(NSInteger)month type:(NSInteger)type {
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    if(y==-1&&month!=-1){
        NSDateComponents *yearcomponents = [[NSCalendar currentCalendar] components: NSYearCalendarUnit fromDate:[NSDate date]];
        y=[yearcomponents year];
    }else if(y==-1&&month==-1){
        NSDateComponents *daycomponents = [[NSCalendar currentCalendar] components:NSMonthCalendarUnit | NSYearCalendarUnit fromDate:[NSDate date]];
        month= [daycomponents month];
        y= [daycomponents year];
    }
    
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:1];
    [comps setMonth:month];
    [comps setYear:y];
    
    NSCalendar *gregorian = [[NSCalendar alloc]
                             
                             initWithCalendarIdentifier:NSGregorianCalendar];
    [gregorian setFirstWeekday:1];
    
    NSDate *date = [gregorian dateFromComponents:comps];
    
    NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
    NSInteger weekday = [weekdayComponents weekday];
    
    //输出年月
    NSString *line1=[NSString string];
    NSInteger len;
    if(type==1){
        line1=[self printMonth:month];
        len=[line1 length]*2;
    }else if (type==2){
        NSString *mon=[self printMonth:month];
        line1=[NSString stringWithFormat:@"%@ %2ld",mon,(long)y];
        len=[mon length]*2+3;
    }
    [array addObject:[self addSpace:20 string:line1 len:len]];
    
    //输出周数
    [array addObject:@"日 一 二 三 四 五 六"];
    
    //输出月历第一行
    int daynums=[self calDayNums:y month:month];
    int start=weekday;
    NSMutableString *line=[NSMutableString string];
    for (int j=1; j<start; j++) {
        [line appendString:@"   "];
    }
    int i=1;
    for(int j=start;j<7;j++,i++){
        [line appendFormat:@"%2d ",i];
    }
    [line appendFormat:@"%2d",i++];
    [array addObject:[NSString stringWithString:line]];
    
    //月历中间行
    int j=1;
    for (;i<=daynums;j++,i++) {
        if(j%7==1){
            [line setString:@""];
        }
        if(j%7==0){
            [line appendFormat:@"%2d",i];
            if([line length]<20){
                NSInteger n=[line length];
                for (int k=0;k<20-n;k++) {
                    [line appendString:@" "];
                }
            }
            [array addObject:[NSString stringWithString:line]];
        }else{
            [line appendFormat:@"%2d ",i];
        }
    }
    
    //月历最后一行
    if((j-1)%7!=0){
        if([line length]<20){
            NSInteger n=[line length];
            for (int k=0;k<20-n;k++) {
                [line appendString:@" "];
            }
        }
        [array addObject:[NSString stringWithString:line]];
    }
    
    if([array count]<8){
        [array addObject:@"                    "];
    }
    return array;
}

-(void) outputMonthByYM:(NSInteger)year month:(NSInteger)month{
    NSArray *mon=[self calOneMonth:year month:month type:2];
    for (int i=0; i<8; i++) {
        NSLog(@"%@",[mon objectAtIndex:i]);
    }
}

-(void) outputYear:(NSInteger) year{
    for (int i=1; i<=12; ) {
        NSArray *mon1=[self calOneMonth:year month:i++ type:1];
        NSArray *mon2=[self calOneMonth:year month:i++ type:1];
        NSArray *mon3=[self calOneMonth:year month:i++ type:1];
        for (int j=0; j<8; j++) {
            NSLog(@"%@  %@  %@",[mon1 objectAtIndex:j],[mon2 objectAtIndex:j],[mon3 objectAtIndex:j]);
        }
    }
}

@end
