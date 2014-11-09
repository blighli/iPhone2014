//
//  main.m
//  Project1
//
//  Created by xvxvxxx on 14-10-8.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//


#import <Foundation/Foundation.h>
#import "WeekDay.h"
#import "DrawPic.h"
#import "DrawYear.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        DrawPic *myPic = [DrawPic alloc];
        switch (argc) {
                
            //命令行只有一个参数
            case 1:{
                // ./cal  查询当月日历
                myPic = [myPic initWithToday];
                [myPic draw];
            }
                break;
                
            //命令行有两个参数
            case 2:{
                // ./cal 2014 查询当年日历
                if (atoi(argv[1])>=1 && atoi(argv[1])<=9999) {
                    int year = atoi(argv[1]);
                    DrawYear *theYearCalendar = [[DrawYear alloc]initWithYear:year];
                    [theYearCalendar drawYear];
                }
                
                else
                    //错误提示
                    printf("cal: year %s not in range 1..9999\n",argv[1]);
            }
                break;
                
            //命令行三个参数
            case 3:{
                // ./cal -m 11 查询当年11月日历
                if (strcmp(argv[1], "-m") == 0) {
                    if (atoi(argv[2]) >= 1 && atoi(argv[2]) <= 12) {
                        myPic = [myPic initWithToday];
                        myPic.month = atoi(argv[2]);;
                        [myPic draw];
                    }else{
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
                    }
                }
                // ./cal 10 2014 查询2014年10月日历
                else{
                    
                    if (atoi(argv[2])<1 || atoi(argv[2])>9999)
                        //错误提示
                        printf("cal: year %s not in range 1..9999\n",argv[2]);
                    else{
                        if (atoi(argv[1]) >= 1 && atoi(argv[1]) <= 12) {
                            myPic = [myPic initWithInputDayWithYear:atoi(argv[2])
                                                              Month:atoi(argv[1])];
                            [myPic draw];
                        }
                        else
                            //错误提示
                            printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                    }
                }
            }
                break;
                
                
            default:
                //printf("cal: 太多参数啦 （￣д￣）\n");
                break;
                
                
        }
    }
    return 0;
}


