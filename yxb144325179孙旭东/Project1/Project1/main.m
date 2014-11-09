//
//  main.m
//  Project1
//
//  Created by  sephiroth on 14-10-7.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Week.h"


int main(int argc, const char * argv[]) {

    system("clear");
    
    Week *week;
    week=[Week new];
    int year=0;
    int month=0;
    NSString *s_year;
    NSString *s_month;
    
    //获取当前年月
    
    NSDate *dateNow;
    dateNow=[NSDate dateWithTimeIntervalSinceNow:0];
    NSCalendar *calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];//设置成中国阳历
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    
    NSInteger unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit | NSWeekdayCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit;//这句我也不明白具体时用来做什么。。。
    
    comps = [calendar components:unitFlags fromDate:dateNow];
    int now_year=(int)[comps year];
    int now_month=(int)[comps month];
    
    switch (argc) {
        case 1:
            [week setYear:now_year];
            [week setMonth:now_month];//当命令行中没有额外参数
            break;
        case 2:
            s_year=[[NSString alloc]initWithUTF8String:argv[1]];
            year=[s_year intValue];
            [week setYear:year];//当命令行中有年份参数
            break;
        case 3:
            s_year=[[NSString alloc]initWithUTF8String:argv[2]];
            s_month=[[NSString alloc]initWithUTF8String:argv[1]];
            
            if ([s_month isEqualToString:@"-m"]) {
                [week setYear:now_year];
                month=[s_year intValue];
                [week setMonth:month];
                if (month>12||month<1) {
                    NSLog(@"输入错误，月份应在1到12之间！");
                    return (0);
                }
            }
            else
            {
                year=[s_year intValue];
                month=[s_month intValue];
                [week setYear:year];
                [week setMonth:month];
                if (month>12||month<1)
                {
                    NSLog(@"输入错误，月份应在1到12之间！");
                    return (0);
                }
            }
            
            break;
        default:
            NSLog(@"输入格式不符合要求！");
            return (0);
            break;
    }
    [week print];
    
    

    
    //以下调试代码
    
   /*for(int k=0;k<12;k++)
    {
        int row=k/3*7*2+1;
        int col=k%3*22+5;
        int col2;
        printf("%c[%d;%df",0x1b,row,col);
        printf("日 一 二 三 四 五 六");
        int i=1;
        bool move=YES;
        while(i<30)
        {
            //错点
            col2=col;
            row+=1;
            if(move)
                col2+=3*3;
            printf("%c[%d;%df",0x1b,row,col2);
            printf("%c[?7h",0x1b);
            for(int j=0;j<7;j++)
            {
                if(move)
                {
                    j+=3;
                    move=NO;
                }
                printf("%2d ",i++);
            }
            row++;
        }
    }*/
    printf("\n");

    return 0;
}
