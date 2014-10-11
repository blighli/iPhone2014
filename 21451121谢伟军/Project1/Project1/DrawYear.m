//
//  DrawYear.m
//  Project1
//
//  Created by xvxvxxx on 14-10-11.
//  Copyright (c) 2014年 XVX. All rights reserved.
//

#import "DrawYear.h"

@implementation DrawYear
-(instancetype)initWithYear:(int)inputYear{
    self = [super init];
    if (self) {
        self.year = inputYear;
    }
    return self;
}
//打印一年的日历 ./cal 2014
-(void)drawYear{
    printf("                             %ld\n\n",self.year);
    DrawPic *monthPic[13];
    for (NSInteger month  = 1; month <= 12; month++) {
        monthPic[month] = [[DrawPic alloc]initWithInputDayWithYear:self.year Month:month];
    }
    //打印1-3月
    [DrawPic drawTag1];
    for (int i = 1; i <= 6; i++) {
        for (int j =1; j <= 3; j++) {
            [monthPic[j] drawLine:i];
        }
    }
    //打印4-6月
    [DrawPic drawTag2];
    for (int i = 1; i <= 6; i++) {
        for (int j =4; j <= 6; j++) {
            [monthPic[j] drawLine:i];
        }
    }
    //打印7-9月
    [DrawPic drawTag3];
    for (int i = 1; i <= 6; i++) {
        for (int j =7; j <= 9; j++) {
            [monthPic[j] drawLine:i];
        }
    }
    //打印10-12月
    [DrawPic drawTag4];
    for (int i = 1; i <= 6; i++) {
        for (int j =10; j <= 12; j++) {
            [monthPic[j] drawLine:i];
        }
    }

}
@end

