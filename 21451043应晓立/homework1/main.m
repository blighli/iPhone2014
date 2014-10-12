//
//  main.m
//  homework1
//
//  Created by yingxl1992 on 14-10-11.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MyCal.h"

//去掉nslog的时间戳
#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        MyCal *util=[MyCal new];
        
        if(argc==1){
            //cal
            [util outputMonthByYM:-1 month:-1];
        }else if (argc==2){
            //cal 2014
            NSString *year=[NSString stringWithUTF8String:argv[1]];
            NSInteger y=[year integerValue];
            if(y>=1&&y<=9999){
                NSInteger len=[year length];
                NSString *yearline=[util addSpace:64 string:year len:len];
                NSLog(@"%@",yearline);
                NSLog(@"");
                [util outputYear:y];
            }else{
                NSLog(@"cal: year is not in range 1..9999");
            }
        }else if (argc==3){
            NSString *str2=[NSString stringWithUTF8String:argv[1]];
            if([[str2 substringToIndex:1] compare:@"-"]==NSOrderedSame){
                //cal -m 10
                if([str2 compare:@"-m"]==NSOrderedSame){
                    NSString *str3=[NSString stringWithUTF8String:argv[2]];
                    NSInteger month=[str3 integerValue];
                    if(month>=1&&month<=12){
                        [util outputMonthByYM:-1 month:month];
                    }else{
                        NSLog(@"cal: month is not in range 1..12");
                    }
                }else{
                    NSLog(@"cal: illegal option");
                }
            }else{
                //cal 10 2104
                NSInteger month=[str2 integerValue];
                
                NSString *str3=[NSString stringWithUTF8String:argv[2]];
                NSInteger year=[str3 integerValue];
                if(month>=1&&month<=12){
                    if(year<=9999&&year>=1){
                        [util outputMonthByYM:year month:month];
                    }
                    else{
                        NSLog(@"cal: year is not in range 1..9999");
                    }
                }else{
                    NSLog(@"cal: month is not in range 1..12");
                }
            }
        }
    }
    
    return 0;
}
