//
//  ViewController.m
//  CaculatorX
//
//  Created by CST on 14/11/8.
//  Copyright (c) 2014年 PengCheng. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (weak, nonatomic) IBOutlet UILabel *displayLabel;
//用来显示小窗口中的整个等式
@property (weak, nonatomic) IBOutlet UILabel *displayProgram;
//如果是第一次输入的话，去掉0.0，isNotFirstInputNumber默认为NO
@property (assign, nonatomic) BOOL isNotFirstInputNumber;
@property (assign, nonatomic) BOOL isFirstPoint , touchAddBool;

@property (assign, nonatomic) double operateNumA,operateNumB,saveNum;
@property (assign, nonatomic) int  mark;

@end





@implementation ViewController
@synthesize displayLabel = _displayLabel;
@synthesize displayProgram = _displayProgram;
@synthesize isNotFirstInputNumber = _isNotFirstInputNumber;
@synthesize isFirstPoint = _isFirstPoint;
@synthesize touchAddBool = _touchAddBool;
@synthesize operateNumA =_operateNumA;
@synthesize operateNumB = _operateNumB;
@synthesize mark = _mark;
@synthesize saveNum = _saveNum;

NSString * connectString(NSString *strA,NSString *strB)
{
    NSMutableString * str1 = [NSMutableString stringWithString:strA];
    NSMutableString * str2 = [NSMutableString stringWithString:strB];
    [str1 insertString:str2 atIndex:[str1 length]];
    return str1;
}

//实现MR、M+、M－、MC
- (IBAction)strangeButton:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"MR"]) {
        //self.saveNum = [self.displayLabel.text doubleValue];
        self.displayLabel.text = [NSString stringWithFormat:@"%f",self.saveNum];
    }
    else if ([sender.currentTitle isEqualToString:@"M+"])
    {
        double mm = [self.displayLabel.text doubleValue];
        self.saveNum += mm;
        self.displayLabel.text = [NSString stringWithFormat:@"%f",self.saveNum];
    }
    else if ([sender.currentTitle isEqualToString:@"M-"])
    {
        double mm = [self.displayLabel.text doubleValue];
        self.saveNum -= mm;
        self.displayLabel.text = [NSString stringWithFormat:@"%f",self.saveNum];
    }
    else if ([sender.currentTitle isEqualToString:@"MC"])
    {
        self.saveNum = 0.0f;
        self.displayLabel.text = @"0";
    }
    self.isNotFirstInputNumber =NO;
}



//实现加减乘除取余

- (IBAction)operation:(UIButton *)sender
{
    
        if ([sender.currentTitle isEqualToString:@"+"])
        {
            self.mark = 1;
            if (!self.touchAddBool) {
                self.operateNumA = [self.displayLabel.text doubleValue];
                self.touchAddBool = YES;
                self.displayProgram.text = connectString(self.displayProgram.text, @"+");
            }
        }
        else if ([sender.currentTitle isEqualToString:@"-"])
        {
            self.mark = 2;
            if (!self.touchAddBool) {
                self.operateNumA = [self.displayLabel.text doubleValue];
                self.touchAddBool = YES;
                self.displayProgram.text = connectString(self.displayProgram.text, @"-");
            }
            
        }
        else if ([sender.currentTitle isEqualToString:@"*"])
        {
            self.mark = 3;
            if (!self.touchAddBool) {
                self.operateNumA = [self.displayLabel.text doubleValue];
                self.touchAddBool = YES;
                self.displayProgram.text = connectString(self.displayProgram.text, @"*");
            }
        }
        else if ([sender.currentTitle isEqualToString:@"/"])
        {
            self.mark = 4;
            if (!self.touchAddBool) {
                self.operateNumA = [self.displayLabel.text doubleValue];
                self.touchAddBool = YES;
                self.displayProgram.text = connectString(self.displayProgram.text, @"/");
            }
        }
        else if ([sender.currentTitle isEqualToString:@"%"])
        {
            self.mark = 5;
            if (!self.touchAddBool) {
                self.operateNumA = [self.displayLabel.text doubleValue];
                self.touchAddBool = YES;
                self.displayProgram.text = connectString(self.displayProgram.text, @"%");
            }
        }
        else if ([sender.currentTitle isEqualToString:@"="])
        {
            self.operateNumB = [self.displayLabel.text doubleValue];
            switch (self.mark)
            {
                case 1:
                    self.operateNumA = self.operateNumA + self.operateNumB;
                    break;
                case 2:
                    self.operateNumA = self.operateNumA - self.operateNumB;
                    break;
                case 3:
                    self.operateNumA = self.operateNumA * self.operateNumB;
                    break;
                case 4:
                    self.operateNumA = self.operateNumA / self.operateNumB;
                    break;
                case 5:
                    self.operateNumA = self.operateNumA - (long)self.operateNumA + (double)((long)self.operateNumA %(long)self.operateNumB);
                    break;
                default:
                    break;
            }
            self.displayLabel.text = [NSString stringWithFormat:@"%f",self.operateNumA];
            self.displayProgram.text = self.displayLabel.text;
            self.touchAddBool =NO;
            self.mark = 0;
        }
    
    self.isNotFirstInputNumber =NO;
    
}

//实现括号
- (IBAction)bracketButton:(UIButton *)sender
{
    if ([sender.currentTitle isEqualToString:@"("]) {
        self.displayProgram.text = connectString(self.displayProgram.text, @"(");
    }
    else if ([sender.currentTitle isEqualToString:@")"])
    {
        //未完成;
    }
}


//清除数据
- (IBAction)clearTouch:(UIButton *)sender
{
    self.displayLabel.text=@"0";
    self.displayProgram.text=@"0";
    self.isNotFirstInputNumber = NO;
    self.isFirstPoint = NO;
    self.touchAddBool = NO;
}


//完全清除数据
- (IBAction)ACClaerButton:(UIButton *)sender
{
    self.displayLabel.text=@"0";
    self.displayProgram.text=@"0";
    self.isNotFirstInputNumber = NO;
    self.isFirstPoint = NO;
    self.touchAddBool = NO;
    
    self.operateNumA = 0.0f;
    self.operateNumB = 0.0f;
    self.mark = 0;
}


//实现正负号
- (IBAction)mark:(UIButton *)sender
{
    
    NSMutableString * nowLabel = [NSMutableString stringWithString:self.displayLabel.text];//获取当前显示数字
    NSString * firstNumber = [nowLabel substringToIndex:1];
    if ([firstNumber isEqualToString:@"-"])
    {
        self.displayLabel.text = [nowLabel substringFromIndex:1];
        self.displayProgram.text = self.displayLabel.text;
    }
    else
    {
        NSMutableString * fu= [NSMutableString stringWithString:@"-"];//负号数字
        [fu insertString:nowLabel atIndex:[fu length]];
        self.displayLabel.text = fu;
        self.displayProgram.text = fu;
    }
}


//点击数字按钮
- (IBAction)numberTouch:(UIButton *)sender {
    
    //NSLog(@"%@",sender.currentTitle);
    
    //判断是不是第一次输入
    if(!self.isNotFirstInputNumber)
    {
        if (!self.isFirstPoint&&[sender.currentTitle isEqualToString:@"."]) {
            self.displayLabel.text = @"0";
        }
        else
        {
            self.displayLabel.text = @"";
            
        }
        self.isNotFirstInputNumber = YES;
    }
    
    //判断是不是重复输入点号
    //NSLog(@"%d",self.isFirstPoint);
    if ([sender.currentTitle isEqualToString:@"."])
    {
        if (!self.isFirstPoint) {
            NSMutableString *inputNum = [NSMutableString stringWithString:self.displayLabel.text];
            [inputNum insertString:sender.currentTitle atIndex:[inputNum length]];
            self.displayLabel.text = inputNum;
            
            self.displayProgram.text = inputNum;
            
            self.isFirstPoint = YES;
        }
    }
    else
    {
        NSMutableString *inputNum = [NSMutableString stringWithString:self.displayLabel.text];
        [inputNum insertString:sender.currentTitle atIndex:[inputNum length]];
        self.displayLabel.text = inputNum;
        self.displayProgram.text = inputNum;
    }
    
    
    /*
     if (self.isUsingInputNumber) {
     long long inputNum = [self.displayLabel.text longLongValue];
     inputNum = inputNum*10+[self.displayLabel.text intValue];
     self.displayLabel.text = [NSString stringWithFormat:@"%lld",inputNum];
     }
     else{
     [self.displayLabel setText:sender.currentTitle];
     self.isUsingInputNumber=YES;
     }
     */
    
}

















- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
