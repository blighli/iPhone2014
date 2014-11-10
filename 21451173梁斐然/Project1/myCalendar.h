#import <Foundation/Foundation.h>

@interface myCalendar : NSObject

-(void)showCurrentMonth;
-(void)showCurrentYearWithMonth:(NSInteger)month;
-(void)showAllTheYear:(NSInteger)year;
-(void)showMonth:(NSInteger)month andYear:(NSInteger)year;
@end