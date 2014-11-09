//
//  main.m
//  cal
//
//  Created by icy on 14-10-8.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <Foundation/Foundation.h>

char monstr[12][10]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};

//计算总天数
int totalDays(NSDateComponents* components){
    int total;
    if ([components isLeapMonth]==2) {
        if ([components isLeapMonth]) {
            total = 29;
            //NSLog(@"%d",total);
            return total;
        }else{
            total =28;
            //NSLog(@"%d",total);
            return total;
        }
    }
    switch ([components month]) {
        case 1:
        case 3:
        case 5:
        case 7:
        case 8:
        case 9:
        case 10:
        case 12:
            total=31;
            break;
            
        default:
            total=30;
            break;
    }
    //NSLog(@"%d",total);
    return total;
    
}




//某一年具体某个月
void showSpecificMonthOfSpecificateYear(NSInteger year,NSInteger month){
    NSDate *now = [NSDate date];
    //NSCalendar *calendar = [[NSCalendar alloc]
    //                      initWithCalendarIdentifier:NSGregorianCalendar];
    
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:now];

    
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    
    NSDate *dayOneInCurrentMonth = [calendar dateFromComponents:components];
    //当月第一天
    NSDateComponents *transformedComponents =[calendar components:units fromDate:dayOneInCurrentMonth];
//    NSLog(@"Day: %ld", [transformedComponents day]);
//    NSLog(@"Month: %ld", [transformedComponents month]);
//    NSLog(@"Year: %ld", [transformedComponents year]);
//    NSLog(@"weekday: %ld", [transformedComponents weekday]);
    printf("%15s %ld\n",monstr[[components month]-1] ,(long)[components year]);
    printf("  日  一  二  三   四  五  六\n");
    
    // int count =1;
    long int weekday= [transformedComponents weekday];
    int total =totalDays(transformedComponents);
    
    for (int j=1; j<=(weekday-1)*4; j++) {
        printf(" ");
    }
    
    for (int i=1; i<=total;i++) {

        printf("%3.1d ",i);
        
        
        if (weekday%7==0) {
            printf("\n");
        }
        weekday++;
    }
    printf("\n");

}


//cal -m
void showSpecificMonthOfCurrentYear(NSInteger month){
    if(month<=0||month>12){
        printf("cal: %ld is neither a month number (1..12) nor a name\n",month);
        return;
        
    }
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:now];
    long int year = [components year];
    
    showSpecificMonthOfSpecificateYear(year, month);
}

//cal
void showCurrentMonthOfCurrentYear(){
    
    //NSLog(@"showMonthOfCurrentYear");
    
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSCalendarUnit units = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit| NSWeekdayCalendarUnit;
    NSDateComponents *components = [calendar components:units fromDate:now];
    long int year = [components year];
    long int month = [components month];
    showSpecificMonthOfSpecificateYear(year, month);
    
}


// cal 2014
void showYear(NSInteger year){
    
    if(year<=0||year>=9999){
        printf("year %ld not in range 1..9999\n",(long)year);
        return;
    }
    
    for (int i=1;i<=12; i++) {
        showSpecificMonthOfSpecificateYear(year, i);
    }
    
}


void input(NSString* str){
    
    NSString *command = @"cal";
    
    //cal
    if ([str isEqualTo:command]) {
        showCurrentMonthOfCurrentYear();
        return ;
    }
    
    //cal with para
    
    if ([str hasPrefix:command]) {
        
        @try
        {
            NSArray *array = [str componentsSeparatedByString:@" "]; //拆分
            if ([[array objectAtIndex:1]hasPrefix:@"-"]) {
                if ([[array objectAtIndex:1]hasPrefix:@"-m"]) {
                    if([array count]==2){
                        printf("cal: option requires an argument -- m\nusage: cal [-jy] [[month] year]\n\tcal [-j] [-m month] [year]\n\tncal [-Jjpwy] [-s country_code] [[month] year]\n\tncal [-Jeo] [year]\n\tlocalhost:~ zhangfangli$ \n");
                    }else{
                        NSInteger month = [[array objectAtIndex:2] integerValue];
                        showSpecificMonthOfCurrentYear(month);
                    }
                }else{
                    printf("cal: illegal option -");
                    const char * cString=[[array objectAtIndex:1] UTF8String];
                    //NSLog(@"%@",[array objectAtIndex:1]);
                    printf("%s\n" ,cString);
                    printf("usage: cal [-jy] [[month] year] \ncal [-j] [-m month] [year]\n\tncal [-Jjpwy] [-s country_code] [[month] year]\n\tncal [-Jeo] [year]\n");
                    
                }
            }else if([array count]==2){
                NSInteger year = [[array objectAtIndex:1] integerValue];
                showYear(year);
            }else if([array count]==3){
                NSInteger month = [[array objectAtIndex:1] integerValue];
                NSInteger year = [[array objectAtIndex:2] integerValue];
                if (month<0||month>12) {
                    printf("cal: %ld is neither a month number (1..12) nor a name\n",month);
                    return;
                }
                if (year) {
                    if(year<=0||year>=9999){
                        printf("year %ld not in range 1..9999\n",(long)year);
                        return;
                    }
                }
                showSpecificMonthOfSpecificateYear(year,month);
            }else{
                printf("usage: cal [-jy] [[month] year]\n\tcal [-j] [-m month] [year]\n\tcal [-Jjpwy] [-s country_code] [[month] year]\tncal [-Jeo] [year]\n");
            }
           
        }
        //String without ‘ ’
        @catch (NSException *exception)
        {
           NSLog(@"command not found");
            
             }
      
        
       
        
        
    }else{
        NSLog(@"command not found");
    }

    
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        
        
        
        
        char buffer[20];
        
        //NSString *str = [[NSString alloc] initWithUTF8String:buffer];
        
        
        
        while (scanf("%[^\n]",buffer)!=EOF) {
            NSString *str = [[NSString alloc] initWithUTF8String:buffer];
            //NSLog(@"%@", str);
            input(str);
            getchar();
          
            memset(buffer,0,20);
        }
        
        
        

        //NSLog(@"Hello, World!");
    }
    
    return 0;
}
