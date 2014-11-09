//
//  ViewController.m
//  Project2
//
//  Created by xvxvxxx on 14/11/4.
//  Copyright (c) 2014年 谢伟军. All rights reserved.
//
#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *labelScreen;

@property (nonatomic) BOOL dotTag;
//@property (nonatomic) BOOL plusOrMinusTag;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.labelScreen.adjustsFontSizeToFitWidth = YES;
    self.labelScreen.numberOfLines = 1;
    self.dotTag = NO;
    //    self.plusOrMinusTag = YES;
    
    
    //    self.lastNumber = 0;
    //    self.currentNumber = 0;
    self.memoryString = [NSMutableString stringWithString:@"0"];
    self.displayString = [NSMutableString stringWithString:@"0"];
    self.currentString = [NSMutableString stringWithString:@""];
    self.lastString = [NSMutableString stringWithString:@""];
    self.operatorStackLevel = [NSMutableString stringWithString:@"0"];
    self.stackLevelDictionary =[NSDictionary dictionaryWithObjectsAndKeys:@"1",@"+",@"1", @"-",@"2",@"*",@"2",@"/" ,@"2", @"%",@"0", @"=", nil];
    
    self.variableStack = [NSMutableArray array];
    self.operatorStack = [NSMutableArray array];
    [self initProcess];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma buttonMemory
- (IBAction)buttonMemory:(UIButton *)sender {
    double memoryNumber = [self.memoryString doubleValue];
    switch (sender.tag) {
        case 1:
            memoryNumber = 0;
            break;
        case 2:
            memoryNumber += [self.displayString doubleValue];
            break;
        case 3:
            memoryNumber -= [self.displayString doubleValue];
            break;
        case 4:
            self.displayString = self.memoryString;
            if ([self.memoryString isEqualToString:@"0"]) {
                self.labelScreen.text = @"0";
                return;
            }
            [self clearZero];
            [self display];
        default:
            break;
    }
    
    self.memoryString = [NSMutableString stringWithString:[NSString stringWithFormat:@"%.14lf",memoryNumber]];
}

#pragma buttonDelete
- (IBAction)buttonDelete:(UIButton *)sender {
    if ((self.labelScreen.text.length == 1) || (self.labelScreen.text.length == 2 && [self.labelScreen.text doubleValue] < 0 )) {
        [self.displayString setString:@"0"];
    }else{
        [self.displayString setString:[self.displayString substringToIndex:self.displayString.length-1]];
        if ([self.displayString characterAtIndex:self.displayString.length-1] == '.') {
            [self.displayString setString:[self.displayString substringToIndex:self.displayString.length-1]];
        }
    }
    
    [self display];
}

#pragma buttonBrckerts
- (IBAction)buttonBrackets:(UIButton *)sender {
    
    self.dotTag = NO;
    
    
    
    
    [self.lastString setString:self.currentString];
    switch (sender.tag) {
        case 1:
            [self.currentString setString:@"("];
            [self pushStack:self.operatorStack with:self.currentString];
            break;
        case 2:
            
            if (![self.operatorStack containsObject:@"("]) {
                [self.displayString setString:self.labelScreen.text];
                [self display];
                [self.currentString setString:@"("];
                [self.displayString setString:@"0"];
                return;
            }
            
            //若上次输入是 运算符 ，
            if ([self.lastString isEqualToString:@"+"]
                || [self.lastString isEqualToString:@"-"]
                || [self.lastString isEqualToString:@"*"]
                || [self.lastString isEqualToString:@"/"]){
                if ([self.operatorStack count]) {
                    [self popStack:self.operatorStack];
                }
            }
            //上次输入是 操作数
            else{
                [self pushStack:self.variableStack with:[NSString stringWithString:self.labelScreen.text]];
                
                
                double variable1 = [[self popStack:self.variableStack]doubleValue];
                double variable2 = [[self popStack:self.variableStack]doubleValue];
                //
                //弹出一个低级运算符
                NSString* operator = [NSString stringWithString:[self popStack:self.operatorStack]];
                
                //得到弹出低级运算符之后的栈等级
                //self.operatorStackLevel = [self.stackLevelDictionary objectForKey:[self.operatorStack lastObject]];
                
                //
                NSString* temp = [NSString stringWithString:[self calculateOperator:operator Number1:variable2 Number2:variable1]];
                //        NSLog(@"结果%@",temp);
                if ([temp isEqualToString:@"错误:除数为0"]) {
                    [self.displayString setString:@"错误:除数为0"];
                    [self display];
                    [self initProcess];
                    return;
                }
                
                //                [self pushStack:self.variableStack with:[NSString stringWithString:temp]];
                [self.displayString setString:temp];
                [self clearZero];
                [self display];
                
                
                
                
                
                [self.currentString setString:@")"];
                if ([self.operatorStack.lastObject isEqualToString:@"("]) {
                    [self popStack:self.operatorStack];
                    
#warning ) 运算
                    
                    
                }
                
                
                
                
                
                
                
                
                
                
                
            }
            break;
        default:
            break;
    }
    [self.displayString setString:@"0"];
}

#pragma buttonOprators
- (IBAction)buttonOps:(UIButton *)sender {
    
    [self.lastString setString:self.currentString];
    self.dotTag = NO;
    switch (sender.tag) {
            //ops + - * /
        case 1:
            [self.currentString setString:@"+"];
            break;
        case 2:
            [self.currentString setString:@"-"];
            break;
        case 3:
            [self.currentString setString:@"*"];
            break;
        case 4:
            [self.currentString setString:@"/"];
            break;
            // ops +-
        case 5:
        {
            [self.displayString setString:self.labelScreen.text];
            if ([self.displayString doubleValue] >= 0) {
                if ([self.displayString isEqualToString:@"-0"]) {
                    [self.displayString setString:@"0"];
                }
                else{
                    [self.displayString insertString:@"-" atIndex:0];
                }
                
            }else{
                [self.displayString deleteCharactersInRange:[self.displayString rangeOfString:@"-"]];
            }
            [self display];
            [self.currentString setString:self.displayString];
            [self.displayString setString:@"0"];
            return;
        }
            //ops =
        case 6:
            [self.currentString setString:@"+"];
            break;
            
            //ops %
        case 7:
        {
            NSString *temp = [NSString stringWithString:self.labelScreen.text];
            double tempDouble;
            NSString* tempString;
            //若运算符栈为空
            if (![self.variableStack count]) {
                tempDouble = [temp doubleValue]*0.01;
                tempString = [NSString stringWithFormat:@"%.14f",tempDouble];
            }
            //若运算符栈非空
            else{
                if ([self.operatorStack.lastObject isEqualToString:@"+"] || [self.operatorStack.lastObject isEqualToString:@"-"]) {
                    tempString = [self calculateOperator:self.operatorStack.lastObject
                                                 Number1:0
                                                 Number2:[self.variableStack.lastObject doubleValue]*0.01*[self.labelScreen.text doubleValue]];
                }
                else{
                    tempDouble = [temp doubleValue]*0.01;
                    tempString = [NSString stringWithFormat:@"%.14f",tempDouble];
                }
                
            }
            [self.displayString setString:tempString];
            [self.currentString setString:self.displayString];
            [self clearZero];
            [self display];
            
        }
            [self.displayString setString:@"0"];
            return;
            
        default:
            break;
    }
    
    
    
    
    
    
    //若运算符栈为空
    if (![self.operatorStack count]) {
        [self pushStack:self.variableStack with:[NSString stringWithString:self.displayString]];
        [self pushStack:self.operatorStack  with:[NSString stringWithString:self.currentString]];
        if ([sender.titleLabel.text isEqualToString:@"="]){
            [self clearStack:self.variableStack];
            [self clearStack:self.operatorStack];
            [self.displayString setString:self.labelScreen.text];
            [self.variableStack addObject:[NSString stringWithString:self.labelScreen.text]];
            //            [self.currentString setString:@"="];
            [self.currentString setString:self.labelScreen.text];
        }
        [self.displayString setString:@"0"];
        return;
    }
    //若上次输入是 运算符 ， 取消上次运算符 return
    if ([self.lastString isEqualToString:@"+"]
        || [self.lastString isEqualToString:@"-"]
        || [self.lastString isEqualToString:@"*"]
        || [self.lastString isEqualToString:@"/"]
        || [self.lastString isEqualToString:@"("]){
        if ([self.operatorStack count]) {
            [self popStack:self.operatorStack];
            //            NSLog(@"after pop %@",self.operatorStack.lastObject);
            [self pushStack:self.operatorStack with:[NSString stringWithString:self.currentString]];
            //            NSLog(@"after push %@",self.operatorStack.lastObject);
            [self.displayString setString:@"0"];
            return;
        }
    }
    //上次输入是 操作数
    else{
        [self pushStack:self.variableStack with:[NSString stringWithString:self.labelScreen.text]];
    }
    //若栈顶元素不是(
    if (![self.operatorStack.lastObject isEqualToString:@"("]) {
        NSString* inputLevel = [self.stackLevelDictionary objectForKey:self.currentString];
        //若运算符栈非空，取栈顶元素 得出栈内运算符等级
        self.operatorStackLevel = [self.stackLevelDictionary objectForKey:[self.operatorStack lastObject]];
        
        //输入运算符优先级 高于 站定运算符优先级
        while   ([[self.stackLevelDictionary objectForKey:[self.operatorStack lastObject]] intValue] >= [inputLevel intValue])  {
            //弹出两个栈顶操作数
            double variable1 = [[self popStack:self.variableStack]doubleValue];
            double variable2 = [[self popStack:self.variableStack]doubleValue];
            //
            //弹出一个低级运算符
            NSString* operator = [NSString stringWithString:[self popStack:self.operatorStack]];
            
            //得到弹出低级运算符之后的栈等级
            //self.operatorStackLevel = [self.stackLevelDictionary objectForKey:[self.operatorStack lastObject]];
            
            //
            NSString* temp = [NSString stringWithString:[self calculateOperator:operator Number1:variable2 Number2:variable1]];
            //        NSLog(@"结果%@",temp);
            if ([temp isEqualToString:@"错误:除数为0"]) {
                [self.displayString setString:@"错误:除数为0"];
                [self display];
                [self initProcess];
                return;
            }
            
            [self pushStack:self.variableStack with:[NSString stringWithString:temp]];
            [self.displayString setString:[self.variableStack lastObject]];
            [self clearZero];
            [self display];
            //        NSLog(@"###currentstring %@",self.currentString);
            //        [self.currentString setString:self.displayString];
        }
        [self pushStack:self.operatorStack with:[NSString stringWithString:self.currentString]];
        //模拟等号过程
        if ([sender.titleLabel.text isEqualToString:@"="]){
            [self.displayString setString:self.variableStack.lastObject];
            [self clearZero];
            [self display];
            [self initProcess];
            [self.displayString setString:self.labelScreen.text];
            //            [self.variableStack addObject:[NSString stringWithString:self.displayString]];
            [self.currentString setString:@"="];
            
        }
    }
    
    //若栈顶元素是(
    else{
        [self pushStack:self.operatorStack with:[NSString stringWithString:self.currentString]];
    }
    
    [self.displayString setString:@"0"];
    
    
    
}





#pragma buttonAC
- (IBAction)buttonAC:(UIButton *)sender {
    [self initProcess];
    self.labelScreen.text = @"0";
}

-(void)initProcess{
    [self.displayString setString:@"0"];
    [self.currentString setString:@""];
    [self.lastString setString:@""];
    [self clearStack:self.variableStack];
    [self clearStack:self.operatorStack];
    self.dotTag = NO;
    //    self.plusOrMinusTag = YES;
    self.operatorStackLevel = 0;
}

#pragma buttonDot
- (IBAction)buttonDot:(UIButton *)sender {
    if (!self.dotTag) {
        self.dotTag = YES;
        
        if ([self.displayString isEqualToString:@"0"]) {
            [self.displayString setString:@"0."];
        }
        else{
            [self.displayString appendString:[NSString stringWithFormat:@"."]];
        }
        [self display];
    }
}

#pragma buttonDigit
- (IBAction)buttonDigit:(UIButton *)sender {
    [self.lastString setString:self.currentString];
    //    if ([self.lastString isEqualToString:@"+"]
    //        || [self.lastString isEqualToString:@"-"]
    //        || [self.lastString isEqualToString:@"*"]
    //        || [self.lastString isEqualToString:@"/"]
    //        || [self.lastString isEqualToString:@"%"]
    //        || [self.lastString isEqualToString:@"="]){
    //        [self.displayString setString:@"0"];
    //    }
    NSString *inputDigit = sender.titleLabel.text;
    NSInteger digit = [inputDigit intValue];
    if ([self.displayString isEqualToString:@"0"]) {
        [self.displayString deleteCharactersInRange:[self.displayString rangeOfString:@"0"]];
        if (digit == 0) {
            [self.displayString setString:@"0"];
            [self.currentString setString:self.displayString];
            [self display];
            return;
        }
    }
    [self.displayString appendString:[NSString stringWithFormat:@"%i",digit]];
    [self.currentString setString:self.displayString];
    [self display];
    
    
}

#pragma 改变状态栏颜色为亮色
-(UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}


-(void)display{
    self.labelScreen.text = self.displayString;
}



-(void)processDot{
    [self.displayString appendString:[NSString stringWithFormat:@"."]];
}


#pragma stack methods

-(void)pushStack:(NSMutableArray *)stack with:(NSString *)string{
    [stack addObject:[NSString stringWithString:string]];
}

-(NSString *)popStack:(NSMutableArray *)stack{
    NSString *temp = [stack lastObject];
    [stack removeLastObject];
    return temp;
}

-(void)clearStack:(NSMutableArray *)stack{
    [stack removeAllObjects];
}


-(NSString *)calculateOperator:(NSString *)operator Number1:(double)number1 Number2:(double)number2{
    double temp;
    if ([operator isEqualToString:@"+"]) {
        temp = number1 + number2;
    }
    else if ([operator isEqualToString:@"-"]) {
        temp = number1 - number2;
    }
    else if ([operator isEqualToString:@"*"]) {
        temp = number1 * number2;
    }
    else if ([operator isEqualToString:@"/"]) {
        if (number2 == 0) {
            NSLog(@"Error");
            return @"错误:除数为0";
        }
        temp = number1 / number2;
    }
    return [NSString stringWithFormat:@"%.12f",temp];
    
    
}

-(void)clearZero{
    //处理memory中为1时，输出1.00000000的问题
    NSInteger length = [self.displayString length];
    //    NSLog(@"%d",length);
    while ([self.displayString characterAtIndex:(length-1)] == '0') {
        self.displayString = [NSMutableString stringWithString:[self.displayString substringToIndex:length-1]];
        length--;
    }
    if ([self.displayString characterAtIndex:(length-1)] == '.') {
        self.displayString = [NSMutableString stringWithString:[self.displayString substringToIndex:length-1]];
    }
    
}



@end