//
//  main.m
//  rili
//
//  Created by yjq on 14-10-11.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        cal *calendar=[[cal alloc]init];
        NSString *commandName=[NSString stringWithUTF8String:argv[0]];
        if(argc==1)
        {
            [calendar command:commandName];
        }
        if(argc==3)
        {
            NSString *temp=[NSString stringWithUTF8String:argv[1]];
            
            int month=atoi(argv[1]);//参数为字符串时＝0
            int year=atoi(argv[2]);//参数为字符串时＝0

            if(month>=1&&month<=12&&year>=1&&year<=9999)
            {
                [calendar command:commandName Month:month Year:year];
            }
            else
            {
                //month错误，year正确
                if((month<1||month>12)&&year>=1&&year<=9999)
                {
                    if (month==0)
                    {
                        char *temp1=[temp cStringUsingEncoding:NSASCIIStringEncoding];
                        if(temp1[0]=='-')
                        {
                            if(temp1[1]=='m')
                            {
                                [calendar command:commandName Zhilin:temp Month:year];
                            }
                            else
                            {
                                printf("cal: illegal option %s\n",argv[1]);
                            }
                        }
                        else
                        {
                            printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                        }
                    }
                    else if(month>12)
                    {
                        printf("cal: %s is neither a month number (1..12) nor a name\n",argv[1]);
                    }
                    else if(month<0)
                    {
                        printf("cal: illegal option %s\n",argv[1]);
                    }
                }
                //year错误，month正确或者两者都错，但是year的优先级高
                else
                {
                    if (year==0) {
                        printf("cal: year 0 not in range 1..9999\n");
                    }
                    else
                    {
                        printf("cal: year %s not in range 1..9999\n",argv[2]);
                    }
                }

            }
            
        }
        
        if (argc==2) {
            int year=atoi(argv[1]);
            if (year>=1&&year<=9999) {
                [calendar command:commandName Year:year];
            }
            else
            {
                if (year<=0) {
                    printf("cal: illegal option \n");
                }
                else
                {
                    printf("cal: year %s not in range 1..9999\n",argv[1]);
                }
            }
            
        }
        
    }
    return 0;
}

