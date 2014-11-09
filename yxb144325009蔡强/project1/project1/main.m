//
//  main.m
//  project1
//
//  Created by zack on 14-10-9.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PrintGregorianCal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSString *argv1,*argv2;
        switch (argc) {
            case 1:
                [PrintCal printCalByNow];
                break;
            case 2:
                argv1 = [NSString stringWithUTF8String:argv[1]];
                [PrintCal printCalByYear:[argv1 intValue]];
                break;
            case 3:
                argv1 = [NSString stringWithUTF8String:argv[1]];
                argv2 = [NSString stringWithUTF8String:argv[2]];
                if ([argv1 isEqualToString: @"-m"]) {
                    [PrintCal printCalByMonth:[argv2 intValue]];
                }else{
                    [PrintCal printCalByMonthAndYear:[argv1 intValue] :[argv2 intValue]];
                }
                break;
            default:
                printf("参数数量错误\n");
                break;
        }
    }
    return 0;
}
