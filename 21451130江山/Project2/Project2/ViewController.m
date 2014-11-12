//
//  ViewController.m
//  Project2
//
//  Created by 江山 on 11/11/14.
//  Copyright (c) 2014 jiangshan. All rights reserved.
//


#import "ViewController.h"
#import <QuartzCore/QuartzCore.h>

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //创建标签
    self.label=[[UILabel alloc]initWithFrame:CGRectMake(30, 40, 260, 50)];
    [self.view addSubview:_label];
    self.label.backgroundColor=[UIColor greenColor];   //设置背景颜色
    self.label.textColor=[UIColor blackColor];         //字体颜色
    self.label.textAlignment = NSTextAlignmentLeft;
    self.label.font=[UIFont systemFontOfSize:32.4];    //设置字体
    
    
    //添加1-9数字
    NSArray *array=[NSArray arrayWithObjects:@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9", nil];
    int n=0;
    for (int i=0; i<3; i++)
    {
        for (int j=0; j<3; j++)
        {
            self.button=[UIButton buttonWithType:UIButtonTypeRoundedRect];
            self.button.frame=CGRectMake(30+65*j, 190+65*i, 60, 60);
            [self.button setTitle:[array objectAtIndex:n++] forState:UIControlStateNormal];   //注意：[array objectAtIndex:n++]
            [self.view addSubview:_button];
            [self.button addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside]; //addTarget:self 的意思是说，这个方法在本类中也可以传入其他类的指针
        }
    }
    
    
    //单独添加0
    UIButton *button0=[UIButton buttonWithType:UIButtonTypeRoundedRect];  //创建一个圆角矩形的按钮
    /*
     CALayer *layer = button0.layer;
     [layer setMasksToBounds:YES];
     [layer setCornerRadius:5.0];
     button0.layer.borderColor = [UIColor lightGrayColor].CGColor;
     button0.layer.borderWidth = 1.0f;
     */
    [button0 setFrame:CGRectMake(30, 385, 60, 60)];                       //设置button在view上的位置
    //也可以这样用：button0.frame:CGRectMake(30, 345, 60, 60);
    [button0 setTitle:@"0" forState:UIControlStateNormal];                //设置button主题
    button0.titleLabel.textColor = [UIColor blackColor];       //设置0键的颜色
    [button0 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside]; //按下按钮，并且当手指离开离开屏幕的时候触发这个事件
    //触发了这个事件后，执行shuzi方法，action:@selector(shuzi:)
    [self.view addSubview:button0];    //显示控件
    
    
    //添加运算符
    NSArray *array1=[NSArray arrayWithObjects:@"+",@"-",@"*",@"/",nil];
    for (int i=0; i<4; i++)
    {
        UIButton *button1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
        [button1 setFrame:CGRectMake(225, 190+65*i, 60, 60)];
        [button1 setTitle:[array1 objectAtIndex:i] forState:UIControlStateNormal];
        //[array1 objectAtIndex:i]为获取按钮的属性值
        [self.view addSubview:button1];
        [button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    //AC
    UIButton *button2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button2 setFrame:CGRectMake(30, 125, 60, 60)];
    [button2 setTitle:@"AC" forState:UIControlStateNormal];
    [button2 addTarget:self action:@selector(clean:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button2];
    
    //%
    UIButton *button3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button3 setFrame:CGRectMake(225, 125, 60, 60)];
    [button3 setTitle:@"%" forState:UIControlStateNormal];
    [button3 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button3];
    
    //.
    UIButton *button4=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button4 setFrame:CGRectMake(95, 385, 60, 60)];
    [button4 setTitle:@"." forState:UIControlStateNormal];
    [button4 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button4];
    
    
    //=
    UIButton *button5=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button5 setFrame:CGRectMake(160, 385, 60, 60)];
    [button5 setTitle:@"=" forState:UIControlStateNormal];
    [button5 addTarget:self action:@selector(calculate:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button5];
    
    //(
    UIButton *button6=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button6 setFrame:CGRectMake(95, 125, 60, 60)];
    [button6 setTitle:@"(" forState:UIControlStateNormal];
    [button6 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button6];
    
    //)
    UIButton *button7=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button7 setFrame:CGRectMake(160, 125, 60, 60)];
    [button7 setTitle:@")" forState:UIControlStateNormal];
    [button7 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button7];
    
    //MC
    UIButton *button8=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button8 setFrame:CGRectMake(30, 95, 60, 25)];
    [button8 setTitle:@"MC" forState:UIControlStateNormal];
    [button8 addTarget:self action:@selector(memc:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button8];
    
    //M+
    UIButton *button9=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button9 setFrame:CGRectMake(95, 95, 60, 25)];
    [button9 setTitle:@"M+" forState:UIControlStateNormal];
    [button9 addTarget:self action:@selector(memp:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button9];
    
    //M-
    UIButton *button10=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button10 setFrame:CGRectMake(160, 95, 60, 25)];
    [button10 setTitle:@"M-" forState:UIControlStateNormal];
    [button10 addTarget:self action:@selector(memd:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button10];
    
    //MR
    UIButton *button11=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    [button11 setFrame:CGRectMake(225, 95, 60, 25)];
    [button11 setTitle:@"MR" forState:UIControlStateNormal];
    [button11 addTarget:self action:@selector(memr:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button11];
    
    self.string=[[NSMutableString alloc]init];//初始化可变字符串，分配内存
    self.temp=[[NSMutableString alloc]init];
    self.mem=[NSNumber numberWithDouble:0];
    self.stack2=[[NSMutableArray alloc]init];
    self.stack1=[[NSMutableArray alloc]init];
}

-(void)show:(id)sender
{
    [self.string appendString:[sender currentTitle]];
    self.label.text=[NSString stringWithString:_string];
}

-(void)calculate:(id)sender
{
    int i;
    for(i=0;i<self.label.text.length;i++){
        if([[self.label.text substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"%"])
        {
            [_temp appendString:@"/100"];
            
        }else
        {
            [self.temp appendString:[self.label.text substringWithRange:NSMakeRange(i, 1)]];
        }
    }
    @try{
        NSInteger start=-1;//record start situation
        for(i=0;i<self.temp.length;i++)
        {
            if(([self getType:[self.temp substringWithRange:NSMakeRange(i, 1)]])==1)
            {
                //num
                if(start==-1)
                    start=i;
            }else if(([self getType:[self.temp substringWithRange:NSMakeRange(i, 1)]])==2)
            {
                //oper
                if(start!=-1)
                {
                    [self.stack2 addObject:[self.temp substringWithRange:NSMakeRange(start, i-start)]];
                    start=-1;
                }
                if(!([[self.temp substringWithRange:NSMakeRange(i, 1)] isEqualToString:@"("]||[[self.temp substringWithRange:NSMakeRange(i, 1)] isEqualToString:@")"]))
                {
                    //+,-,*,/
                    while (self.stack1!=nil&&([self getProp:self.stack1.lastObject]>[self getProp:[self.temp substringWithRange:NSMakeRange(i, 1)]])) {
                        [self.stack2 addObject:self.stack1.lastObject];
                        [self.stack1 removeLastObject];
                    }
                    [self.stack1 addObject:[self.temp substringWithRange:NSMakeRange(i, 1)]];
                }else{
                    //( ,)
                    if([[self.temp substringWithRange:NSMakeRange(i, 1)] isEqualToString:@")"])
                    {
                        while (self.stack1!=nil&&![self.stack1.lastObject isEqualToString:@"("]) {
                            [self.stack2 addObject:self.stack1.lastObject];
                            [self.stack1 removeLastObject];
                        }
                        [self.stack1 removeLastObject];
                    }
                    else{
                        [self.stack1 addObject:[self.temp substringWithRange:NSMakeRange(i, 1)]];
                    }
                }
            }
        }
        if(start!=-1)
        {
            [self.stack2 addObject:[self.temp substringWithRange:NSMakeRange(start, i-start)]];
            start=-1;
        }
        while (self.stack1!=nil&&self.stack1.lastObject!=nil) {
            [self.stack2 addObject:self.stack1.lastObject];
            [self.stack1 removeLastObject];
        }
    }
    @catch (NSException *e) {
        self.label.text=@"error";
        NSLog(@"Exception: %@", e);
    }
    [self.stack1 removeAllObjects];
    NSInteger stack2Length=[self.stack2 count];
    for (i=0; i<stack2Length; i++) {
        if([[self.stack2 objectAtIndex:0] isEqualToString:@"+"])
        {
            NSNumber *num2=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *num1=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *result=[NSNumber numberWithDouble:([num1 doubleValue] + [num2 doubleValue])];
            [self.stack1 addObject:result];
        }else if([[self.stack2 objectAtIndex:0] isEqualToString:@"-"])
        {
            NSNumber *num2=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *num1=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *result=[NSNumber numberWithDouble:([num1 doubleValue] - [num2 doubleValue])];
            [self.stack1 addObject:result];
        }else if([[self.stack2 objectAtIndex:0] isEqualToString:@"*"])
        {
            NSNumber *num2=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *num1=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *result=[NSNumber numberWithDouble:([num1 doubleValue] * [num2 doubleValue])];
            [self.stack1 addObject:result];
        }else if([[self.stack2 objectAtIndex:0] isEqualToString:@"/"])
        {
            NSNumber *num2=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *num1=[self.stack1 lastObject];
            [self.stack1 removeLastObject];
            NSNumber *result=[NSNumber numberWithDouble:([num1 doubleValue] / [num2 doubleValue])];
            [self.stack1 addObject:result];
        }else{
            NSNumber *result=[NSNumber numberWithDouble:[[self.stack2 objectAtIndex:0] doubleValue]];
            [self.stack1 addObject:result];
        }
        [self.stack2 removeObjectAtIndex:0];
    }
    self.label.text=[self.stack1.lastObject stringValue];
    [self.string setString:@""];//清空字符
    [self.stack1 removeAllObjects];
    [self.stack2 removeAllObjects];
    [self.temp deleteCharactersInRange:NSMakeRange(0, [self.temp length])];
}

-(void)memr:(id)sender
{
    @try {
        self.label.text=[self.mem stringValue];
    }
    @catch (NSException *e) {
        self.label.text=@"error";
        NSLog(@"Exception: %@", e);
    }
}

-(void)memp:(id)sender
{
    @try {
        self.mem=[NSNumber numberWithDouble:([self.mem doubleValue]+[self.label.text doubleValue])];
    }
    @catch (NSException *e) {
        self.label.text=@"error";
        NSLog(@"Exception: %@", e);
    }
}

-(void)memd:(id)sender
{
    @try {
        self.mem=[NSNumber numberWithDouble:([self.mem doubleValue]-[self.label.text doubleValue])];
    }
    @catch (NSException *e) {
        self.label.text=@"error";
        NSLog(@"Exception: %@", e);
    }
}

-(void)memc:(id)sender
{
    @try {
        self.mem=[NSNumber numberWithDouble:0];
    }
    @catch (NSException *e) {
        self.label.text=@"error";
        NSLog(@"Exception: %@", e);
    }
}

-(int)getProp:(NSString*)oper
{
    if([oper isEqualToString:@"+"]||[oper isEqualToString:@"-"])
        return 1;
    else if([oper isEqualToString:@"*"]||[oper isEqualToString:@"/"])
        return 2;
    else if([oper isEqualToString:@"("])
        return 0;
    else
        return -1;
}

- (int)getType:(NSString*)s
{
    
    if([s isEqualToString:@"1"]||[s isEqualToString:@"2"]||[s isEqualToString:@"3"]||[s isEqualToString:@"4"]||[s isEqualToString:@"5"]||[s isEqualToString:@"6"]||[s isEqualToString:@"7"]||[s isEqualToString:@"8"]||[s isEqualToString:@"9"]||[s isEqualToString:@"0"]||[s isEqualToString:@"."]){
        return 1;
    }else if([s isEqualToString:@"+"]||[s isEqualToString:@"-"]||[s isEqualToString:@"*"]||[s isEqualToString:@"/"]||[s isEqualToString:@"("]||[s isEqualToString:@")"]){
        return 2;
    }
    return 0;
    
}

//当按下清除建时，所有数据清零
-(void)clean:(id)sender
{
    [self.string setString:@""];//清空字符
    [self.stack1 removeAllObjects];
    [self.stack2 removeAllObjects];
    [self.temp deleteCharactersInRange:NSMakeRange(0, [self.temp length])];
    self.label.text=@"0";//保证下次输入时清零
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end