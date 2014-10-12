#import "DateUtil.h"

@interface DateUtil()
@property(nonatomic,strong) NSDate *date;
@property(nonatomic,strong) NSCalendar *calendar;
@property(nonatomic,strong) NSDateComponents *dateCompents;
@property(nonatomic,assign) NSCalendarUnit calendarUnit;
@end

@implementation DateUtil

-(id)init{
    
    if (self=[super init]) {
        self.date=[NSDate date];
        //公历
        self.calendar=[[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
        //日历旗标
        self.calendarUnit=NSYearCalendarUnit|NSMonthCalendarUnit|NSDayCalendarUnit|NSWeekdayCalendarUnit;
        //日期组件
        self.dateCompents=[self.calendar components:self.calendarUnit fromDate:self.date];
    }
    return self;
}

-(void)createFirstLine:(NSInteger)day{
    
    
}

#define isLeapYear(year) (year)%400==0||((year)%4==0&&(year)%100!=0)
static const char *week[7]={"Sun","Mon","Tue","Wed","Thu","Fri","Sat"};
static const int daysOfMonth[2][13]={
    {0,31,28,31,30,31,30,31,31,30,31,30,31},
    {0,31,29,31,30,31,30,31,31,30,31,30,31}
};

-(void)printCalendarForMonth:(NSInteger)month andYear:(NSInteger)year{
    //自定义日期component
    self.dateCompents.year=year;
    self.dateCompents.month=month;
    self.dateCompents.day=1;
    //更新date
    self.date=[self.calendar dateFromComponents:self.dateCompents];
    //更新datecomponent
    self.dateCompents=[self.calendar components:self.calendarUnit fromDate:self.date];
    
    NSMutableString *calendarString=[NSMutableString stringWithFormat:@"\n%ld年%ld月:\n",year,month ];
    for (int i=0; i<7; i++)
        [calendarString appendFormat:@"%4s",week[i]];
    [calendarString appendString:@"\n"];
    
    NSInteger curWeekDay=self.dateCompents.weekday;
    
    for (int i=0; i<self.dateCompents.weekday-1; i++)
        [calendarString appendString:@"    "];
    
    [calendarString appendFormat:@"%4d",1];
    
    int cur=2;
    for (int i=1; i<daysOfMonth[isLeapYear(year)][month]; i++) {
        curWeekDay=(curWeekDay+1)%8;
        if (curWeekDay==0){
            [calendarString appendFormat:@"\n%"];
            --i;
        }
        else
            [calendarString appendFormat:@"%4d",i+1];
    }
   NSLog(@"%@",calendarString);
    
}

-(void)printCurrentMonthCalendar{
    [self printCalendarForMonth:self.dateCompents.month andYear:self.dateCompents.year];
}

-(void)printCurrentYearCalendarForMonth:(NSInteger)month{
    [self printCalendarForMonth:month andYear:self.dateCompents.year];
    
}

-(void)printCalendarForYear:(NSInteger)year{
    for (int i=1; i<=12; i++)
        [self printCalendarForMonth:i andYear:year];
    
}
@end

