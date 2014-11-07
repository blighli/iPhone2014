//
//  CalculateProcess.h
//  Project2
//
//  Created by xvxvxxx on 14/11/5.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface CalculateProcess : NSObject
@property (nonatomic) double currentNumber;
@property (nonatomic) double lastNumber;
@property (nonatomic) NSMutableString* memoryString;


-(instancetype) init;
@property (nonatomic) NSMutableString* displayString;

-(void) processDigit:(NSInteger)digit ;
-(void) processOps:(NSString *)theOperators;

-(void) processMemory:(int) tag;

-(void) processDot;
-(void) displayNumberatScreen:(UILabel *)labelScreen;
@end
