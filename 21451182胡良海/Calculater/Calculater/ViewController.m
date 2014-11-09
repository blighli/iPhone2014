//
//  ViewController.m
//  Calculater
//
//  Created by hu on 14/11/4.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSMutableString * expression;//存储表达式
NSMutableArray * lastexpression;//后缀式
float memoryresult=0;//存储需要记忆的数据
float result =0;// 最终的结果
BOOL ismemorypressed = NO;//用来记录是不是已经按下了一次m的操作
const char empty =nil;
@implementation ViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    
    expression = [[NSMutableString alloc] init];
    self.numberandResult.text = @"0";
    self.numberandResult.adjustsFontSizeToFitWidth = YES;
    self.numberandResult.minimumFontSize = 17;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

- (IBAction)memoryControl:(UIButton *)sender {
    //用来处理关于MC,M+,M-,MR等得操作
    
    
    if (ismemorypressed) {
        UIAlertView * alertview  = [[UIAlertView alloc] initWithTitle:@"警告" message:@"你已经操作过此类操作，必须完成本次操作才可以" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
    }else
    {
        int length = [expression length];
        [expression deleteCharactersInRange:NSMakeRange(0, length)];
        switch (sender.tag) {
            case 1:
            {
                memoryresult =0;
                result =0;
            }
                
                break;
            case 2:
            {
                memoryresult = result;
                [expression appendString:[NSString stringWithFormat:@"%f+",result]];
                break;
            }
            case 3:
            {
                memoryresult = result;
                [expression appendString:[NSString stringWithFormat:@"%f-",result]];
                break;
                
            }
            case 4:
            {
                self.numberandResult.text = [NSString stringWithFormat:@"%f",memoryresult];
                break;
            }
            default:
                break;
        }
        
    }
}

- (IBAction)bracket:(UIButton *)sender {
    //用来处理括号的操作
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
    self.numberandResult.text = expression;
}

- (IBAction)calculate:(UIButton *)sender {
    //用来处理+-*/% = 等得操作
    switch (sender.tag) {
        case 1:
            [expression appendString:@"%"];
            break;
        case 2:
            [expression appendString:@"/"];
            break;
        case 3:
            [expression appendString:@"*"];
            break;
        case 4:
            [expression appendString:@"-"];
            break;
        case 5:
            [expression appendString:@"+"];
            break;
        case 6:
            //用来判断是等号的时候的情况
        {
            result = [self getResult:expression];
            int length = [expression length];
            [expression deleteCharactersInRange:NSMakeRange(0, length)];
            [expression appendString:[NSString stringWithFormat:@"%f",result]];
        }
            
            break;
        default:
            break;
    }
    self.numberandResult.text = expression;
    
}

- (IBAction)numberandpoint:(UIButton *)sender {
    //用来处理数字和点的操作
    
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
            [expression appendString: @"3"];
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
    self.numberandResult.text = expression;
}

- (IBAction)deleteandclean:(UIButton *)sender
{
    //用来处理删除和清除的操作
    int length  = [expression length];
    switch (sender.tag) {
        case 1:
            // 用来删除
        {
            if (length>0) {
                [expression deleteCharactersInRange:NSMakeRange(length-1,1)];
            }else
            {
                self.numberandResult.text = @"0";
            }
            break;
        }

        case 2:
            [expression deleteCharactersInRange:NSMakeRange(0, length)];
            self.numberandResult.text = @"0";
            break;
        default:
            break;
    }
    if (sender.tag==1&&length>0) {
        self.numberandResult.text = expression;
    }
    
}

-(float)getResult:(NSString *)expression
{
    //用来通过表达式获取结果
    ismemorypressed = NO;
    lastexpression = [[NSMutableArray alloc] init];
    NSMutableArray * operations = [[NSMutableArray alloc] init];//操作符
    int length = [expression length];
    char tmp;
    char popchar;
    NSMutableString * tmpstrings = [[NSMutableString alloc] init];
    for (int i=0; i<length;i++)
    {
       tmp = [expression characterAtIndex:i];
        if ((tmp>='0'&&tmp<='9')||tmp=='.')
        {
            NSString * string = [[NSString alloc] initWithFormat:@"%c",tmp];
            [tmpstrings appendString:string];
            if (i!=length-1) {
                continue;
            }
        }
        if ([tmpstrings length]>0||(i==length-1)) {
            NSString * string = [NSString stringWithString:tmpstrings];
            [lastexpression addObject:string];
            int lens = [tmpstrings length];
            [tmpstrings deleteCharactersInRange:NSMakeRange(0, lens)];
            if (tmp>='0'&&tmp<='9'&&(i==length-1)) {
                break;
            }

        }
        popchar = [[operations lastObject] characterAtIndex:0];
        if (popchar== empty) {
            NSString *string = [[NSString alloc] initWithFormat:@"%c",tmp];
            [operations addObject:string];
            continue;
        }else
        {
            NSLog(@"the lastexpression is %@ ",lastexpression);
            if (popchar=='('&&tmp!=')')
            {
                NSString * string = [NSString stringWithFormat:@"%c",tmp];
                [operations addObject:string];
            }else if(tmp ==')')
            {
                while (popchar!='(')
                {
                    NSString * string = [NSString stringWithFormat:@"%c",popchar];
                    [lastexpression addObject:string];
                    [operations removeLastObject];
                    popchar =[[operations lastObject] characterAtIndex:0];
                    if (popchar==empty)
                    {
                        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"警告 " message:@"输入的表达式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
                        [alertview show];
                        return 0;
                    }
                }
                if (popchar=='(') {
                    [operations removeLastObject];
                }
                
            }else if(tmp =='(')
            {
                NSString * string = [[NSString alloc] initWithFormat:@"%c",tmp];
                [operations addObject:string];
            }else
            {
                NSLog(@"the popchar is %c the proprity is %d",popchar,[self getpoprity:popchar]);
                NSLog(@"the popchar is %c the proprity is %d",tmp,[self getpoprity:tmp]);
                while ([self getpoprity:popchar]>=[self getpoprity:tmp]) {
                    NSString * popstring = [[NSString alloc] initWithFormat:@"%c",popchar];
                    [lastexpression addObject:popstring];
                    [operations removeLastObject];
                    popchar = [[operations lastObject] characterAtIndex:0];
                }
                NSString *string = [[NSString alloc] initWithFormat:@"%c",tmp];
                [operations addObject:string];
            }
        }
        
    }
    //用来处理后缀表达式
    for (int i=[operations count]-1; i>=0; i--) {
        [lastexpression addObject:[operations objectAtIndex:i]];
    }
    NSLog(@"this is a tree %@ ",lastexpression);
    NSString * tmpstring;
    NSMutableArray * numberArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[lastexpression count]; i++)
    {
        tmpstring = [lastexpression objectAtIndex:i];
        if ([tmpstring length]>1) {
            [numberArray addObject:tmpstring];
        }else if ([tmpstring length]==1)
        {
            char key = [tmpstring characterAtIndex:0];
            if (key>='0'&&key<='9') {
                [numberArray addObject:tmpstring];
            }else
            {
                NSString * string;
                float number1 = [[numberArray lastObject] floatValue];
                [numberArray removeLastObject];
                float number2 = [[numberArray lastObject] floatValue];
                 [numberArray removeLastObject];
                char key = [tmpstring characterAtIndex:0];
                NSLog(@"the two number is %f %f",number1,number2);
                switch (key)
                {
                    case '+':
                        string =[NSString stringWithFormat:@"%f",number2+number1];
                        NSLog(@"the string is %@",string);
                        break;
                    case '-':
                        string =[NSString stringWithFormat:@"%f",number2-number1];
                        break;
                    case '*':
                        string =[NSString stringWithFormat:@"%f",number2*number1];
                        break;
                    case '/':
                        string =[NSString stringWithFormat:@"%f",number2/number1];
                        break;
                    case '%':
                        string =[NSString stringWithFormat:@"%d",((int)number2%(int)number1)];
                        break;
                    default:
                        break;
                }
                [numberArray addObject:string];
            }
        }
    }
    return [[numberArray lastObject] floatValue];
}
-(IBAction)backgroundTap:(id)sender
{
    [self.numberandResult resignFirstResponder];
}

-(int)getpoprity:(char)tmp
{
    int value=0;
    switch (tmp) {
        case '*':
        case '/':
        case '%':
            value =3;
            break;
        case '+':
        case '-':
            value =2;
            break;
        default:
            break;
    }
    return value;
}
@end
