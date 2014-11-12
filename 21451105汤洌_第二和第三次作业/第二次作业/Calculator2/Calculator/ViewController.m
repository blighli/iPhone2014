//
//  ViewController.m
//  Calculator
//
//  Created by tanglie1993 on 14/11/9.
//  Copyright (c) 2014年 com.jikexueyuan. All rights reserved.
//

#import "ViewController.h"
@interface ViewController()

@end
NSMutableString *exp1;
NSMutableArray *sufExp;
float mdata;
float result;
const char empty = nil;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    exp1 = [[NSMutableString alloc] init];
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


//输入括号

-(IBAction)brackets:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            [exp1 appendString:@"("];
            break;
        case 2:
            [exp1 appendString:@")"];
            break;
        default:
            break;
    }
    self.textField.text=exp1;
}

//输入数据




-(IBAction)inputButtons:(UIButton *)sender

{
    switch (sender.tag) {
         case 0:
            [exp1 appendString:@"0"];
            break;
         case 1:
            [exp1 appendString:@"1"];
            break;
         case 2:
            [exp1 appendString:@"2"];
            break;
         case 3:
            [exp1 appendString:@"3"];
            break;
         case 4:
            [exp1 appendString:@"4"];
            break;
         case 5:
            [exp1 appendString:@"5"];
            break;
         case 6:
            [exp1 appendString:@"6"];
            break;
         case 7:
            [exp1 appendString:@"7"];
            break;
         case 8:
            [exp1 appendString:@"8"];
            break;
         case 9:
            [exp1 appendString:@"9"];
            break;
         case 10:
            [exp1 appendString:@"."];
            break;
        default:
            break;
    }
    self.textField.text=exp1;
}

-(IBAction)adjustRestoredData:(UIButton *)sender
{
    int len = [exp1 length];
    [exp1 deleteCharactersInRange:NSMakeRange(0, len)];
    switch (sender.tag) {
        case 1:
        {
            mdata = 0;
            result = 0;
            self.textField.text=@"0";
            break;
        }
        case 2:
        {
            mdata = result;
            NSLog(@"the result is %f",result);
            [exp1 appendString:[NSString stringWithFormat:@"%f+",result]];
            self.textField.text=exp1;
            break;
        }
        case 3:
        {
            mdata = result;
            [exp1 appendString:[NSString stringWithFormat:@"%f-",result]];
            self.textField.text=exp1;
            break;
        }
        case 4:
        {
            self.textField.text=[NSString stringWithFormat:@"%f",mdata];
            break;
        }
        default:
            break;
    }
    
}


-(IBAction)Calculator:(UIButton *)sender
{
    switch (sender.tag) {
        case 1:
            [exp1 appendString:@"+"];
            break;
        case 2:
            [exp1 appendString:@"-"];
            break;
        case 3:
            [exp1 appendString:@"*"];
            break;
        case 4:
            [exp1 appendString:@"/"];
            break;
        case 5:
            [exp1 appendString:@"%"];
            break;
        case 6:
        {
            //[exp appendString:@"="];
            result = [self getRusult:exp1];
            int len = [exp1 length];
            [exp1 deleteCharactersInRange:NSMakeRange(0, len)];
            [exp1 appendString:[NSString stringWithFormat:@"%f",result]];
            
            break;
        }
        default:
            break;
    }
    self.textField.text=exp1;
    
}


//清除数据

-(IBAction)deleteandClean:(UIButton *)sender
{
 
    int len=[exp1 length];
    NSLog(@"the length is %d",len);
    switch (sender.tag) {
        case 1:
        {
            if(len>0)
            {
                [exp1 deleteCharactersInRange:NSMakeRange(len-1, 1)];
                self.textField.text=exp1;
                
            }
            else
                self.textField.text=@"0";
            break;
        }
        case 2:
        {
            [exp1 deleteCharactersInRange:NSMakeRange(0, len)];
            self.textField.text=@"0";
            break;
        }
        default:
            break;
    }
}

//获取优先级

-(int)calculatorPriority:(char)sender
{
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


//输入算式并获取结果

-(float) getRusult:(NSString *)exp
{
    sufExp = [[NSMutableArray alloc]init];
    NSMutableArray *operationArray=[[NSMutableArray alloc]init];
    char temp,topStack;
    NSMutableString  *tempString = [[NSMutableString alloc]init];
    int len = [exp length];
    for(int i=0;i<len;i++)
    {
        temp = [exp characterAtIndex:i];
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
            [sufExp addObject:str];
            int length = [tempString length];
            [tempString deleteCharactersInRange:NSMakeRange(0, length)];
            if(temp>='0'&&temp<='9'&&i == len-1)
                break;
        }
        topStack = [[operationArray lastObject] characterAtIndex:0];
        if(topStack == empty)
        {
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp ];
            [operationArray addObject:str];
            continue;
        }
        else
    {
        NSLog(@"the sufExp is %@",sufExp);
        if(topStack=='('&&temp!=')')
        {
            NSString *str= [NSString stringWithFormat:@"%c",temp ];
            [operationArray addObject:str];
        }
        else if(temp==')')
        {
            while (topStack!='(') {
                NSString *str = [NSString stringWithFormat:@"%c",topStack];
                [sufExp addObject:str];
                [operationArray removeLastObject];
                topStack = [[operationArray lastObject] characterAtIndex:0];
                if (topStack==empty)
                {
                    UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"警告 " message:@"表达式错误" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                    [alertview show];
                    return 0;
                }

            }
            if(topStack=='(')
               [operationArray removeLastObject];
        }
        else if (temp=='(')
        {
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp];
            [operationArray addObject:str];
        }
        else
        {
            while([self calculatorPriority:temp]<=[self calculatorPriority:topStack])
            {
                NSString *str = [[NSString alloc]initWithFormat:@"%c",topStack ];
                [sufExp addObject:str];
                [operationArray removeLastObject];
                topStack = [[operationArray lastObject] characterAtIndex:0];
            }
            NSString *str = [[NSString alloc]initWithFormat:@"%c",temp];
            [operationArray addObject:str];
        }
    }
    }
        for(int i=[operationArray count]-1;i>=0;i--)
            [sufExp addObject:[operationArray objectAtIndex:i]];
    NSLog(@"the exp is %@",sufExp);
        NSString *str;
        NSMutableArray *array = [[NSMutableArray alloc]init];
        for(int i=0;i<[sufExp count];i++)
        {
            str = [sufExp objectAtIndex:i];
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

    
    
    
    
    
    
    
    
    
    
    
    





