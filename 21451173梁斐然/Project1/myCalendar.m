#import "myCalendar.h"

#define NSLog(FORMAT, ...) printf("%s\n", [[NSString stringWithFormat:FORMAT, ##__VA_ARGS__] UTF8String])

@implementation myCalendar {
    NSArray *monthArray;
    NSCalendar *calendar;
}

-(id)init {
    self = [super init];
    if (self) {
        monthArray = @[@" 一月",@" 二月",@" 三月",@" 四月",@" 五月",@" 六月",@" 七月",@" 八月",@" 九月",@" 十月",@"十一月",@"十二月"];
        calendar = [[NSCalendar alloc]initWithCalendarIdentifier:NSGregorianCalendar];
        [calendar setLocale:[[NSLocale alloc] initWithLocaleIdentifier:@"zh_CN"]];
        [calendar setFirstWeekday:1];
    }
    return self;
}

-(void)showCurrentMonth {
    NSDateComponents *comp = [self getCurrentComponents];
    for (NSString *str in [self setDateWithMonth:comp.month Year:comp.year]) {
        NSLog(@"%@",str);
    }
}

-(void)showCurrentYearWithMonth:(NSInteger)month {
    NSDateComponents *comp = [self getCurrentComponents];
    for (NSString *str in [self setDateWithMonth:month Year:comp.year]) {
        NSLog(@"%@",str);
    }
}

-(void)showAllTheYear:(NSInteger)year {
    NSLog(@"                                %@",[NSString stringWithFormat:@"%ld",year]);
    NSLog(@"");
    NSMutableArray *strArray = [[NSMutableArray alloc] init];
    for (int i = 0; i < 8; i++) {
        [strArray addObject:[NSMutableString stringWithCapacity:0]];
    }
    for (int i = 1; i <= 12; i ++) {
        NSArray *tempArray = [self setDateWithMonth:i Year:year];
        for (int j = 0; j < 8; j++) {
            NSMutableString *tempStr = [tempArray[j] mutableCopy];
            if (j > 1) {
                while ([tempStr length] <= 20) {
                    [tempStr appendString:@" "];
                };
            }
            [strArray[j] appendString:tempStr];
            [strArray[j] appendString:@"  "];
        }
        if (i % 3 == 0) {
            for (NSString *str in strArray) {
                NSLog(@"%@",str);
            }
            strArray = [[NSMutableArray alloc] init];
            for (int i = 0; i < 8; i++) {
                [strArray addObject:[NSMutableString stringWithCapacity:0]];
            }
        }
    }
}

-(void)showMonth:(NSInteger)month andYear:(NSInteger)year {
    for (NSString *str in [self setDateWithMonth:month Year:year]) {
        NSLog(@"%@",str);
    }
}

-(NSDateComponents *)getCurrentComponents {
    NSDate *date = [NSDate date];
    unsigned unitFlags = NSYearCalendarUnit | NSMonthCalendarUnit | NSDayCalendarUnit;
    NSDateComponents *comp = [calendar components:unitFlags fromDate:date];
    return comp;
}

-(NSArray *)setDateWithMonth:(NSInteger)month Year:(NSInteger)year{
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
    return [self calendarWithDayOfWeek:dayOfWeek withTotalDay:dayOfMonth Month:month Year:year];
}

-(NSArray *)calendarWithDayOfWeek:(NSInteger)dayOfWeek withTotalDay:(NSInteger)totalDay Month:(NSInteger)month Year:(NSInteger)year{
    NSMutableArray *strArray = [[NSMutableArray alloc] init];
    NSMutableString *line = [[NSMutableString alloc] init];
    [strArray addObject:[NSString stringWithFormat:@"     %@ %ld      ",monthArray[month-1] ,(long)year]];
    [strArray addObject:@"日 一 二 三 四 五 六 "];
    if (month == 9 && year == 1752) {
        [strArray addObject:@"       1  2 14 15 16"];
        [strArray addObject:@"17 18 19 20 21 22 23"];
        [strArray addObject:@"24 25 26 27 28 29 30"];
        [strArray addObject:[NSMutableString stringWithCapacity:0]];
        [strArray addObject:[NSMutableString stringWithCapacity:0]];
        [strArray addObject:[NSMutableString stringWithCapacity:0]];
    } else {
        NSInteger count = dayOfWeek;
        for (int i = 1 ; i < dayOfWeek; i++) {
            [line appendString:@"   "];
        }
        for (int i = 1 ; i <= totalDay; i++) {
            [line appendFormat:@"%2d ",i];
            if (count % 7 == 0) {
                [line deleteCharactersInRange:NSMakeRange([line length]-1, 1)];
                [strArray addObject:line];
                line = [[NSMutableString alloc] init];
            }
            count ++;
        }
        if (![line isEqualToString:@""]) {
            [line deleteCharactersInRange:NSMakeRange([line length]-1, 1)];
            [strArray addObject:line];
        }
        while ([strArray count] < 8) {
            [strArray addObject:[NSMutableString stringWithCapacity:0]];
        }
    }
    return strArray;
}

@end