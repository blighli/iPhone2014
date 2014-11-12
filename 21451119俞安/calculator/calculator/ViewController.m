//
//  ViewController.m
//  calculator
//
//  Created by apple on 14/11/6.
//  Copyright (c) 2014年 apple. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSMutableString *stringinlabel;
    NSMutableString *stringwithcal;
    NSDecimalNumber *num1;
    NSDecimalNumber *num2;
    NSDecimalNumber *nagnum;
    int clear;      //清空
    int clearzero;  //前面数字被清除
    int currentopr; //当前算数符号
    int numofopr;   //运算符号个数
    int isdot;      //当前是否有小数点
    int acadd;      
    NSDecimalNumber *mr;
}
@property int isopr;
@end

@implementation ViewController
@synthesize displaylabel;
@synthesize isopr;


- (void)viewDidLoad {
    
    
    [super viewDidLoad];
//    float width = _displaylabel.frame.size.width;
//    float height = _displaylabel.frame.size.height;
    
    
    CGRect rect=displaylabel.frame;
    NSLog(@"%f",rect.size.height);
    rect.size.height=200;
    // CGRect text=btnlogin.frame;
    NSLog(@"%f",rect.size.height);
    displaylabel.frame=rect;
    stringinlabel=[[NSMutableString alloc]init];
    [stringinlabel setString:@"0"]; //nsstring to nsmutablestring;
    displaylabel.text=stringinlabel;
    stringwithcal=[[NSMutableString alloc]init];
    isopr=0;// 没有运算符；
    clear=0;// 清空；
    clearzero=1;
    numofopr=0;
    acadd=0;
    mr=[NSDecimalNumber decimalNumberWithString:@"0"];
  }
//delete pre str
-(void)deleteprestring:(NSString *)str
{
    
    [stringinlabel setString:@""];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)operators:(id)sender {
    NSLog(@"press a operator");
    UIButton *button=(UIButton*)sender;
    //[button viewWithTag:1];
    NSLog(@"%@",[button currentTitle]);
    NSString * oper=[button currentTitle];
    
    
    if ([oper isEqual:@"±"]) { //相反数
        
        nagnum=[NSDecimalNumber decimalNumberWithString: stringinlabel];
        NSDecimalNumber *nag1=[NSDecimalNumber decimalNumberWithString:@"-1"];
        nagnum=[nagnum decimalNumberByMultiplyingBy:nag1];
        [stringinlabel setString:[nagnum stringValue]];
        displaylabel.text=stringinlabel;
        if (numofopr==2) {
            num2=[NSDecimalNumber decimalNumberWithString:stringinlabel];
        }
        else
            num1=[NSDecimalNumber decimalNumberWithString:stringinlabel];
        
        
    }
    else
    {
        isdot=0;
        isopr=1;
        numofopr++;
        acadd=1;
        clearzero=1;
        //连续按 运算符
        if (numofopr>=2) {
            numofopr=2;
            num1=[self calculatebyoper:currentopr];
            displaylabel.text=[num1 stringValue];
            [stringinlabel setString:displaylabel.text];
            clearzero=1;
            
            
        }
        
        
        //➗
        if ([oper isEqual:@"➗"]) {
            
            currentopr=3;
        }
        //✖️
        if ([oper isEqual:@"✖️"]) {
            currentopr=2;
        }
        //➖
        if ([oper isEqual:@"➖"]) {
            currentopr=1;
        }
        //➕
        if ([oper isEqual:@"➕"]) {
            currentopr=0;
        }
        if ([oper isEqual:@"%"]) {
            
            currentopr=4;
        }
        //±
        
    }
    
        
}
    


- (IBAction)NumberPress:(id)sender {
    
    NSLog(@"press a number");
    UIButton *button=(UIButton*)sender;
    NSString *num=[button currentTitle];

    if(!clear)//清空状态
    {
        NSLog(@"state=clear");
        clear=1;
        
        [self deleteprestring:@"asa"];//删除之前的数字
        if (!isopr) {
           // [stringinlabel appendString:num];
            //[stringwithcal appendString:num];
            displaylabel.text=stringinlabel;
            num1=[NSDecimalNumber decimalNumberWithString:stringinlabel];
        }
    }
    if(clear)//非清空状态
    {
        
    
    if (isopr) {//有运算符
        
        
        if (clearzero) {//前面数字没有被清除过
            [self deleteprestring:[button currentTitle]];
            clearzero=0;//前面数字以及被清除过了
            [stringinlabel appendString:num];
            displaylabel.text=stringinlabel;
            num2=[NSDecimalNumber decimalNumberWithString:stringinlabel];
        }
        else{
            [stringinlabel appendString:num];
            displaylabel.text=stringinlabel;
            num2=[NSDecimalNumber decimalNumberWithString:stringinlabel];
        }
    }
    else{
        
        [stringinlabel appendString:num];
        displaylabel.text=stringinlabel;
        num1=[NSDecimalNumber decimalNumberWithString:stringinlabel] ;
    }
    }
    
}
-(NSDecimalNumber*)calculatebyoper:(int)option
{
    NSLog(@"jisuanzhong");
    double a;
//    NSDecimalNumber *aNumber = [NSDecimalNumber decimalNumberWithString:@"9"];
//    NSDecimalNumber *bNumber = [NSDecimalNumber decimalNumberWithString:@"11"];
    
    switch (option) {
        case 0:
            return [num1 decimalNumberByAdding:num2];
            break;
        case 1:
            return [num1 decimalNumberBySubtracting:num2];
            break;
        case 2:
            return [num1 decimalNumberByMultiplyingBy:num2];
            break;
        case 3:
            return [num1 decimalNumberByDividingBy:num2];
            break;
        case 4:
            
        {
            a=fmod([[num1 stringValue]doubleValue], [[num2 stringValue]doubleValue]);
            NSString *s=[NSString stringWithFormat:@"%f",a];
            NSDecimalNumber *mod=[NSDecimalNumber decimalNumberWithString:s];
            return mod;
            
        }
           break;
            
        default: return 0;
            break;
    }

}

- (IBAction)clearAll:(id)sender {
    NSLog(@"ac");
    isopr=0;
    clear=0;
    clearzero=1;
    numofopr=0;
    isdot=0;
    acadd=0;
    [stringinlabel setString:@"0"];
    displaylabel.text =stringinlabel;
}

- (IBAction)calReslut:(id)sender {
    NSLog(@"result");
    clearzero=1;
    numofopr=0;
    
  
    isdot=0;
    //[self calculatebyoper:0]
    if (!isopr&&!acadd) {
        displaylabel.text=stringinlabel;

    }
    else
    { num1=[self calculatebyoper:currentopr];
    
    displaylabel.text=[num1 stringValue];
    [stringinlabel setString:displaylabel.text];
           }
    isopr=0;
    clear=0;
}

- (IBAction)deleteNum:(id)sender {
    if ([stringinlabel length]>1) {
        NSLog(@"ziduan >1");
        [stringinlabel substringToIndex:([stringinlabel length]-1) ];
        //[aString substringToIndex:([aString length]-1)];//字符串删除最后一个字符 //字符串删除最后一个字符     [aStr deleteCharactersInRange:range];
        NSRange range = {[stringinlabel length]-1,1};
        [stringinlabel deleteCharactersInRange:range];
        displaylabel.text=stringinlabel;
        if (numofopr==2) {
            num2=[NSDecimalNumber decimalNumberWithString:stringinlabel];
        }
        else
            num1=[NSDecimalNumber decimalNumberWithString:stringinlabel];
    }
    else
    {
        NSLog(@"字段<1");
        [stringinlabel setString:@"0"];
        clear=0;
        displaylabel.text=stringinlabel;
    }
    }

- (IBAction)dotPress:(id)sender {
    NSLog(@"press .");
    
    if (!isdot) {//前面没有 dot
        [stringinlabel appendFormat:@"."];
    displaylabel.text=stringinlabel;
    }
    isdot=1;
    
}

- (IBAction)memClear:(id)sender {
    
    mr=[NSDecimalNumber decimalNumberWithString:@"0"];
    
}

- (IBAction)memInput:(id)sender {
    UIButton *button=(UIButton*)sender;
    NSString *mc=[button currentTitle];
    isopr=1;
    if ([mc isEqualToString:@"M+"]) {
        
        mr=[mr decimalNumberByAdding:[NSDecimalNumber decimalNumberWithString:stringinlabel]];
    }
    
    if ([mc isEqualToString:@"M—"]) {
        NSLog(@"m-");
        mr=[mr decimalNumberBySubtracting:[NSDecimalNumber decimalNumberWithString:stringinlabel]];

        
    }
    
}

- (IBAction)memShow:(id)sender {
    
    [stringinlabel setString:[mr stringValue]];
    displaylabel.text=stringinlabel;
    if (numofopr==2) {
        num2=[NSDecimalNumber decimalNumberWithString:stringinlabel];
    }
    else
        num1=[NSDecimalNumber decimalNumberWithString:stringinlabel];
}



@end
