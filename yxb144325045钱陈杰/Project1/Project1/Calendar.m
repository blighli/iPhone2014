#import <Foundation/Foundation.h>
#import "Calendar.h"

@implementation Calendar
char *months[]={"一月","二月","三月","四月","五月","六月","七月","八月","九月","十月","十一月","十二月"};
int count[]={0,0,0};
bool isFirstLine[]={true,true,true};

-(void)showMonth:(int)year : (int)month {
    printf("       %d\n",year);
    [self printCalendarByYear:year andMonth:month];
}

-(void)showYear:(int)year{
    printf("                             %d\n",year);
    for(int i=1;i<=12;){
        [self getYears:year :i :i+1 :i+2];
        i+=3;
    }
}

-(void)printCalendarByYear:(int)year andMonth:(int)month {
    int weekDay=[self getFirstDayOfMonth:year:month:1];
    int totalDay=[self getNumOfDays:year :month];
    printf("       %s\n",months[month-1]);
    [self printCalendar:weekDay :totalDay];
}

//获取每个月第一天的日子
-(int)getFirstDayOfMonth:(int)year : (int)month : (int)day{
    NSDateComponents *components = [[NSDateComponents alloc] init];
    [components setDay:day];
    [components setMonth:month];
    [components setYear:year];
    NSCalendar *gregorianCalendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar];
    NSDate *date = [gregorianCalendar dateFromComponents:components];
    NSDateComponents *weekdayComponents =[gregorianCalendar components:NSWeekdayCalendarUnit fromDate:date];
    int weekday = [weekdayComponents weekday];
    return weekday;
}

//获取一个月的天数
-(int)getNumOfDays:(int)year : (int)month {
    NSDateComponents *comps = [[NSDateComponents alloc] init];
    [comps setDay:01];
    [comps setMonth:month];
    [comps setYear:year];
    NSCalendar *cal=[NSCalendar currentCalendar];
    NSRange range = [cal rangeOfUnit:NSDayCalendarUnit inUnit: NSMonthCalendarUnit forDate: [cal dateFromComponents:comps]];
    return range.length;
}

//打印一个月的日期
-(void)printCalendar:(int)x :(int) totalDay{
    printf("日 一 二 三 四 五 六\n");
    bool isFirstLine=true;
    int count=0;
    for(int i=1;i<=totalDay;i++){
        if(isFirstLine){
            for(int j=1;j<x;j++){
                printf("   ");
                count++;
            }
            printf(" %d",i);
            isFirstLine=false;
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
                printf(" %d",i);
                count++;
            }
        }
    }
    printf("\n");
}

//打印整年的日期
-(void)getYears:(int)year : (int)m1 : (int)m2 : (int)m3 {
    int num[3];
    int sum[3];
    count[0] = count[1] = count[2] = 0;
    isFirstLine[0] = isFirstLine[1] = isFirstLine[2] = true;
    printf("         %s                    %s                  %s\n",months[m1-1],months[m2-1],months[m3-1]);
    num[0] =[self getFirstDayOfMonth:year:m1:1];
    num[1] =[self getFirstDayOfMonth:year:m2:1];
    num[2] =[self getFirstDayOfMonth:year:m3:1];
    sum[0]=[self getNumOfDays:year :m1];
    sum[1]=[self getNumOfDays:year :m2];
    sum[2]=[self getNumOfDays:year :m3];
    for(int week=1;week<=6;week++){
        
        for (int j=0; j<3; j++) {
            if(isFirstLine[j]) {
                if (j == 0) {
                    printf("日 一 二 三 四 五 六    日 一 二 三 四 五 六   日 一 二 三 四 五 六\n");
                }
                for (int i=1; i<num[j]; i++) {
                    printf("   ");
                }
                for (int i=num[j]; i<=7; i++) {
                    printf(" %d ",++count[j]);
                }
                if (j == 2) {
                    printf("\n");
                }
                isFirstLine[j]=false;
            } else {
                for (int i=0; i<=6; i++) {
                    if(count[j]++ < 9) {
                        printf(" %d ",count[j]);
                    } else {
                        if (count[j] <= sum[j]) {
                            printf("%d ",count[j]);
                        } else {
                            printf("   ");
                        }
                    }
                }
                
                if (j == 2) {
                    printf("\n");
                }
            }
            if (j != 2) {
                printf("  ");
            }
            if (j == 0) {
                printf(" ");
            }
            
        }
    }
    printf("\n");
}

@end