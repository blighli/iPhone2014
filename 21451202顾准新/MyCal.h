//
//  MyCal.h
//  Cal
//
//  Created by 顾准新 on 14-10-10.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MyCal : NSObject
{
    int year;
    int month;
    int cal[5][7];
}

-(id) init;
//-(id) initWithYear:(int) y Month:(int) m;;
-(BOOL) judgeYear:(int) y;
-(int) calWkdYear:(int) y Month:(int) m;
-(void) setCalWithYear:(int) y Month:(int) m;
-(void) printCal;
-(void) pritnYear;
@end
