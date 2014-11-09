//
//  calulatorfounction.h
//  calulator
//
//  Created by hanxue on 14-11-6.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#ifndef calulator_calulatorfounction_h
#define calulator_calulatorfounction_h


#endif

@interface calulator : NSObject{
    double b;
}

@property double prenumber;
@property double memory;

-(void) addNumber:(float) number;
-(void) memoryaddition:(float) plusnumber;
-(void) memorysubtraction:(float) subnumber;
-(void) memoryclear;

-(NSString*) addition:(NSString*) plusnumber1 andPlusNumber: (NSString*) plusnumber2;
-(NSString*) subtaction:(NSString*) subnumber1 andSubNumber: (NSString*) subnumber2;
-(NSString*) multiplication:(NSString*) multinumber1 andMultiNumber: (NSString*) multinumber2;
-(NSString*) division:(NSString*) divnumber1 andDivNumber: (NSString*) divnumber2;
-(NSString*) remainderation:(NSString*) remnumber1 andRemNumber:(NSString*) remnumber2;
-(NSString*) unperantheses:(NSString*) perantheses;
-(NSString*) analysic:(NSString*) beforeanalysic;
-(Boolean) checkperantheses:(NSString*) unCheckString;


@end