//
//  calculatorViewController.m
//  calculator
//
//  Created by ___FULLUSERNAME___ on 14-11-4.
//  Copyright (c) 2014年 ___FULLUSERNAME___. All rights reserved.
//

#import "calculatorViewController.h"
#import "calAchieve.h"

@interface calculatorViewController ()
@property (nonatomic)calAchieve *cal;
@property (nonatomic) NSMutableString *expression;
@property(nonatomic)NSString *lastOperate;            //记录最后一个符号，用来连续运算
@property(nonatomic)NSString *lastDigit;              //记录最后一个数字，用来连续运算
@property(nonatomic)BOOL showResultIsNotEmpty;
@property(nonatomic)BOOL showExpressionNotEmpty;
@property(nonatomic)BOOL lastInputIsAOperate;         //标记最后一个输入的是不是符号
@property(nonatomic)BOOL pointNum;

@end

@implementation calculatorViewController
@synthesize showExpression=_showExpression;
@synthesize showResult=_showResult;
@synthesize expression=_expression;
@synthesize cal=_cal;
@synthesize showResultIsNotEmpty=_showResultIsNotEmpty;
@synthesize showExpressionNotEmpty=_showExpressionNotEmpty;
@synthesize lastOperate=_lastOperate;
@synthesize lastDigit=_lastDigit;
@synthesize lastInputIsAOperate=_lastInputIsAOperate;
@synthesize pointNum=_pointNum;


- (void)viewDidLoad
{
    [super viewDidLoad];
    self.expression=[[NSMutableString alloc]init];
    self.lastDigit=[[NSString alloc]init];
    self.lastOperate=[[NSString alloc]init];
    self.cal=[[calAchieve alloc]init];
    self.showResultIsNotEmpty=NO;
    self.showExpressionNotEmpty=NO;
    self.lastInputIsAOperate=NO;
    self.pointNum=NO;

	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//M相关操作
- (IBAction)MClear:(id)sender {
    [self.cal mClear];
    self.showResultIsNotEmpty=NO;
    self.pointNum=NO;
}

- (IBAction)MPlus:(id)sender {
    NSString *digit=self.showResult.text;
    [self.cal mPlus:[digit doubleValue]];
    self.showResultIsNotEmpty=NO;
    self.pointNum=NO;
}

- (IBAction)MMinus:(id)sender {
    NSString *digit=self.showResult.text;
    [self.cal mMinus:[digit doubleValue]];
    self.showResultIsNotEmpty=NO;
    self.pointNum=NO;
}

- (IBAction)MRead:(id)sender {
    [self.cal mRead];
    self.showResultIsNotEmpty=NO;
    self.pointNum=NO;
}

//删除一位
- (IBAction)Delete:(id)sender {
    if(![self.lastDigit isEqualToString:@""])
    {
        self.lastDigit=[NSString stringWithString:[self.lastDigit substringToIndex:(self.lastDigit.length-1)]];
        NSLog(@"%@",self.lastDigit);
        
    }else if(![self.expression isEqualToString:@""]){
        NSString * str=[[NSString alloc]init ];
        str=[self.expression substringToIndex:self.expression.length-1];
        [self.expression setString:str];
        NSLog(@"%@",self.expression);
    }
    self.showResult.text=self.lastDigit;
    self.showExpression.text=self.expression;
}

//AC键，所有清零
- (IBAction)allClear:(id)sender {
    self.cal=[[calAchieve alloc]init];
    [self.expression setString:@""];
    self.lastDigit=@"";
    self.lastOperate=@"";
    self.showResult.text=@"0";
    self.showExpression.text=@"";
    self.showResultIsNotEmpty=NO;
    self.showExpressionNotEmpty=NO;
    self.lastInputIsAOperate=NO;
}

//加减乘除括号
- (IBAction)operate:(UIButton *)sender {
    BOOL opJudge=NO;
    [self.expression appendString:self.lastDigit];
    self.lastDigit=@"";
    self.showResultIsNotEmpty=NO;
    self.pointNum=NO;
    NSString *op=[NSString stringWithString:[sender currentTitle]];
    if (!([self.expression characterAtIndex:self.expression.length-1]>='0'&&[self.expression characterAtIndex:self.expression.length-1]<='9')) {
        opJudge=[self.cal operate1:self.lastOperate operate2:op];
        if (opJudge==YES) {
            [self.expression appendString:op];
            self.lastOperate=op;
        }
    }
    else
    {
        if (self.showExpressionNotEmpty) {
            [self.expression appendString:op];
            self.lastOperate=op;
            self.lastInputIsAOperate=YES;
        }else if([op isEqualToString:@"("]){
            [self.expression appendString:op];
            self.lastOperate=op;
            self.lastInputIsAOperate=YES;
        }
    }
    self.showExpression.text=self.expression;

}

//输入数字
- (IBAction)digit:(UIButton *)sender {
    NSString *digitNum=[NSString stringWithString:[sender currentTitle]];
    self.lastInputIsAOperate=NO;
    self.showExpressionNotEmpty=YES;
    if (![digitNum isEqualToString:@"."]) {
        if (self.showResultIsNotEmpty) {
            self.showResult.text=[self.showResult.text stringByAppendingString:digitNum];
        }else{
            self.showResult.text=digitNum;
            self.showResultIsNotEmpty=YES;
        }
        self.lastDigit=[NSString stringWithFormat:@"%@%@",self.lastDigit,digitNum];
    }
    
    else if (self.pointNum==NO &&!([self.lastDigit isEqualToString:@""])) {
        self.showResult.text=[self.showResult.text stringByAppendingString:digitNum];
        self.lastDigit=[NSString stringWithFormat:@"%@%@",self.lastDigit,digitNum];
        self.pointNum=YES;
    }

}
- (IBAction)equal:(UIButton *)sender {
    NSString *res;
    if (self.showResultIsNotEmpty || [self.lastOperate isEqualToString:@")"]) {
        [self.expression appendString:self.lastDigit];
    }else{
        [self.expression setString:self.lastDigit];
    }
    self.showResultIsNotEmpty=NO;
    self.showExpression.text=self.expression;
    res=[self.cal result:self.expression];
    self.showResult.text=res;
    [self.expression setString:@""];
    self.lastDigit=@"";
    self.lastOperate=@"";
    self.showResultIsNotEmpty=NO;
    self.showExpressionNotEmpty=NO;
    self.lastInputIsAOperate=NO;
    
}
- (IBAction)negtive:(id)sender{
    self.lastDigit=[NSString stringWithFormat:@"%g",-[self.lastDigit doubleValue]];
    self.showResult.text=self.lastDigit;
}
- (IBAction)percent:(UIButton *)sender{
    self.lastDigit=[NSString stringWithFormat:@"%g",[self.lastDigit doubleValue]/100];
    self.showResult.text=self.lastDigit;
}




@end
