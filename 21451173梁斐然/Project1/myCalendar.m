#import "myCalendar.h"

@implementation myCalendar {
    NSArray *monthArray;
    NSCalendar *calendar;
}

-(id)init {
    self = [super init];
    if (self) {
        monthArray = @[@"一月",@"二月",@"三月",@"四月",@"五月",@"六月",@"七月",@"八月",@"九月",@"十月",@"十一月",@"十二月"];
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [calendar setFirstWeekday:1];
    }
    return self;
}

-(void)showCurrentMonth {
    NSDateComponents *comp = [self getCurrentComponents];
    [self setDateWithMonth:comp.month Year:comp.year];
}

-(void)showCurrentYearWithMonth:(NSInteger)month {
    NSDateComponents *comp = [self getCurrentComponents];
    [self setDateWithMonth:month Year:comp.year];
}

-(void)showAllTheYear:(NSInteger)year {
    NSLog(@"        %@",[NSString stringWithFormat:@"%ld",year]);
    for (int i = 1; i <= 12; i ++) {
        [self setDateWithMonth:i Year:year];
    }
}

-(NSDateComponents *)getCurrentComponents {
    NSDate *date = [NSDate date];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
    return comp;
}

-(void)setDateWithMonth:(NSInteger)month Year:(NSInteger)year{
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [[NSDateComponents alloc]init];
    comp.year = year;
    comp.month = month;
    comp.day = 1;
    NSDate *date = [calendar dateFromComponents:comp];
    NSInteger dayOfWeek = [calendar ordinalityOfUnit:NSWeekdayCalendarUnit
                                              inUnit:NSWeekCalendarUnit forDate:date];
    NSRange range = [calendar rangeOfUnit:NSDayCalendarUnit
                                   inUnit:NSMonthCalendarUnit forDate:date];
    NSUInteger dayOfMonth = range.length;
    NSLog(@"     %@ %@",monthArray[comp.month-1],[NSString stringWithFormat:@"%ld",comp.year]);
    [self calendarWithDayOfWeek:dayOfWeek withTotalDay:dayOfMonth];
}

-(void)calendarWithDayOfWeek:(NSInteger)dayOfWeek withTotalDay:(NSInteger)totalDay {
    NSLog(@"日 一 二 三 四 五 六");
    NSMutableString *line = [[NSMutableString alloc] init];
    NSInteger count = dayOfWeek;
    for (int i = 1 ; i < dayOfWeek; i++) {
        [line appendString:@"   "];
    }
    for (int i = 1 ; i <= totalDay; i++) {
        if (i <= 9) {
            [line appendFormat:@" %d ",i];
        } else {
            [line appendFormat:@"%d ",i];
        }
        if (count % 7 == 0) {
            [line deleteCharactersInRange:NSMakeRange([line length]-1, 1)];
            NSLog(@"%@",line);
            line = [[NSMutableString alloc] init];
        }
        count ++;
    }
    if (![line isEqualToString:@""]) {
        [line deleteCharactersInRange:NSMakeRange([line length]-1, 1)];
        NSLog(@"%@",line);
    }
}

@end