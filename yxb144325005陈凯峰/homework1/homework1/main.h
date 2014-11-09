//
//  main.h
//  homework1
//
//  Created by jingcheng407 on 14-10-11.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#ifndef homework1_main_h
#define homework1_main_h


#endif
@interface myCal : NSObject {
    NSInteger year;
}
-(void) myCal1:(NSString*)year:(NSString*)month;
-(NSInteger) weekOfDay_Zeller:(NSInteger)  year: (NSInteger)  month: (NSInteger)  day;//蔡勒公式
-(NSInteger) dayOfMonth:(NSInteger)year:(NSInteger)month;//计算某月天数
@end