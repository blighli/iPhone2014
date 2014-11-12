
#import <Foundation/Foundation.h>
#import "Calendar.h"
@implementation Calendar
-(void)showCalendar:(int)year : (int)month {

    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:1];
    [components setMonth:month];
    [components setYear:year];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *curentDate = [gregorianCalendar dateFromComponents:components];
    NSDateComponents *firstDayComponents =[gregorianCalendar components:NSWeekdayCalendarUnit fromDate:curentDate];
    int firstDay = [firstDayComponents weekday];
    
    
    NSDateComponents *monthRangeComponents = [[NSDateComponents alloc] init];

    [monthRangeComponents setYear:year];
    [monthRangeComponents setMonth:month];
    [monthRangeComponents setDay:01];
    NSCalendar *mRCal=[NSCalendar currentCalendar];
    NSRange monthRange = [mRCal rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate: [mRCal dateFromComponents:monthRangeComponents]];
    
    int totalDay=monthRange.length;
    printf("%d年%d月\n",year, month);
    [self printCalendar:firstDay :totalDay];
}

-(void)printCalendar:(int)firstDay :(int) totalDay{
    printf("日  一  二  三  四  五  六\n");
    bool first=true;
    int count=0;
    
    for(int j=1;j<firstDay;j++){
        printf("    ");
        count++;
    }
    
    for(int i=1;i<=totalDay;i++){
        if(first){
            printf(" %d",i);
            first=false;
        }else{
            if(count==6){
                printf("\n");
                if(i<=9)
                    printf(" ");
                printf("%d",i);
                count=0;
            }else{
                if(i<=9)
                    printf(" ");
                printf("  %d",i);
                count++;
            }
        }
    }
    printf("\n");
}
@end
