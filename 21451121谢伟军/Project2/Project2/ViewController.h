//
//  ViewController.h
//  Project2
//
//  Created by xvxvxxx on 14/11/4.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController
@property (nonatomic) double currentNumber;
@property (nonatomic) double lastNumber;
@property (nonatomic) NSMutableString* memoryString;

@property (nonatomic) NSMutableArray* variableStack;
@property (nonatomic) NSMutableArray* operatorStack;

@property (nonatomic) NSMutableString* displayString;

@property (nonatomic) NSMutableString* currentString;
@property (nonatomic) NSMutableString* lastString;

@property (nonatomic) NSString* operatorStackLevel;

@property (nonatomic) NSDictionary* stackLevelDictionary;



-(void) processDot;
//-(void) displayNumberatScreen:(UILabel *)labelScreen;
-(void) display;
#pragma stackmethods
-(void) pushStack:(NSMutableArray *)stack with:(NSString *)string;
-(NSString *) popStack:(NSMutableArray *)stack;
-(void) clearStack:(NSMutableArray *)stack;

-(NSString *) calculateOperator:(NSString *)operator Number1:(double)number1 Number2:(double)number2;


-(void) initProcess;
-(void) clearZero;
@end

