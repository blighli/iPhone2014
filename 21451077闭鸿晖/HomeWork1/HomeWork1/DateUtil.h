#import <Foundation/Foundation.h>

@interface DateUtil : NSObject

///输出当前月月历
-(void)printCurrentMonthCalendar;
///输出某年某月月历（通用方法）
-(void)printCalendarForMonth:(NSInteger)month andYear:(NSInteger)year;
///输出今年的某月月历
-(void)printCurrentYearCalendarForMonth:(NSInteger)month;
///输出某年所有月月历
-(void)printCalendarForYear:(NSInteger)year;
@end
