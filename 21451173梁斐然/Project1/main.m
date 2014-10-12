#import <Foundation/Foundation.h>
#import "myCalendar.h"


int main(int argc, const char * argv[]) {
    @autoreleasepool {
        int year,month;
        
        myCalendar *myCal = [[myCalendar alloc] init];
        switch (argc) {
            case 1:
                [myCal showCurrentMonth];
                break;
                
            case 2:
                year = atoi(argv[1]);
                if(year <=0 || year > 9999){
                    NSLog(@"illegal year");
                } else {
                    [myCal showAllTheYear:year];
                }
                break;
                
            case 3:
                if (strcmp(argv[1],"-m") == 0) {
                    month = atoi(argv[2]);
                    if (month <= 0 || month > 12) {
                        NSLog(@"illegal month");
                    } else {
                        [myCal showCurrentYearWithMonth:month];
                    }
                    
                } else {
                    month = atoi(argv[1]);
                    year = atoi(argv[2]);
                    if(month <= 0 || month > 12 || year <=0 || year > 9999)
                    {
                        NSLog(@"illegal month or year");
                    } else {
                        [myCal setDateWithMonth:month Year:year];
                        
                    }
                }
                break;
                
            default:
                break;
        }
    }
    return 0;
}