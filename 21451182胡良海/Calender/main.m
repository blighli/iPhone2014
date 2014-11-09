//
//  main.m
//  Calender
//
//  Created by hu on 14-10-7.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Mycalender.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int year=0,month=0;
        int flag=1;//用来标记是那种类型的命令
        BOOL canrun = true;
        Mycalender * mycalender = [[Mycalender alloc] init];
        
        char buffer[101];
        gets(buffer);
        int lenghts = (int)strlen(buffer);
        char buffer_cal[101];
        int i=0;
        int j=0;
        while(buffer[i]!=' '&&i<lenghts)
        {
            buffer_cal[j++] = buffer[i++];
        }
        NSString * tmpstr = [NSString stringWithUTF8String:buffer_cal];
        while (![tmpstr isEqualToString:@"cal"])
        {
            NSLog(@"命令不正确，请重新输入：");
            gets(buffer);
            lenghts = (int)strlen(buffer);
            i=0;
            j=0;
            while(buffer[i]!=' '&&i<lenghts)
            {
                buffer_cal[j++] = buffer[i++];
            }
            buffer_cal[j]='\0';
            tmpstr = [NSString stringWithUTF8String:buffer_cal];
        }
        if (lenghts!=3) {
            char buffer_number[101];
            i++;
            j=0;
            while(buffer[i]!=' '&&i<lenghts)
            {
                buffer_number[j++] = buffer[i++];
            }
            
            char buffer_last[101];
            i++;
            j=0;
            while (buffer[i]!=' '&&i<lenghts) {
                buffer_last[j++] = buffer[i++];
            }
            
            NSString * numberorstring =[NSString stringWithUTF8String:buffer_number];
            int numberorstring_len = (int)[numberorstring length];
            if (numberorstring_len==4) {
                flag =4;//第四种命令
                year = [numberorstring intValue];
            }else
            {
                month=0;
                month = [numberorstring intValue];
                if(month>=1&&month<=12)
                {
                    flag =2;
                    NSString *yearstring =[NSString stringWithUTF8String:buffer_last];
                    year = [yearstring intValue];
                }else if([numberorstring isEqualToString:@"-m"])
                {
                    flag =3;
                    NSString *yearstring =[NSString stringWithUTF8String:buffer_last];
                    month = [yearstring intValue];
                }else
                {
                    NSLog(@"输入命令不正确发生严重错误请重新运行程序！！！！！！");
                    canrun = false;
                }
            }
        }
        if (canrun) {
            switch (flag) {
                case 1:
                    [mycalender showCurrentyearCalender];
                    break;
                case 2:
                    if (year!=0&&month) {
                        [mycalender showCalener:year months:month];
                    }
                    break;
                case 3:
                    [mycalender showCurrentyearCalender:month];
                    break;
                case 4:
                    [mycalender showyearCalender:year];
                    break;
                default:
                    break;
            }

        }
        
    }
    return 0;
}