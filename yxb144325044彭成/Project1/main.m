//
//  main.m
//  OC_Assignment_1
//  Copyright (c) 2014年 pengcheng. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calender_peng.h"

void error()
{
    NSLog(@"未输入命令或者未正确输入命令！请您重新输入！");
}

bool isMonth(int a)//判断是不是月份
{
    if(a>0 && a<13)
    {
        return YES;
    }
    else
        return NO;
}

bool isYear(int a)//判断是不是年
{
    if(a>0 && a<9999)
    {
        return YES;
    }
    else
        return NO;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        //[Calender_peng printYear:2014];
        NSString * st[4]={};//定义一个NSString数组并初始化为空，用来存放传入的指令字符串（argv为const类型）
        for (int i=0; i<argc; i++) {
            st[i]=[NSString stringWithUTF8String:argv[i]]; //将const char *类型的argv转化为NSString类型
        }
        
        if (![@"cal"isEqualToString: st[0]]) //如果第一个命令不是“cal”
        {
            error();
            NSLog(@"error 1");
        }
        else
        {
            if ([@"-m"isEqualToString:st[1]])//如果第一个命令是“cal”，第二个命令是“-m”
            {
                if (isMonth([st[2] intValue])) //将string类型转化为int类型 判断第三个命令是不是月份
                {
                    int month=[st[2] intValue];
                    [Calender_peng printMonth:month andYear:2014];//输出当月日历
                }
                else
                    error();
                NSLog(@"error 2");
            }
            else if (isYear([st[1] intValue]))//如果第一个命令是“cal”，第二个命令是数字（可能是年也可能是月份）
            {
                if(st[2]==nil)
                {
                    int year=[st[1] intValue];
                    [Calender_peng printYear:year];
                    //输出当年年历
                }
                else if (isMonth([st[1] intValue]) && isYear([st[2] intValue]) && (st[3]==nil))
                {
                    int month=[st[1] intValue];
                    int year=[st[2] intValue];
                    [Calender_peng printMonth:month andYear:year];//输出此年此月的日历
                }
                else
                {
                    error();
                }
            }
        }
      
    }
    return 0;
}
