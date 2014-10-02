//
//  PQCal.h
//  Project1-Cal
//
//  Created by 黄盼青 on 14-10-1.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface PQCal : NSObject


//根据年月打印出日历
+(NSString *)printCal:(NSUInteger)months andYears:(NSUInteger)years;
@end
