//
//  main.m
//  Project1-Cal
//
//  Created by 黄盼青 on 14-9-30.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PQCal.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        PQCal *cal=[[PQCal alloc]initWithYear:2014];
        [cal printCalculateByMonth:10];
    }
    return 0;
}
