//
//  ViewController.m
//  project2
//
//  Created by shazhouyouren on 14/11/4.
//  Copyright (c) 2014年 shazhouyouren. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()


@end

@implementation ViewController

@synthesize m;
@synthesize exp;
@synthesize labelExp;
@synthesize labelResult;
@synthesize aryExp;
@synthesize bufExp;

NSInteger leftBracket;

- (void)viewDidLoad {
    m=@"0";
    leftBracket=0;
    exp = [[NSMutableString alloc] initWithString:@"0"];
    bufExp = [[NSMutableString alloc] initWithString:@"0"];
    aryExp = [NSMutableArray arrayWithCapacity:20];
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)viewDidUnload
{
    [self setLabelExp: nil];
    [self setLabelResult: nil];
    [super viewDidUnload];
}

- (IBAction)clickOne:(id)sender {
    [self numberAppend:@"1"];
}

- (IBAction)clickZero:(id)sender {
    [self numberAppend:@"0"];
}

- (IBAction)clickTwo:(id)sender {
    [self numberAppend:@"2"];
}

- (IBAction)clickThree:(id)sender {
    [self numberAppend:@"3"];
}

- (IBAction)clickFour:(id)sender {
    [self numberAppend:@"4"];
}

- (IBAction)clickFive:(id)sender {
    [self numberAppend:@"5"];
}

- (IBAction)clickSix:(id)sender {
    [self numberAppend:@"6"];
}

- (IBAction)clickSeven:(id)sender {
    [self numberAppend:@"7"];
}

- (IBAction)clickEight:(id)sender {
    [self numberAppend:@"8"];
}

- (IBAction)clickNine:(id)sender {
    [self numberAppend:@"9"];
}

- (IBAction)clickDot:(id)sender {
    //判断是否已输入了. 已经输入就不再添加.
    NSRange range = [bufExp rangeOfString: @"."];
    if (range.location == NSNotFound) {
        [bufExp appendString: @"."];
        //当数字时0时
        NSString *lastInput = [exp substringFromIndex:([exp length]-1)];
        if(![lastInput isEqualToString: @"0"] && [bufExp isEqualToString: @"0."]){
            [exp appendString: bufExp];
        }
        else{
            [exp appendString: @"."];
        }
    }
    [self showExpression];
}

-(IBAction)clickNeg:(id)sender{
    NSString *lastInput = [exp substringFromIndex:([exp length]-1)];
    NSArray *symbols= @[@"+",@"-",@"*",@"/",@"%",@"(", @")"];
    //如果上一个输入是数字 则处理bufExp，否则什么也不做
    if (![symbols containsObject:lastInput]) {
        //判断是否是负的
        NSString *firstBufChar = [bufExp substringToIndex:1];
        if([firstBufChar isEqualToString:@"-"]){
            [exp deleteCharactersInRange:NSMakeRange(([exp length]-[bufExp length]), 1)];
            [bufExp deleteCharactersInRange:NSMakeRange(0, 1)];
        }
        else{
            [exp insertString: @"-" atIndex:([exp length]-[bufExp length])];
            [bufExp insertString: @"-" atIndex:0];
        }
    }
    [self showExpression];
}

-(IBAction)clickOperator:(id)sender{
    NSString *title = [sender titleForState:UIControlStateNormal];
    NSMutableString *operator = [NSMutableString stringWithCapacity:1];
    if([title isEqualToString:@"÷"]){
        [operator appendString: @"/"];
    }
    else if([title isEqualToString:@"×"]){
        [operator appendString: @"*"];
    }
    else if([title isEqualToString:@"mod"]){
        [operator appendString: @"%"];
    }
    else{
        [operator appendString: title];
    }
    NSArray *brackets= @[@"(", @")"];
    NSArray *symbols1= @[@"+",@"-",@"*",@"/",@"%",@"(", @")"];
    NSArray *symbols2= @[@"+",@"-",@"*",@"/",@"%"];
    //计算括号的数目
    if ([operator isEqualToString:@"("]) {
        leftBracket++;
    }
    if ([operator isEqualToString:@")"]) {
        leftBracket--;
    }
    //如果首先输入了(
    if([exp isEqualToString:@"0"] && [title isEqualToString:@"("]){
        [exp setString:@"("];
        [aryExp addObject:@"("];
    }
    //如果首先输入了)则忽略
    else if([exp isEqualToString:@"0"] && [title isEqualToString:@")"]){
        
    }
    else{
        NSString *lastInput = [exp substringFromIndex:([exp length]-1)];
        //如果上次输入的是数字
        if (![symbols1 containsObject: lastInput]){
            //先把操作数放入数组aryExp
            if ([bufExp isEqualToString: @"0."]) {
                [bufExp setString: @"0"];
            }
            [self addToAryExp:bufExp];
            [bufExp setString: @"0"];
            //如果这次输入的不是左括号，将操作符加入aryExp
            if(![operator isEqualToString:@"("]){
                [exp appendString: operator];
                [aryExp addObject: operator];
            }
            //如果是左括号则不能输入
            else{
                
            }
        }
        //如果上次输入的是(
        else if([lastInput isEqualToString:@"("]){
            //如果这次是左括号，把它加入到aryExp
            if([operator isEqualToString:@"("]){
                [exp appendString: operator];
                [aryExp addObject: operator];
            }
            //如果是其他操作符，则不添加
            else{
                
            }
        }
        //如果上次输入的是)
        else if([lastInput isEqualToString:@")"]){
            //如果这次输入的不是左括号，将操作符加入aryExp
            if(![operator isEqualToString:@"("]){
                [exp appendString: operator];
                [aryExp addObject: operator];
            }
            //如果是左括号则不能输入
            else{
                
            }
        }
        //如果上次输入的是操作符
        else{
            //如果这次是左括号，把它加入到aryExp
            if([operator isEqualToString:@"("]){
                [exp appendString: operator];
                [aryExp addObject: operator];
            }
            //如果这次输入的也是运算符，则先删除上一个操作符 再添加此操作符
            else if([symbols2 containsObject: operator]){
                NSRange range = NSMakeRange([exp length]-1, 1);
                [exp deleteCharactersInRange:range];
                [aryExp removeLastObject];
                [exp appendString: operator];
                [aryExp addObject: operator];
            }
            //如果这次输入的是右括号，则不能添加
            else{
                
            }
        }
    }
    [self showExpression];
}

-(IBAction)clickAC:(id)sender{
    leftBracket=0;
    [bufExp setString: @"0"];
    [exp setString: @"0"];
    [aryExp removeAllObjects];
    [labelResult setText:@"0"];
    [self showExpression];
}

-(IBAction)clickDel:(id)sender{
    NSString *lastInput = [exp substringFromIndex:([exp length]-1)];
    NSArray *symbols= @[@"+",@"-",@"*",@"/",@"%",@"(", @")"];
    //如果exp只有一位
    if([exp length]==1){
        [exp setString: @"00"];
        [bufExp setString: @"0"];
        NSRange range = NSMakeRange([exp length]-1, 1);
        [exp deleteCharactersInRange:range];
        [self showExpression];
        return;
    }
    //如果删除的不是数字
    if ([symbols containsObject:lastInput]) {
        //把操作符从aryExp中删除
        [aryExp removeLastObject];
        //这时如果aryExp的最后一个表达式是数字，则赋给bufExp,同时讲数字移出aryExp
        if (![symbols containsObject:[aryExp lastObject]]) {
            [bufExp setString:[aryExp lastObject]];
            [aryExp removeLastObject];
        }
    }
    else{
        //如果bufExp不是“0”，则删除最后一位
        NSRange range1 = NSMakeRange([bufExp length]-1, 1);
        [bufExp deleteCharactersInRange:range1];
    }
    
    //删除最后一个字符
    NSRange range = NSMakeRange([exp length]-1, 1);
    [exp deleteCharactersInRange:range];
    [self showExpression];
}

-(IBAction)clickMC:(id)sender{
    m=@"0";
}
-(IBAction)clickMR:(id)sender{
    [exp setString:m];
    [bufExp setString:m];
    [aryExp removeAllObjects];
    [self showExpression];
}

-(IBAction)clickMM:(id)sender{
    [self mOperation:@"-"];
}
-(IBAction)clickMP:(id)sender{
    [self mOperation:@"+"];
    
}

-(void) mOperation:(NSString*) operator{
    //最后一个如果是数字，则加入到aryExp中
    NSString *lastInput = [exp substringFromIndex:([exp length]-1)];
    NSArray *symbols= @[@"+",@"-",@"*",@"/",@"%",@"(", @")"];
    if(![symbols containsObject:lastInput]){
        [self addToAryExp:bufExp];
        [bufExp setString:@"0"];
    }
    
    NSString *resStr = [self calExp:[self toSuffixExp:aryExp]];
    if(![resStr isEqualToString:error])
    {
        NSDecimalNumber * num1=[NSDecimalNumber decimalNumberWithString:m];
        NSDecimalNumber * num2=[NSDecimalNumber decimalNumberWithString:resStr];
        if ([operator isEqualToString:@"-"]) {
            m=[num1 decimalNumberBySubtracting:num2].stringValue;
        }
        else {
            m=[num1 decimalNumberByAdding:num2].stringValue;
        }
    }
    else{
        [labelResult setText: resStr];
        [exp setString:@"0"];
        [bufExp setString:@"0"];
        [aryExp removeAllObjects];
    }
    [self showExpression];
}

-(IBAction)clickEqual:(id)sender{
    //最后一个如果是数字，则加入到aryExp中
    NSString *lastInput = [exp substringFromIndex:([exp length]-1)];
    NSArray *symbols= @[@"+",@"-",@"*",@"/",@"%",@"(", @")"];
    if(![symbols containsObject:lastInput]){
        [self addToAryExp:bufExp];
        [bufExp setString:@"0"];
    }
    NSString *resStr = [self calExp:[self toSuffixExp:aryExp]];
    [labelResult setText: resStr];
    if ([resStr isEqualToString:error]) {
        [exp setString:@"0"];
        [bufExp setString:@"0"];
    }
    else{
        [exp setString:resStr];
        [bufExp setString:resStr];
    }
    [aryExp removeAllObjects];
    [self showExpression];
}

-(void)showExpression{
    [labelExp setText:exp];
    //test show array expression
    for(NSInteger i=0; i< [aryExp count]; i++){
        NSLog(@"%@, ", [aryExp objectAtIndex:i]);
    }
}

-(void)numberAppend:(NSString*)str{
    if ([exp isEqualToString:@"0"]) {
        [exp setString:str];
    }
    else {
        [exp appendString: str];
    }
    if ([bufExp isEqualToString: @"0"]) {
        [bufExp setString: str];
    }
    else{
        [bufExp appendString: str];
    }
    [self showExpression];
}

- (void)clearResult{
    [labelResult setText:@""];
}

- (void)addToAryExp:(NSString*)str{
    NSString *str2 = [NSString stringWithString:str];
    [aryExp addObject:str2];
}

- (NSArray*)toSuffixExp:(NSMutableArray*) aryExp{
    NSMutableArray *suffixAryExp = [NSMutableArray arrayWithCapacity:20];
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:20];
    NSArray *symbols= @[@"+",@"-",@"*",@"/",@"%",@"(", @")"];
    //把括号不全
    while(leftBracket!=0){
        [aryExp addObject:@")"];
        leftBracket--;
    }
    for (int i=0; i<[aryExp count]; i++) {
        NSString *current = [aryExp objectAtIndex:i];
        //是操作数就放入suffixAryExp
        if(![symbols containsObject:current]){
            [suffixAryExp addObject:current];
        }
        else{
            //如果是左括号则直接入栈
            if ([current isEqualToString:@"("]) {
                [stack addObject:current];
            }
            //如果是右括号则向前匹配
            else if ([current isEqualToString:@")"]) {
                //匹配“)”否则一直出栈
                while ([stack count]!=0) {
                    NSString *last=[stack lastObject];
                    [stack removeLastObject];
                    if (![last isEqualToString:@"("]) {
                        [suffixAryExp addObject:last];
                    } else {
                        break;
                    }
                }
            }
            else{
                //如果栈不为空，则按优先级出栈
                while([stack count] != 0) {
                    //如果当前是"+"或者"-"则全部出栈
                    NSString *last=[stack lastObject];
                    [stack removeLastObject];
                    //如果是左括号，则不出栈
                    if([last isEqualToString:@"("]){
                        [stack addObject:last];
                        break;
                    }
                    else if([last isEqualToString:@"*"] || [last isEqualToString: @"/"]){
                        [suffixAryExp addObject:last];
                    }
                    else{
                        if ([current isEqualToString: @"+"] || [current isEqualToString: @"-"]) {
                            [suffixAryExp addObject:last];
                        }
                        else{
                            [stack addObject:last];
                            break;
                        }
                    }
                }
                [stack addObject:current];
            }
        }
    }
    //将剩余的操作符出栈
    while ([stack count]!=0) {
        NSString *last=[stack lastObject];
        [stack removeLastObject];
        [suffixAryExp addObject:last];
    }
    
    return suffixAryExp;
}

- (NSString*)calExp:(NSArray*) suffixAryExp{
    NSMutableArray *stack = [NSMutableArray arrayWithCapacity:20];
    NSArray *operators= @[@"+",@"-",@"*",@"/",@"%"];
    for (int i=0; i<[suffixAryExp count]; i++) {
        NSString* current = suffixAryExp[i];
        //如果是数字则入栈
        @try {
            if(![operators containsObject:current])
            {
                [stack addObject:current];
            }
            //否则将栈顶两个元素取出进行运算，并将结果压入栈
            else
            {
                if ([stack count]>=2){
                    NSString *lastOne=[stack lastObject];
                    NSDecimalNumber *num1 = [NSDecimalNumber decimalNumberWithString: lastOne];
                    [stack removeLastObject];
                    NSString *lastTwo=[stack lastObject];
                    NSDecimalNumber *num2 = [NSDecimalNumber decimalNumberWithString: lastTwo];
                    [stack removeLastObject];
                    NSDecimalNumber * result;
                    if([current isEqualToString:@"+"])
                    {
                        result=[num2 decimalNumberByAdding:num1];
                    }
                    else if ([current isEqualToString:@"-"]) {
                        result=[num2 decimalNumberBySubtracting:num1];
                    }
                    else if ([current isEqualToString:@"*"]) {
                        result=[num2 decimalNumberByMultiplyingBy:num1];
                    }
                    else if ([current isEqualToString:@"/"]) {
                        if (num1 == 0){
                            return error;
                        }
                        result=[num2 decimalNumberByDividingBy:num1];
                    }
                    else {
                        result = [num2 decimalNumberByDividingBy:num1];
                        int temp= result.intValue;
                        result = [num2 decimalNumberBySubtracting: [[NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%d", temp]] decimalNumberByMultiplyingBy:num1]];
                    }
                    [stack addObject:result.stringValue];
                }
            }
        }
        @catch (NSException *exception)
        {
            return error;
            }
            @finally {
            }
        }
    if ([stack count]>1) {
        return error;
    }
    else{
        return [stack lastObject];
    }
}
@end
