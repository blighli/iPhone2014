//
//  Express.h
//  Express
//
//  Created by Mac on 14-11-6.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import <Foundation/Foundation.h>





@interface Express : NSObject

{
    int errorcode;
}


@property(nonatomic,strong)  NSString *expStr;
@property(nonatomic,strong)  NSString *value;

-(id) init:(NSString *)expStrParam;

-(BOOL) calExp;

-(void) calExp:(NSString *) param operator:(char ) op;

-(NSMutableArray *) parseToNSMutableArray;
-(NSString *) getValue;

-(int ) errorCode;

-(BOOL) isBracketMatch;

@end

static const int NOERROR =0;
static const int DIVIDEZEROR = 1;
static const int MISMATCHBRACKET = 2;
static const int OPERATORERROR = 3;
double cal(char c,double x,double y);

int outOfStackPriority(char c);

int innerOfStackPriority(char c);
