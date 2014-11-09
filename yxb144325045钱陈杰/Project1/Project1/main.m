#import <Foundation/Foundation.h>
#import "Calendar.h"

int main(int argc, const char * argv[])
{

    Calendar *cal=[[Calendar alloc]init];
    NSDate *date=[NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *comps=[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit) fromDate:date];
    int year=[comps year];
    int month=[comps month];
    char c[]="-m";
    switch (argc) {
        case 1:
            [cal showMonth: year:month];
            break;
        case 2:
            if(atoi(argv[1])<=0||atoi(argv[1])>9999){
                printf("year %s not in 1..9999\n",argv[1]);
                return 1;
            }
            
            [cal showYear:atoi(argv[1])];
            break;
        case 3:
            if(!strcmp(c, argv[1])){
                if(atoi(argv[2])>12||atoi(argv[2])<1){
                    printf("%s is not (1..12) or a name\n",argv[2]);
                    return 1;
                }
                [cal showMonth:year:atoi(argv[2])];
            }else{
                if(atoi(argv[1])>12||atoi(argv[1])<1){
                    printf("%s is not a month number (1..12) or a name\n",argv[1]);
                    return 1;
                }
                if(atoi(argv[2])<=0||atoi(argv[2])>9999){
                    printf("year %s not in 1..9999\n",argv[2]);
                    return 1;
                }
                [cal showMonth:atoi(argv[2]):atoi(argv[1])];
            }
            break;
        default:
            break;
    }
    return 0;
}

