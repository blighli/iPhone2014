//
//  Calendar.m
//  Cal
//
//  Created by NimbleSong on 14-10-8.
//  Copyright (c) 2014年 宋宁. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Calendar.h"

@implementation Calendar

 char *Month[]={"月","一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

-(int) daytoweek:(int)d andMonth:(int) m andYear:(int) y{
    int a=0;
    if ((m==1)||(m==2)) {
        m+=12;
        y--;
    }
    a=(d+2*m+3*(m+1)/5+y+y/4-y/100+y/400+1)%7;//计算对应的星期几
    if (y<=1752 && m<=9 && d<=3) {
        a=(d+2*m+3*(m+1)/5+y+y/4+5+1)%7;
    }
    return a;
}

-(int) DaysinYear:(int) year andMonth :(int)month{
    if (month == 1||month == 3||month == 5||month == 7||month == 8||month == 10||month == 12) {
        return 31;
    }
    if (month == 4||month == 6||month == 9||month == 11) {
        return 30;
    }
    if ((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
        return 29;
    }
    return 28;
}



-(void) printcanlendar:(int) month andYear:(int)year{
    printf("     %s %d\n",Month[month],year);
    printf("日 一 二 三 四 五 六\n");
    NSMutableArray *array1=[NSMutableArray arrayWithCapacity:50];
    [self putintheArray:array1 andMonth:month andYear:year];
    for (int i=0; i<=35;i+=7) {
        for (int count=i; count<=i+6; count++) {
            [self printwithArray:array1 andCount:count];
        }
        printf(" \n");
    }
    printf("\n\n");
}

-(void) putintheArray:(NSMutableArray *) array andMonth:(int) month andYear:(int) year{
    int a=[self daytoweek:1 andMonth:month andYear:year];
    int date=0-a+1;
    for (int i=0; i<=50; i++) {
        if (date<=[self DaysinYear:year andMonth:month]) {
            if(year==1752 && month == 9 && date==3){
                date=14;
            }else{
                NSNumber *cell =[NSNumber numberWithInt:date];
                [array addObject:cell];
                date++;
            }
        }else{
            NSNumber *cell =[NSNumber numberWithInt:-1];
            [array addObject:cell];
        }
        
    }
}

-(void) printwithArray:(NSMutableArray *) array andCount:(int) count{
    if ([array objectAtIndex:count]) {
        int cell=[[array objectAtIndex:count] intValue];
        if (cell>0) {
            printf("%2d ",cell);
        }else{
            printf("   ");
        }
    }else{
        printf("   ");
    }
}

-(void) printcanlendarYear:(int) year{
    printf("                             %d\n",year);
    for (int i=1; i<=10; i=i+3) {
        printf("  \n");
        if (i<10) {
            printf("        %s                  %s                  %s\n",Month[i],Month[i+1],Month[i+2]);
        }else{
            printf("        %s                 %s                %s\n",Month[i],Month[i+1],Month[i+2]);
        }
        
        printf("日 一 二 三 四 五 六   日 一 二 三 四 五 六   日 一 二 三 四 五 六       \n");
        NSMutableArray *array1=[NSMutableArray arrayWithCapacity:50];
        NSMutableArray *array2=[NSMutableArray arrayWithCapacity:50];
        NSMutableArray *array3=[NSMutableArray arrayWithCapacity:50];
        [self putintheArray:array1 andMonth:i andYear:year];
        [self putintheArray:array2 andMonth:i+1 andYear:year];
        [self putintheArray:array3 andMonth:i+2 andYear:year];
        int arrayNum=1;
        for (int j=0; j<=35;) {
            if (arrayNum==1) {
                for (int count=j; count<=j+6; count++) {
                    [self printwithArray:array1 andCount:count];
                }
                printf("  ");
                arrayNum+=1;
            }else if (arrayNum==2){
                for (int count=j; count<=j+6; count++) {
                    [self printwithArray:array2 andCount:count];
                }
                printf("  ");
                arrayNum+=1;
                
            }else if (arrayNum==3){
                for (int count=j; count<=j+6; count++) {
                    [self printwithArray:array3 andCount:count];
                }
                printf(" \n");
                arrayNum=1;
                j=j+7;
            }else{
                break;
            }
            
        }
    }
}



@end


