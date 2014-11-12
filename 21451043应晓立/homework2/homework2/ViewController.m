//
//  ViewController.m
//  homework2
//
//  Created by yingxl1992 on 14/11/3.
//  Copyright (c) 2014年 21451043应晓立. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

//用于存储输入的全部字符
NSMutableArray *input;

//记忆结果，默认为0
NSDecimalNumber *pre;

//记录当前计算结果
NSDecimalNumber *res;

//记录错误类型，0为没有错误，1为表达式格式错误，2为计算异常，3为程序异常
NSInteger errorflag=0;

- (void)viewDidLoad {
    [super viewDidLoad];
    [_btn_res addTarget:self action:@selector(calResult) forControlEvents:1];
    [_btn_one addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_two addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_three addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_four addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_five addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_six addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_seven addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_eight addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_nine addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_zero addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_left addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_right addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_sum addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_min addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_multi addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_div addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_double addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_per addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_del addTarget:self action:@selector(deleteInput:) forControlEvents:1];
    [_btn_point addTarget:self action:@selector(addInput:) forControlEvents:1];
    [_btn_ac addTarget:self action:@selector(deleteAll) forControlEvents:1];
    [_btn_mr addTarget:self action:@selector(showpre) forControlEvents:1];
    [_btn_m1 addTarget:self action:@selector(sumpre) forControlEvents:1];
    [_btn_m2 addTarget:self action:@selector(minpre) forControlEvents:1];
    [_btn_mc addTarget:self action:@selector(delpre) forControlEvents:1];
    
    pre=[NSDecimalNumber zero];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击m+触发的事件
-(void)sumpre {
    if (res!=nil) {
        pre=[pre decimalNumberByAdding:res];
    }
}

//点击m-触发的事件
-(void)minpre {
    if (res!=nil) {
        pre=[pre decimalNumberBySubtracting:res];
    }
}

//点击mc触发的时间
-(void)delpre {
    pre=[NSDecimalNumber zero];
    [self showpre];
}

//点击mr触发的事件
-(void)showpre {
    [_label_res setText:[NSString stringWithFormat:@"%@",pre]];
}

//点击del触发的事件
-(void)deleteInput:(id)sender{
    [input removeLastObject];
    if([input count]==0){
        [_label_res setText:@"0"];
    }else{
        [self echo];
    }
}

//点击ac触发的事件
-(void)deleteAll {
    input=nil;
    [_label_res setText:@"0"];
}

//点击=触发的事件
-(void)calResult{
    
    errorflag=0;
    
    @try {
        //把字符串转化成连续数字
        input=[self transferToNum:input];
        NSLog(@"转换成数字后为%@",input);
    
        if (errorflag==0) {
            //检查并补齐括号
            input=[self checkAndAddBracket:input];
            NSLog(@"去括号为%@",input);
        }
    
        if (errorflag==0) {
            //转化成后缀表达式
            input=[self transferToPost:input];
            NSLog(@"后缀表达式为%@",input);
        }
        
        if (errorflag==0) {
            //计算后缀表达式
            res=[self calPost:input];
            NSLog(@"计算结果为%@",res);
        }
    }
    @catch (NSException *exception) {
        errorflag=3;
        NSLog(@"%@",exception);
    }
    @finally
    {
        [self echoResult:res];
        input=nil;
    }
}

//显示结果
-(void)echoResult:(NSDecimalNumber *)res {
    if(res==nil){
        [_label_res setText:[NSString stringWithFormat:@"结果异常"]];
    }
    else{
        if (errorflag==3) {
            [_label_res setText:@"程序异常"];
        }
        else if(errorflag==0){
            [_label_res setText:[NSString stringWithFormat:@"%@",res]];
        }
        else if(errorflag==1){
            [_label_res setText:@"表达式格式错误"];
        }
        else if (errorflag==2){
            [_label_res setText:@"结果异常"];
        }
    }
    errorflag=0;
}

//把字符串转化成连续数字
-(NSMutableArray *)transferToNum:(NSMutableArray *)input {
    NSMutableArray *newstring=[[NSMutableArray alloc]init];
    NSMutableString *num=nil;
    for (NSString *temp in input) {
        if([self isSymbol:temp]==1||[self isBracket:temp]==1) {
            if(num!=nil){
                num=[self checkAndRemovePointer:num];
                [newstring addObject:num];
                num=nil;
            }
            [newstring addObject:temp];
            
        }else{
            if(num==nil){
                num=[[NSMutableString alloc]init];
            }
            [num appendString:temp];
        }
    }
    if(num!=nil){
        num=[self checkAndRemovePointer:num];
        [newstring addObject:num];
        num=nil;
    }
    return newstring;
}

//检查并补齐括号
-(NSMutableArray *)checkAndAddBracket:(NSMutableArray *)newstring {
    NSInteger l=0;
    NSInteger r=0;
    NSInteger len=[newstring count];
    for (NSInteger i=0;i<len;i++) {
        NSString *t=[newstring objectAtIndex:i];
        if([t compare:@"("]==NSOrderedSame){
            l++;
        }else if ([t compare:@")"]==NSOrderedSame){
            r++;
            if(r>l){
                [newstring removeObjectAtIndex:i];
                r--;
                len--;
                i--;
            }
        }
    }
    if(l>r){
        for (NSInteger i=0; i<l-r;i++) {
            [newstring addObject:@")"];
        }
    }
    return newstring;
}

//转化成后缀表达式
-(NSMutableArray *)transferToPost:(NSMutableArray *)inString {
    
    NSMutableArray *postString=[[NSMutableArray alloc]init];
    
    NSMutableArray *stackString=[[NSMutableArray alloc]init];
    NSInteger top=0;
    
    for (NSString *temp in inString) {
        if([temp compare:@"("]==NSOrderedSame) {
            [stackString addObject:@"("];
            top++;
        }else if([temp compare:@")"]==NSOrderedSame) {
            NSString *topstring=[[NSString alloc]init];
            while(top>0){
                topstring=[stackString objectAtIndex:top-1];
                if([topstring compare:@"("]==NSOrderedSame){
                    [stackString removeObjectAtIndex:top-1];
                    top--;
                    break;
                }else{
                    [postString addObject:topstring];
                    [stackString removeObjectAtIndex:top-1];
                }
                
                top--;
            }
        }else if ([temp compare:@"+"]==NSOrderedSame||[temp compare:@"-"]==NSOrderedSame) {
            NSString *topstring=[[NSString alloc]init];
            while(top>0){
                topstring=[stackString objectAtIndex:top-1];
                if([topstring compare:@"("]==NSOrderedSame){
                    break;
                }
                [postString addObject:topstring];
                [stackString removeObjectAtIndex:top-1];
                top--;
            }
            [stackString addObject:temp];
            top++;
        }else if([temp compare:@"×"]==NSOrderedSame||[temp compare:@"÷"]==NSOrderedSame||[temp compare:@"%"]==NSOrderedSame||[temp compare:@"±"]==NSOrderedSame) {
            NSString *topstring=[[NSString alloc]init];
            
            while (top>0) {
                topstring=[stackString objectAtIndex:top-1];
                if ([topstring compare:@"("]==NSOrderedSame||[topstring compare:@"+"]==NSOrderedSame||[topstring compare:@"-"]==NSOrderedSame) {
                    break;
                }
                [postString addObject:topstring];
                [stackString removeObject:topstring];
                top--;
            }
            [stackString addObject:temp];
            top++;
        }else{
            [postString addObject:temp];
        }
    }
    while (top>0) {
        [postString addObject:[stackString objectAtIndex:top-1]];
        [stackString removeObjectAtIndex:top-1];
        top--;
    }
    return postString;
}

//计算后缀表达式
-(NSDecimalNumber *)calPost:(NSMutableArray *)string {
    NSDecimalNumber *result;
    NSMutableArray *stackString=[[NSMutableArray alloc]init];
    NSInteger top=0;
    if([string count]==1){
        return [NSDecimalNumber decimalNumberWithString:[string objectAtIndex:0]];
    }
    for (NSString *temp in string) {
        if([self isSymbol:temp]==1) {
            if([temp compare:@"+"]==NSOrderedSame) {
                if (top<2) {
                    errorflag=1;
                    return nil;
                }
                NSString *string1=[stackString objectAtIndex:top-2];
                NSString *string2=[stackString objectAtIndex:top-1];
                NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:string1];
                NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:string2];
                [stackString removeObjectAtIndex:top-1];
                top--;
                [stackString removeObjectAtIndex:top-1];
                top--;
                
                result=[num1 decimalNumberByAdding:num2];
            }
            else if ([temp compare:@"-"]==NSOrderedSame) {
                if (top<2) {
                    errorflag=1;
                    return nil;
                }
                NSString *string1=[stackString objectAtIndex:top-2];
                NSString *string2=[stackString objectAtIndex:top-1];
                NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:string1];
                NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:string2];
                [stackString removeObjectAtIndex:top-1];
                top--;
                [stackString removeObjectAtIndex:top-1];
                top--;
                
                result=[num1 decimalNumberBySubtracting:num2];
            }
            else if ([temp compare:@"×"]==NSOrderedSame) {
                if (top<2) {
                    errorflag=1;
                    return nil;
                }
                NSString *string1=[stackString objectAtIndex:top-2];
                NSString *string2=[stackString objectAtIndex:top-1];
                NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:string1];
                NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:string2];
                [stackString removeObjectAtIndex:top-1];
                top--;
                [stackString removeObjectAtIndex:top-1];
                top--;
                
                result=[num1 decimalNumberByMultiplyingBy:num2];
            }
            else if ([temp compare:@"÷"]==NSOrderedSame) {
                
                NSString *string1=[stackString objectAtIndex:top-2];
                NSString *string2=[stackString objectAtIndex:top-1];
                NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString:string1];
                NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString:string2];
                [stackString removeObjectAtIndex:top-1];
                top--;
                [stackString removeObjectAtIndex:top-1];
                top--;
                if([num2 compare:[NSDecimalNumber decimalNumberWithString:@"0"]]==NSOrderedSame){
                    errorflag=2;
                    return nil;
                }
                if (top<2) {
                    errorflag=1;
                    return nil;
                }
                
                result=[num1 decimalNumberByDividingBy:num2];
            }
            else if ([temp compare:@"%"]==NSOrderedSame){
                if(top<1) {
                    errorflag=1;
                    return nil;
                }
                
                NSString *string=[stackString objectAtIndex:top-1];
                NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:string];
                [stackString removeObjectAtIndex:top-1];
                top--;
                
                NSDecimalNumber *per=[[NSDecimalNumber alloc]initWithString:@"100"];
                result=[num decimalNumberByDividingBy:per];
            }
            else {
                if(top<1) {
                    errorflag=1;
                    return nil;
                }
                NSString *string=[stackString objectAtIndex:top-1];
                NSDecimalNumber *num = [NSDecimalNumber decimalNumberWithString:string];
                [stackString removeObjectAtIndex:top-1];
                top--;
                result=[self handleNegative:num];
            }
            
            [stackString addObject:[NSString stringWithFormat:@"%@",result]];
            top++;
        }else{
            [stackString addObject:temp];
            top++;
        }
    }
    return result;
}

//正负转换
-(NSDecimalNumber *)handleNegative:(NSDecimalNumber *)result {
    NSMutableString *nnum=[[NSMutableString alloc]initWithFormat:@"%@",result];
    if([nnum characterAtIndex:0]=='-'){
        [nnum deleteCharactersInRange:NSMakeRange(0, 1)];
    }
    else{
        [nnum insertString:@"-" atIndex:0];
    }
    return [[NSDecimalNumber alloc]initWithString:nnum];
}

//检查并删除多余.
-(NSMutableString *)checkAndRemovePointer:(NSMutableString *)num {
    NSInteger len=[num length];
    NSInteger count=0;
    if([num characterAtIndex:0]=='.'){
        [num insertString:@"0" atIndex:0];
    }
    for(NSInteger i=0;i<len;i++){
        if([num characterAtIndex:i]=='.'){
            count++;
            if(count>1){
                [num deleteCharactersInRange:NSMakeRange(i, 1)];
                i--;
                len--;
                count--;
            }
        }
    }
    return num;
}

//点击数字和运算符按钮后触发的事件
-(void)addInput:(id)sender{
    if(input==nil){
        input=[[NSMutableArray alloc]init];
    }
    UIButton *btn=(UIButton *)sender;
    NSString *title=[btn currentTitle];
    [input addObject:title];
    [self echo];
}

//将点击的内容回显到label
-(void)echo{
    if(errorflag==0){
        NSMutableString *output=[[NSMutableString alloc]init];
        for (NSString *temp in input) {
            [output appendString:temp];
        }
        [_label_res setText:output];
        output=nil;
    }
    else if(errorflag==1){
        [_label_res setText:@"表达式格式错误"];
    }
    else if (errorflag==2){
        [_label_res setText:@"结果异常"];
    }
    else if (errorflag==3){
        [_label_res setText:@"程序异常"];
    }
}

//判断是否为运算符
-(NSInteger)isSymbol:(NSString *)string {
    if([string compare:@"+"]==NSOrderedSame||[string compare:@"-"]==NSOrderedSame||[string compare:@"×"]==NSOrderedSame||[string compare:@"÷"]==NSOrderedSame||[string compare:@"%"]==NSOrderedSame||[string compare:@"±"]==NSOrderedSame) {
        return 1;
    }else{
        return 0;
    }
}

//判断是否为数字
-(NSInteger)isNumber:(NSString *)string {
    if([string compare:@"0"]==NSOrderedSame||[string compare:@"1"]==NSOrderedSame||[string compare:@"2"]==NSOrderedSame||[string compare:@"3"]==NSOrderedSame||[string compare:@"4"]==NSOrderedSame||[string compare:@"5"]==NSOrderedSame||[string compare:@"6"]==NSOrderedSame||[string compare:@"7"]==NSOrderedSame||[string compare:@"8"]==NSOrderedSame||[string compare:@"9"]==NSOrderedSame){
        return 1;
    }
    return 0;
}

//判断是否为括号
-(NSInteger)isBracket:(NSString *) str{
    if ([str compare:@"("]==NSOrderedSame||[str compare:@")"]==NSOrderedSame) {
        return 1;
    }
    return 0;
}
@end
