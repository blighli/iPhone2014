//
//  main.m
//  cal
//
//  Created by Mac on 14-10-13.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Header.h"

int main(int argc, const char * argv[]) {
    Cal *cal=[Cal new];
    [cal setCanshuNum:argc];
    int a,b;
    
    switch(argc){
        case 1:
            [cal OutputAll];
            break;

        case 2:
            a=atoi(argv[1]);
            if(a<0||a>12)
            {
                printf("月份输入错误");
            }else{
                [cal OutputAll];
            }
            break;
        case 3:
           a=atoi(argv[1]);
           b=atoi(argv[2]);
             [cal OutputAll];
            break;
            
    }

    return 0;
    
}
