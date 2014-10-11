#import <Foundation/Foundation.h>

@interface myCalendar : NSObject

-(void)showCurrentMonth;
-(void)showCurrentYearWithMonth:(NSInteger)month;
-(void)showAllTheYear:(NSInteger)year;
-(void)setDateWithMonth:(NSInteger)month Year:(NSInteger)year;

@end