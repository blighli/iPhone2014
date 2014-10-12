//
//  main.m
//  cal
//
//  Created by Devon on 14-10-5.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "calendar.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        int rc = 0;                /* 返回值                  */
        int year = 0;              /* 输入的年份(1 - 9999)    */
        int month = 0;             /* 输入的月份(1 - 12)      */
        
        time_t tt;                 /* 当前时间                */
        struct tm *mtime;          /* 当前时间                */
        
        switch (argc)
        {
            case 1:
                time( &tt );
                mtime = gmtime( &tt );
                
                year = mtime->tm_year + 1900;
                month = mtime->tm_mon + 1;
                
                /* 显示日历 */
                [Calendar displaymonth:year month:month];
                
                rc = 0;
                break;
            case 2:
                /* 转换为数字 */
                year = atoi( argv[ 1 ] );
                
                /* 判断输入的参数，简单判断 */
                if ((year < 1) || (year > 9999))
                {
                    printf( "Usage: Wrong arguments.\n" );
                    
                    printf( "year : 1 - 9999\n" );
                    
                    return -1;
                }
                
                /* 显示日历 */
                [Calendar displayyear:year];
                
                rc = 0;
                break;
            case 3:
                /* 区分情况 */
                if(strcmp(argv[1], "-m") == 0)
                {
                    month = atoi( argv[2] );
                    
                    if((month < 1) || (month >12)){
                        printf("Usage: Wrong arguments.\n");
                        
                        printf("month : 1 - 12\n");
                        
                        return -1;
                    }
                    
                    time( &tt );
                    mtime = gmtime( &tt );
                    
                    year = mtime->tm_year + 1900;
                    
                    /* 显示日历 */
                    [Calendar displaymonth:year month:month];
                }
                else{
                    
                    if(argv[1][0] == '-' && argv[1][1] != 'm'){
                        printf("Usage: Wrong arguments.\n");
                        
                        printf("month : -m\n");
                        
                        return -1;
                    }
                    else{
                        year = atoi( argv[ 2 ] );
                        month = atoi( argv[ 1 ] );
                        
                        int isWrong = 0;
                        int yearWrong = 0;
                        int monthWrong = 0;
                        /* 判断输入的参数，简单判断 */
                        if ((year < 1) || (year > 9999))
                        {
                            yearWrong = 1;
                            
                            isWrong = 1;
                        }
                        
                        /* 判断输入的参数，简单判断 */
                        if ((month < 1) || (month > 12))
                        {
                            monthWrong = 1;
                            
                            isWrong = 1;
                        }
                        
                        if(isWrong == 1) {
                            printf( "Usage: Wrong arguments.\n" );
                            
                            if(yearWrong) printf("year : 1 - 9999\n");
                            if(monthWrong) printf("month : 1 - 12\n");
                            
                            return -1;
                        }
                        /* 显示日历 */
                        [Calendar displaymonth:year month:month];
                    }
                    
                    rc = 0;
                }
                break;
            default:
                printf( "Usage: Wrong arguments.\n" );
                
                rc = -1;
        }
        
        return rc;
    }
}
