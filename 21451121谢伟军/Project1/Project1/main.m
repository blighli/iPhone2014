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
                for (NSInteger month  = 1; month <= 12; month++) {
                    NSString *inputYearString = [[NSString alloc]initWithCString:argv[1]
                                                                        encoding:NSASCIIStringEncoding];
                    NSInteger inputYear = [inputYearString intValue];
                    myPic = [myPic initWithInputDayWithYear:inputYear
                                                      Month:month];
                    [myPic draw];
                }
            }
                break;
            case 3:{
                NSString *input_1String = [[NSString alloc]initWithCString:argv[1]
                                                                  encoding:NSASCIIStringEncoding];
                NSInteger input_1Int = [input_1String intValue];
                NSString *input_2String = [[NSString alloc]initWithCString:argv[2]
                                                                  encoding:NSASCIIStringEncoding];
                NSInteger input_2Int = [input_2String intValue];
                if ([input_1String isEqualToString:@"-m"]) {
                    myPic = [myPic initWithToday];
                    myPic.month = input_2Int;
                    [myPic draw];
                }else{
                    myPic = [myPic initWithInputDayWithYear:input_2Int
                                                      Month:input_1Int];
                    [myPic draw];
                }
            }
                break;
            default:
                printf("E~~~~~~~~~~~~~~~~R~~~~~~~~~~~~~~~~R~~~~~~~~~~~~~~~~O~~~~~~~~~~~~~~~~R\nThere is something wrong with your input,Please check it!!!!!!!!!!!!!\n\n");
                break;
        }
    }
    return 0;
}

