//
//  ViewController.m
//  Calculator
//
//  Created by Chencheng on 14/11/4.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()

@end
NSMutableString *expression;
NSMutableArray *suffixexpression;
float memorydata;
float result;
const char empty = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    expression = [[NSMutableString alloc] init];
    self.textField.text=@"0";
    self.textField.adjustsFontSizeToFitWidth=YES;
    self.textField.minimumFontSize=17;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)backgroundTap:(id)sender
{
    [self.textField resignFirstResponder];
}


-(IBAction)brackets:(UIButton *)sender
{//处理括号
    switch (sender.tag) {
        case 1:
            [expression appendString:@"("];
            break;
        case 2:
            [expression appendString:@")"];
            break;
        default:
            break;
    }
    self.textField.text=expression;
}

-(IBAction)numberandPoint:(UIButton *)sender

{//处理数字和小数点
    switch (sender.tag) {
         case 0:
            [expression appendString:@"0"];
            break;
         case 1:
            [expression appendString:@"1"];
            break;
         case 2:
            [expression appendString:@"2"];
            break;
         case 3:
            [expression appendString:@"3"];
            break;
         case 4:
            [expression appendString:@"4"];
            break;
         case 5:
            [expression appendString:@"5"];
            break;
         case 6:
            [expression appendString:@"6"];
            break;
         case 7:
            [expression appendString:@"7"];
            break;
         case 8:
            [expression appendString:@"8"];
            break;
         case 9:
            [expression appendString:@"9"];
            break;
         case 10:
            [expression appendString:@"."];
            break;
        default:
            break;
    }
    self.textField.text=expression;
}

-(IBAction)Calculator:(UIButton *)sender
{//处理运算符
    switch (sender.tag) {
        case 1:
            [expression appendString:@"+"];
            break;
        case 2:
            [expression appendString:@"-"];
            break;
        case 3:
            [expression appendString:@"*"];
            break;
        case 4:
            [expression appendString:@"/"];
            break;
        case 5:
            [expression appendString:@"%"];
            break;
        case 6:
        {//如果是等号，就把结果输出到显示文本里
            //[expression appendString:@"="];
            result = [self getRusult:expression];
            int len = [expression length];
            [expression deleteCharactersInRange:NSMakeRange(0, len)];
            [expression appendString:[NSString stringWithFormat:@"%f",result]];//将表达式清空
            
            break;
        }
        default:
            break;
    }
    self.textField.text=expression;
    
}

-(IBAction)memoryAccess:(UIButton *)sender
{//处理MC,M+,M-,MR等运算符
    int len = [expression length];
    [expression deleteCharactersInRange:NSMakeRange(0, len)];
    switch (sender.tag) {
        case 1://如果是MC则将显示文本清空
        {
            memorydata = 0;
            result = 0;
            self.textField.text=@"0";
            break;
        }
        case 2://如果是M+则实现累加操作
        {
            memorydata = result;
            NSLog(@"the result is %f",result);
            [expression appendString:[NSString stringWithFormat:@"%f+",result]];
            self.textField.text=expression;
            break;
        }
        case 3://如果是M-则实现累减操作
        {
            memorydata = result;
            [expression appendString:[NSString stringWithFormat:@"%f-",result]];
            self.textField.text=expression;
            break;
        }
        case 4://如果是MR则将当前内容保存起来
        {
            self.textField.text=[NSString stringWithFormat:@"%f",memorydata];
            break;
        }
        default:
            break;
    }
    
}


-(IBAction)deleteandClean:(UIButton *)sender
{//处理删除和清空运算
 
    int len=[expression length];
    NSLog(@"the length is %d",len);
    switch (sender.tag) {
        case 1:
        {
            if(len>0)
            {
                [expression deleteCharactersInRange:NSMakeRange(len-1, 1)];
                self.textField.text=expression;
                
            }
            else
                self.textField.text=@"0";
            break;
        }
        case 2:
        {
            [expression deleteCharactersInRange:NSMakeRange(0, len)];
            self.textField.text=@"0";
            break;
        }
        default:
            break;
    }
}

-(int)calculatorPriority:(char)sender
{//定义字符串的优先级，*/%优先级为2,+-优先级为1
    int priority=0;
    switch (sender) {
        case '*':
        case '/':
        case '%':
        {
            priority=2;
            break;
        }
        case '+':
        case '-':
        {
            priority=1;
            break;
        }
        default:
            break;
    }
    return priority;
}
-(float) getRusult:(NSString *)expression
{//本函数实现先将输入表达式转换为后缀表达式，再根据后缀表达式计算结果
    suffixexpression = [[NSMutableArray alloc]init];
    NSMutableArray *opeartion=[[NSMutableArray alloc]init];
    char temp,topStack;
    NSMutableString  *tempString = [[NSMutableString alloc]init];
    int len = [expression length];
    for(int i=0;i<len;i++)
    {
        temp = [expression characterAtIndex:i];
        if((temp>='0'&&temp<='9')||(temp=='.'))
        {
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp];
            [tempString appendString:str];
            if(i!=len-1)
                continue;
        }
        if([tempString length]>0||(i == len-1))
        {
            NSString *str = [NSString stringWithString:tempString];
            [suffixexpression addObject:str];
            int length = [tempString length];
            [tempString deleteCharactersInRange:NSMakeRange(0, length)];
            if(temp>='0'&&temp<='9'&&i == len-1)
                break;
        }
        topStack = [[opeartion lastObject] characterAtIndex:0];
        if(topStack == empty)
        {
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp ];
            [opeartion addObject:str];
            continue;
        }
        else
    {
        //NSLog(@"the suffixexpression is %@",suffixexpression);
        if(topStack=='('&&temp!=')')
        {
            NSString *str= [NSString stringWithFormat:@"%c",temp ];
            [opeartion addObject:str];
        }
        else if(temp==')')
        {
            while (topStack!='(') {
                NSString *str = [NSString stringWithFormat:@"%c",topStack];
                [suffixexpression addObject:str];
                [opeartion removeLastObject];
                topStack = [[opeartion lastObject] characterAtIndex:0];
                if (topStack==empty)
                {
                    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"警告 " message:@"输入的表达式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertview show];
                    return 0;
                }

            }
            if(topStack=='(')
               [opeartion removeLastObject];
        }
        else if (temp=='(')
        {
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp];
            [opeartion addObject:str];
        }
        else
        {
            while([self calculatorPriority:temp]<=[self calculatorPriority:topStack])
            {
                NSString *str = [[NSString alloc]initWithFormat:@"%c",topStack ];
                [suffixexpression addObject:str];
                [opeartion removeLastObject];
                topStack = [[opeartion lastObject] characterAtIndex:0];
            }
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp];
            [opeartion addObject:str];
        }
    }
    }
        for(int i=[opeartion count]-1;i>=0;i--)
            [suffixexpression addObject:[opeartion objectAtIndex:i]];
    NSLog(@"the expression is %@",suffixexpression);
        NSString *str;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for(int i=0;i<[suffixexpression count];i++)
        {
            str = [suffixexpression objectAtIndex:i];
            if([str length]>1)
                [array addObject:str];
            else if([str length]==1)
            {
                char index = [str characterAtIndex:0];
                if(index>='0'&&index<='9')
                    [array addObject:str];
                else
                {
                    NSString *tempString;
                    float a1= [[array lastObject] floatValue];
                    [array removeLastObject];
                    float a2 = [[array lastObject] floatValue];
                    [array removeLastObject];
                    NSLog(@"the numbr1 is %f the number2 is %f",a1,a2);
                    switch (index) {
                        case '+':
                            tempString=[NSString stringWithFormat:@"%f",a2+a1];
                            break;
                        case '-':
                            tempString=[NSString stringWithFormat:@"%f",a2-a1];
                            break;
                        case '*':
                            tempString=[NSString stringWithFormat:@"%f",a2*a1];
                            break;
                        case '/':
                            tempString=[NSString stringWithFormat:@"%f",a2/a1];
                            break;
                        case '%':
                            tempString=[NSString stringWithFormat:@"%d",(int)a2%(int)a1];
                            break;
                        default:
                            break;
                    }
                    [array addObject:tempString];
                }
            }
        }
        return [[array firstObject] floatValue];
}

@end

    
    
    
    
    
    
    
    
    
    
    
    





