//
//  MyDate.h
//  CalDate
//
//  Created by apple on 14-10-12.
//  Copyright (c) 2014年 钱瑞彬. All rights reserved.
//

#ifndef CalDate_MyDate_h
#define CalDate_MyDate_h


//非法代码
enum ErrorCode {
    ERROR_YEAR,
    ERROR_MONTH,
    ERROR_YEAR_MONTH,
    ERROR_OTHER
};


@interface MyDate : NSObject {
    int _year;  //cal 输入的年
    int _month; //cal 输入的月
}

//设置cal的年月
- (void) setYear: (int)year andMonth: (int)month;

//输出月历
- (void) printMonth;

//输出年历
- (void) printYear;



//输入是否非法
- (BOOL) isLegalYear : (int) year;
- (BOOL) isLegalMonth : (int) month;
- (void) errorCode: (enum ErrorCode) errorCode andErrorYear: (const char*) erroryear andErrorMonth: (const char*) errormonth;

@end


#endif
