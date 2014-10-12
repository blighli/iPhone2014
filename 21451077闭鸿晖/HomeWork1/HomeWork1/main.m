#import <Foundation/Foundation.h>
#import "DateUtil.h"
#define STRING_EQUAL(a,b) strcmp((a), (b))==0?true:false
bool isNumber(const char *s){
    //第一位可以是负号
    if (s[0]!='-'&&(s[0]>'9'||s[0]<'0')) {
        return false;
    }
    for (int i=1; i<strlen(s);i++)
        if (s[i]>'9'||s[i]<'0')
            return false;
    return true;
}
//验证格式
bool isValidate(int argc,const char * argv[]){
    switch (argc) {
        case 0:
        case 1:
            return false;
        case 2:
        case 3:
            if (argc==3&&!isNumber(argv[2]))
                return false;
        case 4:
            if (!(STRING_EQUAL(argv[1],"cal")))
                return false;
            if (argc==4){
                if (!(STRING_EQUAL(argv[2],"-m")) && !isNumber(argv[2])) {
                    return false;
                }
                int month;
                if (isNumber(argv[2]))
                    month=atoi(argv[2]);
                else
                    month=atoi(argv[3]);
                if (month>12||month<1) {
                    return false;
                }
            }
            return true;
        default:
            return false;
    }
    return true;
}

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        
        if (!isValidate(argc, argv)) {
            NSLog(@"格式错误");
            return 1;
        }
        DateUtil *dateUtil=[[DateUtil alloc] init];
        switch (argc) {
                //输出当月月历
            case 2:
                [dateUtil printCurrentMonthCalendar];
                break;
                //输出某年月历
            case 3:
                [dateUtil printCalendarForYear:atoi(argv[2])];
                break;
            case 4:
                //输出某年某月月历
                if (isNumber(argv[2])) {
                    [dateUtil printCalendarForMonth:atoi(argv[2]) andYear:atoi(argv[3])];
                }
                //输出当年某月月历
                else{
                    [dateUtil printCurrentYearCalendarForMonth:atoi(argv[3])];
                }
        }
    }
    return 0;
}
