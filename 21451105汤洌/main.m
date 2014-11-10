

#import <Foundation/Foundation.h>
#import "Calendar.h"
int main(int argc, const char * argv[]) {
    Calendar *cal=[[Calendar alloc]init];
    NSDate *date=[NSDate date];
    NSCalendar *calendar=[NSCalendar currentCalendar];
    NSDateComponents *components=[calendar components:(NSYearCalendarUnit | NSMonthCalendarUnit |NSDayCalendarUnit)
 fromDate:date];
    int year=[components year];
    int month=[components month];
    switch (argc) {
        case 1:
            [cal showCalendar:year: month];
            break;
        case 2:
            if(atoi(argv[1])<=0||atoi(argv[1])>9999){
                printf("Illegal input\n");
            }
            else{
                for(int i=1;i<=12;i++){
                    [cal showCalendar:atoi(argv[1]) :i];
                }
            }

            break;
        case 3:
            if(!strcmp("-m", argv[1])){
                if(atoi(argv[2])>12||atoi(argv[2])<1){
                    printf("Illegal input\n");
                }
                else{
                    [cal showCalendar:year:atoi(argv[2])];
                }
            }else{
                if(atoi(argv[1])>12||atoi(argv[1])<1){
                    printf("Illegal input\n");
                }
                else{
                    if(atoi(argv[2])<=0||atoi(argv[2])>9999){
                        printf("Illegal input\n");
                    }
                    else{
                        [cal showCalendar:atoi(argv[2]):atoi(argv[1])];
                    }
                }

                
            }
            break;
        default:
            printf("Illegal input\n");
            break;
    }
    return 0;
}

