//
//  ViewController.m
//  mycalculator
//
//  Created by 蔡飞跃 on 14/11/4.
//  Copyright (c) 2014年 蔡飞跃. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
- (IBAction)num0:(id)sender;
- (IBAction)num1:(id)sender;
- (IBAction)num2:(id)sender;
- (IBAction)num3:(id)sender;
- (IBAction)num4:(id)sender;
- (IBAction)num5:(id)sender;
- (IBAction)num6:(id)sender;
- (IBAction)num7:(id)sender;
- (IBAction)num8:(id)sender;
- (IBAction)num9:(id)sender;
- (IBAction)point:(id)sender;
- (IBAction)equal_to:(id)sender;
- (IBAction)add:(id)sender;
- (IBAction)sub:(id)sender;
- (IBAction)mul:(id)sender;
- (IBAction)div:(id)sender;
- (IBAction)mod:(id)sender;
- (IBAction)mc:(id)sender;
- (IBAction)mr:(id)sender;
- (IBAction)m_add:(id)sender;
- (IBAction)m_sub:(id)sender;
- (IBAction)clear:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *resultPrint;
@property(strong, nonatomic) NSMutableString *resultString;
@property(strong, nonatomic) NSDecimalNumber *resultNum;
-(double) calculate:(char)operator :(double)data1 :(double)data2 ;
-(NSString *) removezero:(NSString *)tString;
-(double) judgeoperator:(char)ch :(NSMutableString *)mstring :(double) data1 :(double) data2;
@end

@implementation ViewController
@synthesize resultString;
@synthesize resultNum;


double data1;
double data2;
double storeData;
int switch_point=1;
int switch_data1=1;
char operator;


- (void)viewDidLoad {
    [super viewDidLoad];
    resultString=[[NSMutableString alloc] init];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//用可变字符串读入数据
- (IBAction)num0:(id)sender {
    [resultString appendString:@"0"];
    _resultPrint.text=resultString;
}

- (IBAction)num1:(id)sender {
    [resultString appendString:@"1"];
    _resultPrint.text=resultString;
}

- (IBAction)num2:(id)sender {
    [resultString appendString:@"2"];
    _resultPrint.text=resultString;
}

- (IBAction)num3:(id)sender {
    [resultString appendString:@"3"];
    _resultPrint.text=resultString;
}

- (IBAction)num4:(id)sender {
    [resultString appendString:@"4"];
    _resultPrint.text=resultString;
}

- (IBAction)num5:(id)sender {
    [resultString appendString:@"5"];
    _resultPrint.text=resultString;
}

- (IBAction)num6:(id)sender {
    [resultString appendString:@"6"];
    _resultPrint.text=resultString;
}

- (IBAction)num7:(id)sender {
    [resultString appendString:@"7"];
    _resultPrint.text=resultString;
}

- (IBAction)num8:(id)sender {
    [resultString appendString:@"8"];
    _resultPrint.text=resultString;
}

- (IBAction)num9:(id)sender {
    [resultString appendString:@"9"];
    _resultPrint.text=resultString;
}

- (IBAction)point:(id)sender {
    if(switch_point)
    {
        [resultString appendString:@"."];
        _resultPrint.text=resultString;
        switch_point=0;                     //设置开关，防止一个数字中可能出现2个小数点
    }
}

//去除末尾多余的0
-(NSString *) removezero:(NSString *)tString
{
    NSUInteger len = [tString length];
    char c='0';
    for(;len>0;len--)
    {
        c = [tString characterAtIndex:len-1];
        if(c!='0')
            break;
    }
    if(c=='.')
    {
        return [tString substringToIndex:len-1];
    }
    else
        return [tString substringToIndex:len];
}

//计算结果并输出
-(double) calculate:(char)operator :(double)data1 :(double)data2 {
    
    switch (operator) {
        case '+':
            data1+=data2;
            _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", data1]];
            break;
        case '-':
            data1-=data2;
            _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", data1]];
            break;
        case '*':
            data1*=data2;
            _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", data1]];
            break;
        case '/':
            if (data2)
            {
                data1/=data2;
                _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", data1]];
            }
            else
            {
                _resultPrint.text=@"Error";
                data1=0;
                switch_data1=1;
            }
            break;
        default:
            _resultPrint.text=@"Error";
            break;
    }
    return data1;
}


//处理多次按运算符的问题
-(double) judgeoperator:(char)ch :(NSMutableString *)mstring :(double) data1 :(double) data2
{
    if (switch_data1)
    {
        data1=[_resultPrint.text doubleValue];
        switch_data1=0;
    }
    else if([resultString length])
    {
        data2=[_resultPrint.text doubleValue];
        data1=[self calculate:operator :data1 :data2 ];
    }
    [resultString setString:@""];
    switch_point=1;
    return data1;
}


//按下等号，将data1中的数字与resultString转化的数字计算
- (IBAction)equal_to:(id)sender {
    if (operator)
    {
        if([resultString length])
        {
            data2=[_resultPrint.text doubleValue];
            data1=[self calculate:operator :data1 :data2 ];
            [resultString setString:@""];
        }
        else{
            _resultPrint.text=@"Error";
        }
        //此处可以实现自运算
        switch_point=1;
        operator=0;
    }
}

//加法
- (IBAction)add:(id)sender {
    
    //如果data1中已有数值，则需要注意的将结果计算出来并显示，然后再进行新的运算符运算

    data1=[self judgeoperator:operator :resultString :data1 :data2];
    operator='+';
}

//减法
- (IBAction)sub:(id)sender {
    
    data1=[self judgeoperator:operator :resultString :data1 :data2];
    operator='-';
}

//乘法
- (IBAction)mul:(id)sender {
    
    data1=[self judgeoperator:operator :resultString :data1 :data2];
    operator='*';
}

//除法
- (IBAction)div:(id)sender {
    
    data1=[self judgeoperator:operator :resultString :data1 :data2];
    operator='/';
}

//百分号,之前是按取余弄的
- (IBAction)mod:(id)sender {

    if([_resultPrint.text length])
        
        _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", 0.01*[_resultPrint.text floatValue]]];
    
        /*if(switch_data1)
        {
            data1=0.01*[_resultPrint.text floatValue];
            switch_data1=0;
            _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", data1]];
            [resultString setString:@""];
        }
        else
        {
            data2=0.01*[_resultPrint.text floatValue];
            _resultPrint.text =[self removezero:[NSString stringWithFormat:@"%f", data2]];
            resultString =[NSMutableString stringWithFormat:@"%f", data2];
        }*/
}

//清除存储的数字
- (IBAction)mc:(id)sender {
    storeData=0;
}

//存储显示的数字
- (IBAction)mr:(id)sender {
    storeData=[resultString doubleValue];
}

//将显示的数字加到存储的数字
- (IBAction)m_add:(id)sender {
    storeData+=[resultString doubleValue];
}

//存储的数字减去显示栏中的数字
- (IBAction)m_sub:(id)sender {
    storeData-=[resultString doubleValue];
}

//清除各种数字
- (IBAction)clear:(id)sender {
    [resultString setString:@""];
    _resultPrint.text=@"0";
    data1=0;
    data2=0;
    operator=0;
    switch_data1=1;
}

@end
