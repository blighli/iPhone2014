//
//  ViewController.m
//  Calculator
//
//  Created by 陈晟豪 on 14/11/3.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
{
    NSString *oldString;
    NSString *newString;
    
    //数字和计算符号栈
    NSMutableArray *digitalStack;
    NSMutableArray *characterStack;
    
    BOOL clickedCharacter;
    BOOL doubleClicked;
    double valueOfMemory;
}

-(BOOL)findChildString:(NSString *)temp childString:(NSString *)child;
-(void)removeInvalidCharacters;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //存储器的值初始化为0
    valueOfMemory = 0;
    
    //初始化数字栈和计算符号栈
    digitalStack = [NSMutableArray arrayWithCapacity:1000];
    characterStack = [NSMutableArray arrayWithCapacity:1000];
    
    //判断是否按过计算符键
    clickedCharacter = NO;
    
    //判断是否按过多次计算符
    doubleClicked = NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//修改状态栏颜色
-(UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

//寻找子字符串
-(BOOL)findChildString:(NSString *)temp childString:(NSString *)child
{
    NSRange foundObj=[temp rangeOfString:child options:NSCaseInsensitiveSearch];
    if(foundObj.length>0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

//删除多余0
-(void)removeInvalidCharacters
{
    NSRange foundObj=[newString rangeOfString:@"."];
    NSString *string;
    
    for(int i = (int)[newString length] - 1; i >= foundObj.location; i--)
    {
        
        string = [newString substringWithRange:NSMakeRange(i, 1)];
        if(![string isEqualToString:@"0"])
        {
            if([string isEqualToString:@"."])
            {
                newString = [newString substringToIndex:i];
                break;
            }
            else
            { 
                newString = [newString substringToIndex:i+1];
                break;
            }
        }

    }
}

- (IBAction)pressButton:(id)sender
{
    UIButton *button = (UIButton*)sender;
    
    if(button.tag == self.mcButton.tag)
    {
        //MC键
        
        valueOfMemory = 0;
    }
    else if(button.tag == self.maButton.tag)
    {
        //M+键
        
        if(![self.outLabel.text isEqualToString:@"除数为0"])
        {
            double currentValue = [self.outLabel.text doubleValue];
            valueOfMemory += currentValue;
        }

    }
    else if (button.tag == self.mmButton.tag)
    {
        //M-键
        
        if(![self.outLabel.text isEqualToString:@"除数为0"])
        {
            double currentValue = [self.outLabel.text doubleValue];
            valueOfMemory -= currentValue;
        }
    }
    else if(button.tag == self.mrButton.tag)
    {
        //MR键
        
        newString = [NSString stringWithFormat:@"%.11lf",valueOfMemory];
        [self removeInvalidCharacters];
        [self.outLabel setText:newString];
    }
    else if(button.tag == self.delButton.tag)
    {
        //删除键
        
        if(![self.outLabel.text isEqualToString:@"除数为0"])
        {
            //Label中字符串长度大于2删除1位，等于2判断是否有负号,等于1直接设为0
            oldString = self.outLabel.text;
            if([oldString length] > 2)
            {
                newString = [oldString substringToIndex:[oldString length] - 1];
                [self.outLabel setText:newString];
            }
            else if ([oldString length] == 2)
            {
                BOOL found = [self findChildString:oldString childString:@"-"];
                if(found)
                {
                    [self.outLabel setText:@"0"];
                }
                else
                {
                    newString = [oldString substringToIndex:[oldString length] - 1];
                    [self.outLabel setText:newString];
                }
            }
            else if ([oldString length] == 1)
            {
                [self.outLabel setText:@"0"];
            }
        }
        else
        {
            [self.outLabel setText:@"0"];
        }
        
        clickedCharacter = NO;
        doubleClicked = NO;
    }
    else if (button.tag == self.lbButton.tag)
    {
        //左括号
        
        //左括号直接压进栈中
        [characterStack addObject:[sender currentTitle]];
        doubleClicked = YES;
        clickedCharacter = YES;
    }
    else if (button.tag == self.rbButton.tag)
    {
        //右括号
        
        //判断计算符栈中是否有左括号匹配，有则计算，无则忽略该右括号
        if ([characterStack containsObject:@"("])
        {
            while(![(NSString *)[characterStack lastObject] isEqualToString:@"("] && [characterStack count] != 0)
            {
                oldString = (NSString *)[digitalStack lastObject];
                if([[characterStack lastObject] isEqualToString:@"+"])
                {
                    newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] + [self.outLabel.text doubleValue]];
                }
                else if([[characterStack lastObject] isEqualToString:@"–"])
                {
                    newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] - [self.outLabel.text doubleValue]];
                }
                else if([[characterStack lastObject] isEqualToString:@"x"])
                {
                    newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] * [self.outLabel.text doubleValue]];
                }
                else if([[characterStack lastObject] isEqualToString:@"÷"])
                {
                    newString = self.outLabel.text;
                    [self removeInvalidCharacters];
                    
                    //判断除数是否为0
                    
                    if(![newString isEqualToString:@"0"])
                    {
                        newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] / [self.outLabel.text doubleValue]];
                    }
                    else
                    {
                        [self.outLabel setText:@"除数为0"];
                        [digitalStack removeAllObjects];
                        [characterStack removeAllObjects];
                        clickedCharacter = YES;
                        doubleClicked = YES;
                        newString = @"0";
                        break;
                    }
                }
                
                [self removeInvalidCharacters];
                [digitalStack removeLastObject];
                [characterStack removeLastObject];
                
                [self.outLabel setText:newString];
            }
            [characterStack removeLastObject];
        }
    }
    else if (button.tag == self.perButton.tag)
    {
        //百分号
        
        newString = [NSString stringWithFormat:@"%.11lf",[self.outLabel.text doubleValue] / 100];
        [self removeInvalidCharacters];
        [self.outLabel setText:newString];
        clickedCharacter = YES;
        doubleClicked = NO;
    }
    else if (button.tag == self.acButton.tag)
    {
        //AC键
        
        [self.outLabel setText:@"0"];
        [digitalStack removeAllObjects];
        [characterStack removeAllObjects];
        clickedCharacter = NO;
        doubleClicked = NO;
    }
    else if (button.tag == self.mulButton.tag || button.tag == self.divButton.tag)
    {
        //乘法键和除法键
        
        //按照算符优先级进行运算
        if(!doubleClicked)
        {
            //算数字符栈空直接压进入栈
            if([characterStack count] == 0)
            {
                oldString = self.outLabel.text;
                [digitalStack addObject:oldString];
                [characterStack addObject:[sender currentTitle]];
            }
            else
            {
                
                while([characterStack count] != 0)
                {
                    oldString = (NSString *)[digitalStack lastObject];
                    if([[characterStack lastObject] isEqualToString:@"x"])
                    {
                        newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] * [self.outLabel.text doubleValue]];
                    }
                    else if([[characterStack lastObject] isEqualToString:@"÷"])
                    {
                        newString = self.outLabel.text;
                        [self removeInvalidCharacters];
                        if(![newString isEqualToString:@"0"])
                        {
                            newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] / [self.outLabel.text doubleValue]];
                        }
                        else
                        {
                            [self.outLabel setText:@"除数为0"];
                            break;
                        }
                    }
                    else if([[characterStack lastObject] isEqualToString:@"("] ||
                            [[characterStack lastObject] isEqualToString:@"+"] ||
                            [[characterStack lastObject] isEqualToString:@"–"] )
                    {
                        newString = self.outLabel.text;
                        break;
                    }
                    
                    
                    if(![[characterStack lastObject] isEqualToString:@"("] &&
                       ![[characterStack lastObject] isEqualToString:@"+"] &&
                       ![[characterStack lastObject] isEqualToString:@"–"] )
                    {
                        [self removeInvalidCharacters];
                        [digitalStack removeLastObject];
                        [characterStack removeLastObject];
                        
                        [self.outLabel setText:newString];
                    }
                }
                if(![self.outLabel.text isEqualToString:@"除数为0"])
                {
                    [digitalStack addObject:newString];
                    [characterStack addObject:[sender currentTitle]];
                }
                else
                {
                    [digitalStack removeAllObjects];
                    [characterStack removeAllObjects];
                    clickedCharacter = YES;
                    doubleClicked = YES;
                }
            }
            
            doubleClicked = YES;
        }
        else
        {
            oldString = self.outLabel.text;
            if(![oldString isEqualToString:@"除数为0"])
            {
                [characterStack removeLastObject];
                [digitalStack removeLastObject];
                
                [digitalStack addObject:oldString];
                [characterStack addObject:[sender currentTitle]];
            }
        }
        
        clickedCharacter = YES;
    }
    else if (button.tag == self.addButton.tag || button.tag == self.minButton.tag)
    {
        //加法键和减法键
        
        //按照算符优先级进行运算
        if(!doubleClicked)
        {
            if([characterStack count] == 0)
            {
                oldString = self.outLabel.text;
                [digitalStack addObject:oldString];
                [characterStack addObject:[sender currentTitle]];
            }
            else
            {
                while([characterStack count] != 0)
                {
                    oldString = (NSString *)[digitalStack lastObject];
                    if([[characterStack lastObject] isEqualToString:@"+"])
                    {
                        newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] + [self.outLabel.text doubleValue]];
                    }
                    else if([[characterStack lastObject] isEqualToString:@"–"])
                    {
                        newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] - [self.outLabel.text doubleValue]];
                    }
                    else if([[characterStack lastObject] isEqualToString:@"x"])
                    {
                        newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] * [self.outLabel.text doubleValue]];
                    }
                    else if([[characterStack lastObject] isEqualToString:@"÷"])
                    {
                        newString = self.outLabel.text;
                        [self removeInvalidCharacters];
                        if(![newString isEqualToString:@"0"])
                        {
                            newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] / [self.outLabel.text doubleValue]];
                        }
                        else
                        {
                            [self.outLabel setText:@"除数为0"];
                            [digitalStack removeAllObjects];
                            [characterStack removeAllObjects];
                            clickedCharacter = YES;
                            doubleClicked = YES;
                            newString = @"0";
                            break;
                        }
                    }
                    else if([[characterStack lastObject] isEqualToString:@"("])
                    {
                        newString = self.outLabel.text;
                        break;
                    }
                    
                    if(![[characterStack lastObject] isEqualToString:@"("])
                    {
                        [self removeInvalidCharacters];
                        [digitalStack removeLastObject];
                        [characterStack removeLastObject];
                    
                        [self.outLabel setText:newString];
                    }
                }
                
                [digitalStack addObject:newString];
                [characterStack addObject:[sender currentTitle]];
            }
            
            doubleClicked = YES;
        }
        else
        {
            oldString = self.outLabel.text;
            if(![oldString isEqualToString:@"除数为0"])
            {
                [characterStack removeLastObject];
                [digitalStack removeLastObject];
                
                [digitalStack addObject:oldString];
                [characterStack addObject:[sender currentTitle]];
            }
        }
        
        clickedCharacter = YES;
    }
    else if (button.tag == self.pmButton.tag)
    {
        //正负键
        
        oldString = self.outLabel.text;
        if(![oldString isEqualToString:@"0"])
        {
            if([oldString containsString:@"-"])
            {
                newString = [oldString substringFromIndex:1];
            }
            else
            {
                newString = [@"-" stringByAppendingString:oldString];
            }
            [self removeInvalidCharacters];
            [self.outLabel setText:newString];
        }
        clickedCharacter = NO;
        doubleClicked = NO;

    }
    else if (button.tag == self.equButton.tag)
    {
        //等于键
        
        //所有计算符和数字退栈，并显示结果
        if(doubleClicked)
        {
            if(![[characterStack lastObject] isEqualToString:@"("])
            {
                [digitalStack removeLastObject];
            }
            [characterStack removeLastObject];
        }
        while([characterStack count] != 0)
        {
            oldString = (NSString *)[digitalStack lastObject];
            if([[characterStack lastObject] isEqualToString:@"+"])
            {
                newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] + [self.outLabel.text doubleValue]];
            }
            else if([[characterStack lastObject] isEqualToString:@"–"])
            {
                newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] - [self.outLabel.text doubleValue]];
            }
            else if([[characterStack lastObject] isEqualToString:@"x"])
            {
                newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] * [self.outLabel.text doubleValue]];
            }
            else if([[characterStack lastObject] isEqualToString:@"÷"])
            {
                newString = self.outLabel.text;
                [self removeInvalidCharacters];
                if(![newString isEqualToString:@"0"])
                {
                    newString = [NSString stringWithFormat:@"%.11lf",[oldString doubleValue] / [self.outLabel.text doubleValue]];
                }
                else
                {
                    [self.outLabel setText:@"除数为0"];
                    newString = @"0";
                    break;
                }
            }
            else if([[characterStack lastObject] isEqualToString:@"("])
            {
                [characterStack removeLastObject];
                continue;
            }
            
            if(![[characterStack lastObject] isEqualToString:@"("])
            {
                [self removeInvalidCharacters];
                [digitalStack removeLastObject];
                [characterStack removeLastObject];
                
                [self.outLabel setText:newString];
            }
        }
        
        [digitalStack removeAllObjects];
        [characterStack removeAllObjects];
        clickedCharacter = YES;
        doubleClicked = YES;
    }
    else if (button.tag == self.decButton.tag)
    {
        //小数点键
        
        if(!clickedCharacter)
        {
            oldString = self.outLabel.text;
            BOOL found = [self findChildString:oldString childString:@"."];
            if(!found)
            {
                newString = [oldString stringByAppendingString:[sender currentTitle]];
                [self.outLabel setText:newString];
            }
        }
        else
        {
            [self.outLabel setText:@"0."];
        }
        clickedCharacter = NO;
        doubleClicked = NO;
    }
    else
    {
        //数字键
        
        if(clickedCharacter)
        {
            [self.outLabel setText:@""];
            clickedCharacter = NO;
        }
        
        oldString = self.outLabel.text;
        if([oldString length] < 13)
        {
            if([oldString isEqualToString:@"0"])
            {
                [self.outLabel setText:[sender currentTitle]];
            }
            else
            {
                newString = [oldString stringByAppendingString:[sender currentTitle]];
                [self.outLabel setText:newString];
            }
        }
        
        doubleClicked = NO;
    }
}
@end

