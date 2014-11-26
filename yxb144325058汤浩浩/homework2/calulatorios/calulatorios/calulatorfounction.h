//
//  calulatorfounction.h
//  calulator
//
//  Created by C.C.R on 14/11/3.
//  Copyright (c) 2014年 TOM. All rights reserved.
//

#ifndef calulator_calulatorfounction_h
#define calulator_calulatorfounction_h


#endif

@interface calulator : NSObject{
}

@property double prenumber;
@property double memory;

/*-(double) addition:(double) plusnumber ;
-(double) subtraction:(double) subnumber;
-(double) multiplication:(double) multinumber;
-(double) division:(double) divnumber;*/
-(void) addNumber:(double) number;
-(void) memoryaddition:(double) plusnumber;
-(void) memorysubtraction:(double) subnumber;
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
