//
//  Calendar.m
//  NSdate
//
//  Created by JANESTAR on 14-10-11.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import "Calendar.h"

@implementation Calendar

//获取某年的某个月的天数
+(int)DaysInYear:(int)year inMonth:(int)month{
    if(month==1||month==3||month==5||month==7||month==8||month==10||month==12){
        return 31;
        
    }
    if(month==4||month==6||month==9||month==11){
        return 30;
    }
    if((year%4==0 && year%100!=0)||year%400==0){
        return 29;
        
        
    }
    return 28;
    
}

//输出某一个月的日历

+(void)print_One:(int)year inMonth:(int)month{
    
    char* mon[12]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
     //NSArray* mon=[NSArray arrayWithObjects:@"一月",@"二月",@"三月",@"四月",@"五月",@"六月"@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月",nil];
    //本月第一天的星期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"M/d/yyyy"];
    NSString *firstDay = [NSString stringWithFormat:@"%d/%d/%d",month,1,year];
   // NSString *tt=[mon objectAtIndex:11];
   // NSLog(@"tt is%@",tt);
   // id obj=[mon objectAtIndex:(unsigned int)(month-2)];
    //NSLog(@"\t%@",obj);
    //NSString* test=(NSString*)obj;
    //const char* m=[test UTF8String];
    char* m=mon[month-1];
    printf("     ");
    printf("%s %d\n",m,year);
    printf("日 一 二 三 四 五 六\n");
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDate* date = [formatter dateFromString:firstDay];
    NSDateComponents *comps;
  
    comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
    NSInteger weekday = [comps weekday];
    //printf("the weekday is%d\n",(int)weekday);
    // NSLog(@"weekday is%ld",(long)weekday);
    int num=[Calendar DaysInYear:(int)year inMonth:(int)month];
    int cnt=1;
 
    for(int j=0;j<(int)weekday-1;j++){
        printf("   ");
        cnt++;
    }
    for(int i=1;i<=num;){
           
        printf("%2d ",i++);
        if(cnt%7==0){
            printf("\n");
        
        }
        cnt++;
    
    
    }
    
    
    printf("\n");
    
}




//输出全年的日历

+(void)print_All:(int)year{
     char* mon[12]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
    //某月第一天的星期
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    NSTimeZone *timeZone = [NSTimeZone localTimeZone];
    [formatter setTimeZone:timeZone];
    [formatter setDateFormat:@"M/d/yyyy"];
     printf("%33d\n",year);
     printf("\n");
    int cnt=1;
    for(int i=0;i<4;i++){
        
         
         NSString *firstDay = [NSString stringWithFormat:@"%d/%d/%d",cnt,1,year];
         NSString *firstDay1 = [NSString stringWithFormat:@"%d/%d/%d",cnt+1,1,year];
         NSString *firstDay2 = [NSString stringWithFormat:@"%d/%d/%d",cnt+2,1,year];
         
         char* m=mon[cnt-1];
         char* m1=mon[cnt];
         char* m2=mon[cnt+1];
         size_t len1=strlen(m);
         size_t len2=strlen(m1);
         size_t len3=strlen(m2);
        for(size_t i=0;i<60;){
            if(i==8){
                printf("%s",m);
                i+=len1;
              
            }
            if(i==32){
                printf("%s",m1);
                i+=len2;
            }
            if(i==56){
                printf("%s",m2);
                i+=len3;
            }
            else{
                printf(" ");
                i++;
            }
        
        
        }
        printf("\n");
        
         printf("日 一 二 三 四 五 六 ");
         printf(" 日 一 二 三 四 五 六 ");
         printf(" 日 一 二 三 四 五 六 \n");
         
         NSCalendar *calendar = [NSCalendar currentCalendar];
         NSDate* date = [formatter dateFromString:firstDay];
         NSDate* date1 = [formatter dateFromString:firstDay1];
         NSDate* date2 = [formatter dateFromString:firstDay2];
         NSDateComponents *comps;
         NSDateComponents *comps1;
         NSDateComponents *comps2;

         comps = [calendar components:(NSWeekdayCalendarUnit) fromDate:date];
         comps1 = [calendar components:(NSWeekdayCalendarUnit) fromDate:date1];
         comps2 = [calendar components:(NSWeekdayCalendarUnit) fromDate:date2];
         
         NSInteger weekday = [comps weekday];
         NSInteger weekday1 = [comps1 weekday];
         NSInteger weekday2 = [comps2 weekday];
        
         int num=[Calendar DaysInYear:(int)year inMonth:(int)cnt];
         int num1=[Calendar DaysInYear:(int)year inMonth:(int)cnt+1];
         int num2=[Calendar DaysInYear:(int)year inMonth:(int)cnt+2];
        
        cnt+=3;
        int cnt1=1;
        int cnt2=1;
        int cnt3=1;
        int gap=(int)weekday-1;
        int gap1=(int)weekday1-1;
        int gap2=(int)weekday2-1;
         for(int j=0;j<5;j++){
             int mark=1;
             int mark1=1;
             int mark2=1;
             for(int k=0;k<gap;k++){
                 printf("   ");
                 //cnt1++;
                 mark++;
             }
             gap=0;
             for(;mark<=7;){
                 if(cnt1<=num){
                     printf("%2d ",cnt1++);
                 }
                 else{
                     printf("   ");
                 }
                    mark++;
                }
               
          
             printf(" ");
             
             
             
             for(int k=0;k<gap1;k++){
                 printf("   ");
                // cnt2++;
                 mark1++;
             }
             gap1=0;
             for(;mark1<=7;){
                 if(cnt2<=num1){
                     printf("%2d ",cnt2++);}
                 else{
                     printf("   ");
                 }
                 mark1++;
             }
             
             
             printf(" ");
             
             
             
             for(int k=0;k<gap2;k++){
                 printf("   ");
                 //cnt1++;
                 mark2++;
             }
             gap2=0;
             for(;mark2<=7;){
                 if(cnt3<=num2){
                     printf("%2d ",cnt3++);}
                 else{
                     printf("   ");
                 }
                 mark2++;
             }
             
             
             printf(" \n");
             
                     
            
    
        
    }
        printf("\n");
     
    
     }

}



@end
