//
//  ViewController.m
//  calculate
//
//  Created by liug on 14-11-5.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import "ViewController.h"


#define MAXSIZE 200
Boolean isright;
@interface ViewController ()

@end

@implementation ViewController
@synthesize display,string,onenum,memory;
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.string=[[NSMutableString alloc]init];
    isright=YES;
    memory=0;
    onenum=0;
}
- (void)pressButton:(id)sender {
    [self.string appendString:[sender currentTitle]];
    self.display.text=[NSString stringWithString:string];//显示输入

}
- (void)ACpress:(id)sender {
    self.display.text=@"";
    [self.string setString:@""];
}

- (void)DELpress:(id)sender {
    if(![self.string isEqualToString:@""]){
        
        [self.string deleteCharactersInRange:NSMakeRange([self.string length]-1,1)];//删除最后一个字符
        self.display.text=[NSString stringWithString:string];//显示结果
    }
}
- (void)equalresult:(id)sender {
    [self.string appendString:[sender currentTitle]];
    char str[MAXSIZE], exp[MAXSIZE];
    double answer;
    int i;
    for(i=0;[self.string characterAtIndex:i]!='=';i++){
        str[i]=[self.string characterAtIndex:i];
    }
    str[i++]='#';
    str[i]='\0';
    [self Translate:str another:exp];
    answer=[self CompValue:exp];
    onenum=answer;
    if(isright==YES){
        [self.string appendString:[NSString stringWithFormat:@"%g",answer ]];
        self.display.text=[NSString stringWithString:string];
        [self.string setString:@""];
    }
    else {
        [self.display setText:@"wrong"];
        [self.string setString:@""];
        isright=YES;
    }
}
- (IBAction)MCpress:(id)sender {
    memory=0;
}
- (IBAction)Mplus:(id)sender {
    memory=memory+onenum;
    [self.string setString:[NSString stringWithFormat:@"%g",memory]];
    self.display.text=[NSString stringWithString:string];
    [self.string setString:@""];
}
- (IBAction)M_press:(id)sender {
    memory=memory-onenum;
    [self.string setString:[NSString stringWithFormat:@"%g",memory]];
    self.display.text=[NSString stringWithString:string];
    [self.string setString:@""];
}
- (IBAction)MR:(id)sender {
    [self.string setString:[NSString stringWithFormat:@"%g",memory]];
    self.display.text=[NSString stringWithString:string];
    [self.string setString:@""];
}

- (void)  Translate:(const char []) str another: (char []) exp //转换为逆波兰表达式
{
    char stack[MAXSIZE];
    int i = 0, k = 0, top = -1;
    
    while (str[i] != '#')
    {
        if (str[i] == '(') //直接将'('入栈
        {
            stack[++top] = str[i++];
        }
        else if (str[i] == ')')
        {
            while (top >= 0 && stack[top] != '(') //将'('之前的符号出栈，并存储到逆波兰表达式
            {
                exp[k++] = stack[top--];
            }
            
            if (top < 0) //'('不足，即有多余的')'
            {
                isright=NO;
                exp[k++] = '\0';
                return ;
            }
            top--;//去掉 '('
            i++;
        }
        else if (str[i] == '+' || str[i] == '-')
        {
            while (top >= 0 && stack[top] != '(') //如果有'('，将'('之前的符号出栈，否则所有符号出栈，并存储到逆波兰表达式
            {
                exp[k++] = stack[top--];
            }
            stack[++top] = str[i++]; //将新的运算符号入栈
        }
        else if (str[i] == '*' || str[i] == '/'||str[i]=='%')
        {
            while (top >= 0 && (stack[top] == '*' || stack[top] == '/'||str[i]=='%')) //将'*'和'/'之前的符号出栈，并存储到逆波兰表达式
            {
                exp[k++] = stack[top--];
            }
            stack[++top] = str[i++]; //将新的运算符号入栈
        }
        else
        {
            while ((str[i] >= '0' && str[i] <= '9') || str[i] == '.') //将浮点数直接存储到逆波兰表达式
            {
                exp[k++] = str[i++];
            }
            exp[k++] = '#'; //增加一个浮点数结束符号，以便正确提取浮点数
        }
    }
    
    while (top >= 0) //将栈中所有运算符号存储到逆波兰表达式
    {
        if (stack[top] == '(') //有多余的'('
        {
            isright=NO;
            exp[k++] = '\0';
            return ;
        }
        exp[k++] = stack[top--];
    }
    
    exp[k++] = '\0';
}

- (double) CompValue:(const char *)exp //求逆波兰表达式的值
{
    char tempStr[MAXSIZE];
    double stack[MAXSIZE];
    int i = 0, k = 0, top = -1;
    stack[0]=0;
    while (exp[i] != '\0')
    {
        if (exp[i] >= '0' && exp[i] <= '9')
        {
            k = 0;
            while (exp[i] != '#')
            {
                tempStr[k++] = exp[i++];
            }
            tempStr[k] = '\0';
            stack[++top] = [self CharToDouble:tempStr];
            i++; //跳过'#'
        }
        else
        {
            switch (exp[i++]) //将计算结果入栈，并退出多余的数字
            {
                case '+' : stack[top-1] += stack[top];
                    break;
                case '-' : stack[top-1] -= stack[top];
                    break;
                case '*' : stack[top-1] *= stack[top];
                    break;
                case '%' : if((stack[top-1]-(int)stack[top-1])<0.000000001&&(stack[top-1]-(int)stack[top-1])>-0.000000001&&(stack[top]-(int)stack[top])<0.000000001&&(stack[top]-(int)stack[top])>-0.000000001)stack[top-1]=(int)stack[top-1]%(int)stack[top];
                else isright=NO;
                    break;
                case '/' : if (stack[top] != 0)
                {
                    stack[top-1] /= stack[top];
                }
                else
                {
                    isright=NO;;
                    return 0;
                }
                    break;
            }
            top--; //退出多余的数字
        }
    }
    
    return stack[top];
}

-(double) CharToDouble:(const char *)str //将数字字符串转换为浮点数
{
    double sumInt = 0, sumDec = 0, e = 1;
    int i = 0;
    
    while (str[i] >= '0' && str[i] <= '9')
    {
        sumInt = sumInt * 10 + str[i++] - '0';
    }
    
    if (str[i] == '.') //如果含小数，处理小数部分
    {
        while (str[++i] != '\0')
        {
            sumDec = sumDec * 10 + str[i] - '0';
            e *= 10;
        }
    }
    
    return sumInt + sumDec / e;
}



@end
