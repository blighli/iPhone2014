//
//  main.m
//  DisplayCalendar
//
//  Created by Chencheng on 14-10-7.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "LearnCalendar.h"
int main(int argc, const char * argv[])
{
    LearnCalendar *cal= [[LearnCalendar alloc]init];
    NSDate *mydate=[[NSDate alloc] init];
    NSCalendar *calendar= [NSCalendar currentCalendar];
    NSDateComponents *comps= [calendar components:(NSYearCalendarUnit|NSMonthCalendarUnit)fromDate:mydate];
    NSInteger year=[comps year];
    NSInteger month= [comps month];//得到当前的年月
    char str[100];
    gets(str);//输入字符串
    NSString *s=[NSString stringWithUTF8String:str];//将输入的字符串转换成objective－c语言能识别的字符串
    NSArray *firstSplit = [s componentsSeparatedByString:@" "];//将字符串按空格分割成字符串数组
    NSInteger  len= [firstSplit count];//得到字符串数组的长度
    if(len==1)//输入了一个没有空格的字符串，如果是cal就输出当前年月的的月历，如果不是则报错
    {
        if([s isEqualToString:@"cal"])
            [cal CalendarwithMonth:month andYear:year];
        else
            NSLog(@"Input error,Please check and try again later!");
    }
    else if(len==2)//输入的字符串按空格分割成了两个，看看是不是cal 2014这种形式，不是则报错，是则判断年份符不符合要求
    {
        //NSString *argvsecondstr=[NSString stringWithUTF8String:argv[1]];
        NSString *arrayyear=[firstSplit objectAtIndex:1];//取出分割得到的第二个字符串
        if([arrayyear isEqualToString:@"-m"])
        {
            NSLog(@"Invalid Input!please try again later!");
        }
        else
        {
            NSInteger year= [arrayyear integerValue];//把字符串转换成整形数
            if(year<0||year>2500)//年份不符合要求
            {
                NSLog(@"The year you input is invalid,please try again later!");
            }
            else
            {
                 [cal CalendarwithYear:year];
                
            }
            
        }
    }
    else if (len==3)//输入的字符串按空格分成了3个，看看是不是cal －m 10或者cal 10 2014这种格式，不是则报错，是则判断年月符不符合要求
    {
        NSString *secondarray=[firstSplit objectAtIndex:1];//分割得到的第二个字符串
        if([secondarray isEqualToString:@"-m"])//看看得到的第二个字符串是不是－m
        {
            NSString *thirdarray=[firstSplit objectAtIndex:2];//分割得到的第三个字符串
            NSInteger month=[thirdarray integerValue];//把字符串转换成整形数
            if(month<1||month>12)//判断月份符不符合要求
            {
                NSLog(@"The month you input is invalid,please try again later!");
            }
            else
            {
                [cal CalendarwithMonth:month andYear:year];
            }
        }
        else
        {
            NSInteger month=[secondarray integerValue];//把字符串转换成整形数
            NSString *thirdarray=[firstSplit objectAtIndex:2];//分割得到的第三个字符串
            NSInteger year=[thirdarray integerValue];//把字符串转换成整形数
            if(month<1||month>12||year<0||year>2500)//判断年月符不符合要求
            {
                NSLog(@"The month or year you input is invalid,please try again later!");
            }
            else
            {
                [cal CalendarwithMonth:month andYear:year];
            }
        }
    }
    return 0;
    
}
