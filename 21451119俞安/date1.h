//
//  date1.h
//  homework1
//
//  Created by apple on 14-10-11.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#ifndef homework1_date1_h
#define homework1_date1_h

#import <Foundation/Foundation.h>

@interface date1 : NSObject
@property NSArray* monthinchinese;
@property int years;

-(int)daysOfMonth:(int)month inYear:(int)year;
-(id)initWithyear:(int)year;
-(NSMutableArray*)makeCalanderAtMonth:(int)month andYears:(int)year;
-(void)printcalanderformonth:(int)month;
-(void)printallyear;
@end

#endif
