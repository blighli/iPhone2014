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
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here..
        DrawPic *myPic = [DrawPic alloc];
        switch (argc) {
                
                
            case 1:{
                myPic = [myPic initWithToday];
                [myPic draw];
            }
                break;
                
                
            case 2:{
                if (atoi(argv[1])>=1 && atoi(argv[1])<=9999) {
                    for (NSInteger month  = 1; month <= 12; month++) {
                        myPic = [myPic initWithInputDayWithYear:atoi(argv[1])
                                                          Month:month];
                        [myPic draw];
                    }
                }
                else
                    printf("cal: year %s not in range 1..9999\n",argv[1]);
            }
                break;
                
                
            case 3:{
                if (strcmp(argv[1], "-m") == 0) {
                    if (atoi(argv[2]) >= 1 && atoi(argv[2]) <= 12) {
                        myPic = [myPic initWithToday];
                        myPic.month = atoi(argv[2]);;
                        [myPic draw];
                    }else{
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[2]);
                    }
                }else{
                    if (atoi(argv[2])<1 || atoi(argv[2])>9999)
                        printf("cal: year %s not in range 1..9999\n",argv[2]);
                    else{
                        if (atoi(argv[1]) >= 1 && atoi(argv[1]) <= 12) {
                            myPic = [myPic initWithInputDayWithYear:atoi(argv[2])
                                                              Month:atoi(argv[1])];
                            [myPic draw];
                        }else
                            printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                    }
                }
            }
                break;
                
                
            default:
                break;
                
                
        }
    }
    return 0;
}


