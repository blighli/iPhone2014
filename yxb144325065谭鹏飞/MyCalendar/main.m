//
//  main.m
//  MyCalendar
//
//  Created by cstlab on 14-10-11.
//  Copyright (c) 2014年 CSTTan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ShowOnScreen.h"
#include "CalendarController.h"
int main(int argc, const char * argv[]) {
    @autoreleasepool {
        NSArray * input;;
        switch(argc){
            case 2: input = @[[NSString stringWithUTF8String:argv[1]]];break;
            case 3: input = @[[NSString stringWithUTF8String:argv[1]],[NSString stringWithUTF8String:argv[2]]];break;
            case 4: input = @[[NSString stringWithUTF8String:argv[1]],[NSString stringWithUTF8String:argv[2]],[NSString stringWithUTF8String:argv[3]]];break;
            default:break;
        
        }
        CalendarController * calendar = [[CalendarController alloc] initWithCommandStr:input];
        [calendar dealWithCommandStr];
        
        return 0;
    }
    
}
