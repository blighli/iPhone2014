//
//  ViewController.m
//  My-Caculator
//
//  Created by 张榕明 on 14/11/9.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSMutableString * expression;
NSMutableArray * postexpression;
float memorydata=0;
float result =0;
const char ch;
BOOL  flag = false;

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    expression = [[NSMutableString alloc] init];
    self.label.text = @"0";
    self.label.adjustsFontSizeToFitWidth = YES;
   }

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(IBAction)memorySelector:(UIButton *)sender
{
    switch (sender.tag) {
        case 3:
        {
            memorydata =0;
            self.label.text = @"0";
        }

            break;
        case 1:
        {
            memorydata+=[self.label.text doubleValue];
            [expression setString:@""];
            break;
        }
        case 2:
        {
          
            memorydata-=[self.label.text doubleValue];
            [expression setString:@""];
            break;

        }
        case 0:
        {
            self.label.text = [NSString stringWithFormat:@"%f",memorydata];
            [expression setString:@""];
            break;
        }
        default:
            break;
    }
}

-(IBAction)bracketSelector:(UIButton *)sender
{
    switch (sender.tag) {
    case 0:
        [expression appendString:@")"];
            break;
    case 1:
        [expression appendString:@"("];
            break;
    default:
            break;
    }
    self.label.text = expression;
}

-(IBAction)deleteAndClearnSelector:(UIButton *)sender;
{

    int length  = (int)[expression length];
    switch (sender.tag) {
        case 0:
        {
            if (length>0) {
                [expression deleteCharactersInRange:NSMakeRange(length-1,1)];
           }else
           {
                self.label.text = @"0";
               
            }
            break;
        }

        case 1:
            [expression deleteCharactersInRange:NSMakeRange(0, length)];
            self.label.text = @"0";
            memorydata = 0;
            break;
        default:
            break;
    }
    if (sender.tag==0&&length>0) {
        self.label.text = expression;
    }
}

-(IBAction)caculateSelector:(UIButton *)sender {
    switch (sender.tag) {
        case 0:
            [expression appendString:@"+"];
            self.label.text = expression;
            break;
        case 1:
            [expression appendString:@"-"];
            self.label.text = expression;
            break;
        case 2:
            [expression appendString:@"*"];
            self.label.text = expression;
            break;
        case 3:
            [expression appendString:@"/"];
            self.label.text = expression;
            break;
        case 4:
            [expression appendString:@"%"];
            self.label.text = expression;
            break;
        case 5:
        {
            result = [self dealExpression:expression];
            int length = (int)[expression length];
            [expression deleteCharactersInRange:NSMakeRange(0, length)];
            [expression appendString:[NSString stringWithFormat:@"%f",result]];
            self.label.text = expression;
            flag =true;
            
        }
            break;
        default:
            break;
    }
}

-(IBAction)numberAndPointSelector:(UIButton *)sender {
    if(flag==true)
    {
        self.label.text=@" ";
        [expression setString:@""];
    }
    flag=false;
    
    switch (sender.tag) {
        case 0:
            if([[ expression substringWithRange:NSMakeRange(expression.length-1, 1)]isEqualToString:@"/"])
            {
                self.label.text = @"除数不为零";
                [expression setString:@""];
                break;
            }
            else{
            [expression appendString:@"0"];
            self.label.text = expression;
            break;
            }
        case 1:
            [expression appendString:@"1"];
            self.label.text = expression;
            break;
        case 2:
            [expression appendString:@"2"];
            self.label.text = expression;
            break;
        case 3:
            [expression appendString: @"3"];
            self.label.text = expression;
            break;
        case 4:
            [expression appendString:@"4"];
            self.label.text = expression;
            break;
        case 5:
            [expression appendString:@"5"];
            self.label.text = expression;
            break;
        case 6:
            [expression appendString:@"6"];
            self.label.text = expression;
            break;
        case 7:
            [expression appendString:@"7"];
            self.label.text = expression;
            break;
        case 8:
            [expression appendString:@"8"];
            self.label.text = expression;
            break;
        case 9:
            [expression appendString:@"9"];
            self.label.text = expression;
            break;
        case 10:
            [expression appendString:@"."];
            self.label.text = expression;
            break;
        default:
            break;
    }
    
}


-(float)dealExpression:(NSString *)expression
{
   postexpression = [[NSMutableArray alloc] init];
    NSMutableArray * operations = [[NSMutableArray alloc] init];
    int length = (int)[expression length];
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
            [postexpression addObject:string];
            int lens = (int)[tmpstrings length];
            [tmpstrings deleteCharactersInRange:NSMakeRange(0, lens)];
            if (tmp>='0'&&tmp<='9'&&(i==length-1)) {
                break;
            }

        }
        popchar = [[operations lastObject] characterAtIndex:0];
        if (popchar== ch) {
            NSString *string = [[NSString alloc] initWithFormat:@"%c",tmp];
            [operations addObject:string];
            continue;
        }else
        {
            NSLog(@"the lastexpression is %@ ",postexpression);
            if (popchar=='('&&tmp!=')')
            {
                NSString * string = [NSString stringWithFormat:@"%c",tmp];
                [operations addObject:string];
            }else if(tmp ==')')
            {
                while (popchar!='(')
                {
                    NSString * string = [NSString stringWithFormat:@"%c",popchar];
                    [postexpression addObject:string];
                    [operations removeLastObject];
                    popchar =[[operations lastObject] characterAtIndex:0];
                    if (popchar==ch)
                    {
                        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"worning" message:@"输入的表达式不正确" delegate:self cancelButtonTitle:@"确定" otherButtonTitles: nil];
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
                    [postexpression addObject:popstring];
                    [operations removeLastObject];
                    popchar = [[operations lastObject] characterAtIndex:0];
                }
                NSString *string = [[NSString alloc] initWithFormat:@"%c",tmp];
                [operations addObject:string];
            }
        }

    }
    for (int i=(int)[operations count]-1; i>=0; i--) {
        [postexpression addObject:[operations objectAtIndex:i]];
    }
    NSLog(@"this is a tree %@ ",postexpression);
    NSString * tmpstring;
    NSMutableArray * numberArray = [[NSMutableArray alloc] init];
    for (int i=0; i<[postexpression count]; i++)
    {
        tmpstring = [postexpression objectAtIndex:i];
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
