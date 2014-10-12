/**  第一、第二、第三个功能已实现
  *  第四个功能暂未实现
  **/


#import <Foundation/Foundation.h>
int main (int argc, const char * argv[])
{
    
    int c[12]={31,28,31,30,31,30,31,31,30,31,30,31};
    int l[12]={31,29,31,30,31,30,31,31,30,31,30,31};
    
    NSDate *now = [NSDate date];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *comps = [calendar components:(NSYearCalendarUnit) fromDate:now];
    NSInteger year = [comps year];
    comps = [calendar components:(NSMonthCalendarUnit) fromDate:now];
    NSInteger month = [comps month];
    NSInteger weekday, days;
    
    //获得输入信息
    //autoreleasepool *pool = [[autoreleasepool alloc] init];
    char str[100];
    gets(str);                                                      
    NSString *string = [[NSString alloc] initWithUTF8String:str];   
    NSArray *array =[string componentsSeparatedByString: @" "];     
    NSInteger count = [array count];                                
    NSString *command, *command1, *command2;
    NSInteger flag = 0;                                            
    
    if(count > 3) {                                                 
        NSLog(@"please input the correct options");
        return (0);
    }
    command = [array objectAtIndex:0];
    
    if([command isEqualToString: @"cal"] == NO) {                    
        NSLog(@"please input the correct command:cal");
        return (0);
    }
    //判断输出类型：年历、月历
    if (count == 2) {
        flag = 1;                                                   
        command1 = [array objectAtIndex:1];
        year = [command1 intValue];
    } else if(count == 3){
        command1 = [array objectAtIndex:1];
        command2 = [array objectAtIndex:2];
        if([command1 isEqualToString: @"-m"] == YES) {
            month = [command2 intValue];
        } else {
            year  = [command2 intValue];
            month = [command1 intValue];
        }
    }
    //判断输入是否合法
    if(month > 12 || month < 1) {
        NSLog(@"month is not in 1 to 12");
        return (0);
    }
    if(year > 9999 || year < 1) {
        NSLog(@"year is not in 1 to 9999");
        return (0);
    }

    if(flag == 0) {         //输出月历
        
        //该月第一天是星期几
        NSDateComponents *comps = [[NSDateComponents alloc] init];
        [comps setDay:1];
        [comps setMonth:month];
        [comps setYear:year];
        NSCalendar *gregorian = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        NSDate *date = [gregorian dateFromComponents:comps];
        NSDateComponents *weekdayComponents =[gregorian components:NSWeekdayCalendarUnit fromDate:date];
        weekday = [weekdayComponents weekday]-1;
        
        //该月的天数
        if((year % 4 == 0 && year % 100 != 0) || (year % 400 == 0)) {
            days = l[month - 1];
        }
        else {
            days = c[month - 1];
        }
        
        //打印该月的月历
        printf("\t\t\t%ld月\t\t\t\n",month);
        printf("日\t一\t二\t三\t四\t五\t六\n");
        for(int i=0;i< weekday % 7;i++)
            printf("\t");
        for(int i=1;i <= days;i++)
        {
            printf("%2d\t",i);
            weekday ++;
            if(weekday%7 == 0)
                printf("\n");
        }
        printf("\n");
    } else {                                //输出年历
        NSLog(@"not completed this function");
    }
    
    return 0;
}
