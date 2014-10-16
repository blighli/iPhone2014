#import "calenderOut.h"

@implementation calenderOut


+(void) year:(int)year month:(int)month
{
    
    //使用传过来的时间，计算需要打印出来的时间
	NSString *dateString = [NSString stringWithFormat:@"%d-%d-01",year, month];
    NSDateFormatter *dateFormatter=[[NSDateFormatter alloc]init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    NSDate *date=[dateFormatter dateFromString:dateString];
    
    
    NSDateComponents *com = [calendar components:NSYearCalendarUnit | NSMonthCalendarUnit | NSWeekdayCalendarUnit  fromDate:date];
	
	int year_get=(int)com.year;
    int month_get=(int)com.month;
    int weekday_get=(int)com.weekday;
	

	int count=0;
	
	if(month_get == 1 || month_get== 3 || month_get == 5 || month_get== 7 || month_get == 8 || month_get == 10 || month_get == 12)
    {
        count = 31;
    }else if (month_get == 2){
        if((year_get % 4 == 0 && year_get % 100 != 0) || year_get % 400 == 0){
            count = 29;
        }else{
	  		count = 28;
        }
    }else{
        count = 30;
    }
	
    printf("    %d月 %d 年\n",month_get, year_get);
    printf(" 日 一  二 三  四 五 六\n");
    
    int j = weekday_get;
    while(--weekday_get){
        printf("   ");
    }
    for(int i = 1;i <= count; i ++)
    {
        printf(" %2d",i);
		j++;
		if(j>7)
		{
			printf("\n");
			j=1;
		}
        
        
    }
    printf("\n");

}
@end