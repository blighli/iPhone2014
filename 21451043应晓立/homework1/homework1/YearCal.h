//
//  YearCal.h
//  homework1
//
//  Created by yingxl1992 on 14-10-18.
//  Copyright (c) 2014年 yingxl1992. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YearCal : NSObject
{
    NSInteger year;
}
@property NSInteger year;

-(id)initWithYear:(NSInteger)y;

-(void) outputYear;

@end
