//
//  main.m
//  Cal_HomeWork
//
//  Created by StarJade on 14-10-11.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//
/******************
 1、运行cal,输出当月的月历 • 分数+2
 2、运行cal 10 2014,输出2014年10月的月历 • 分数+2
 3、运行cal -m 10,输出当年10月的月历 • 分数+3
 4、运行cal 2014,输出2014年的月历 • 分数+3
 ******************/
#import <Foundation/Foundation.h>
#import "ZYCal.h"
#import "OutMonth.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        ZYCal *cal = [[ZYCal alloc] init];
        
        
        if (argc < 2) {
            printf("参数个数输入错误！\n");
            return 1;
        }
        
        if (strcmp(argv[1], "cal") != 0){
            printf("命令输入错误！\n");
            return 1;
        }
        
        
        switch (argc)
        {
        case 2:
            [cal input];
            break;
        case 3:
            [cal inputWithOne:argv[2]];
            break;
        case 4:
            [cal inputWithOne:argv[2] Two:argv[3]];
            break;
        default:
                printf("参数个数输入错误！");
        }
    }
    return 0;
}
