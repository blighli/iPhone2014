//
//  ViewController.m
//  Calculator
//
//  Created by 顾准新 on 14-11-3.
//  Copyright (c) 2014年 顾准新. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@property (nonatomic) BOOL isEntering;

@end

@implementation ViewController

@synthesize resultDisplay = _resultDisplay;
@synthesize processDisplay = _processDisplay;
@synthesize isEntering = _isEntering;

- (void)viewDidLoad {
    [super viewDidLoad];
    digitalStack = [[NSMutableArray alloc]init];
    operatorStack= [[NSMutableArray alloc] init];
    resultStack = [[NSMutableArray alloc]init];
    right = [[NSMutableArray alloc]init];
    memory = [NSString stringWithFormat:@""];
    //priority = @{@"%":@0,@"*":@1,@"/":@1,@"+":@2,@"-":@2};
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}

//数字输入处理
-(IBAction)numberButtonPressed:(UIButton *)sender{
    if (![self.resultDisplay.text isEqualToString:@"0"])
    {
        if([self.processDisplay.text hasSuffix:@"="])
        {
            self.processDisplay.text = [sender currentTitle];
            [digitalStack clear];
            [operatorStack clear];
            [right clear];
            //self.isEntering = YES;
        
        }else{
            self.processDisplay.text = [self.processDisplay.text stringByAppendingString:[sender currentTitle]];
        }
        if(self.isEntering == YES){
            if([_resultDisplay.text length] < maxNumberCount){
                self.resultDisplay.text = [self.resultDisplay.text stringByAppendingString:[sender currentTitle]];
            }
        }
        else{
            self.resultDisplay.text = [sender currentTitle];
            self.isEntering = YES;
        }
    }
    else if ( ![[sender currentTitle] isEqualToString:@"0"])
    {
        if([self.processDisplay.text hasSuffix:@"=" ] || [self.processDisplay.text isEqualToString:@""]){
            self.resultDisplay.text = [sender currentTitle];
            self.isEntering = YES;
            self.processDisplay.text = self.resultDisplay.text;
        }else{
            self.resultDisplay.text = [sender currentTitle];
            self.isEntering = YES;
            
            self.processDisplay.text=[self.processDisplay.text stringByAppendingString:[sender currentTitle]];
        }
    }
    
}
//操作符输入响应
-(IBAction)operatorButtonPressed:(UIButton *)sender{
    if([self.processDisplay.text hasSuffix:@"="])
    {
        self.processDisplay.text=self.resultDisplay.text;
        [digitalStack clear];
        [operatorStack clear];
        [right clear];
    }
    id top_op,InfixExp_op;
    self.processDisplay.text=[self.processDisplay.text stringByAppendingString:[sender currentTitle]];
    self.isEntering=NO;
    
    currentNum=[self.resultDisplay.text doubleValue];
    
    NSString *operator = [sender currentTitle];
    
    operator= [self dealWithOperator:operator];
    
    if([operator isEqualToString:@"("])
    {
        [operatorStack push:operator];
    }
    else if([operator isEqualToString:@")"])
    {
        [right push:@")"];
        [digitalStack push:self.resultDisplay.text];
        if([operatorStack count] > 0){
            while(  ![[operatorStack peek] isEqualToString:@"("])
            {
                [digitalStack push:[operatorStack pop]];
            }
            [operatorStack pop];
        }
    }
    else
    {
        if([right count]==0)
        {
            [digitalStack push:self.resultDisplay.text];
        }
        else{
            [right pop];
        }
        if([operatorStack count] > 0)
        {
            top_op=[operatorStack peek];
            InfixExp_op=operator;
            
            while([self isHigh:top_op andAnother:InfixExp_op]==true && [operatorStack count] > 0 )
            {
                [digitalStack push:[operatorStack pop]];
                
                if([operatorStack count] > 0){
                    top_op=[operatorStack peek];
                }
            }
        }
        [operatorStack push:operator];
    }
}
//退格
-(IBAction)backButtonPressed:(id)sender{
    if (![self.processDisplay.text hasSuffix:@"="] && ![self.processDisplay.text isEqualToString:@""]) {
        self.processDisplay.text = [self.processDisplay.text substringToIndex:[self.processDisplay.text length]-1];
        if(self.isEntering == YES  && [self.resultDisplay.text length] != 0)
        {
            self.resultDisplay.text = [self.resultDisplay.text substringToIndex:[self.resultDisplay.text length]-1];
            if ([self.resultDisplay.text length]==0) {
                [self.resultDisplay setText:@"0"];
            }
        }
    }
}
//清屏
- (IBAction)clearDisplay:(UIButton *)sender {
    [self.resultDisplay setText:@"0"];
    [self.processDisplay setText:@""];
    [digitalStack clear];
    [operatorStack clear];
    [right clear];
}

//取反
-(IBAction)oppositeButtonPressed:(UIButton *)sender{
    NSMutableString *pm = [[NSMutableString alloc] initWithString:self.resultDisplay.text];
    NSString *replace;
    NSString *search;
    NSRange substr;
    
    if ([[self.resultDisplay.text substringToIndex:1]isEqualToString:@"-"]) {
        search =@"-";
        replace = @"";
        substr=[self.resultDisplay.text rangeOfString:search];
        
        if(substr.location != NSNotFound)
        {
            [pm replaceCharactersInRange:substr withString:replace];
        }
        self.resultDisplay.text=pm;
        
    }
    else{
        if(![self.resultDisplay.text isEqualToString:@"0"] ){
            self.resultDisplay.text=[@"-" stringByAppendingString:self.resultDisplay.text];
        }
    }
    self.processDisplay.text = self.resultDisplay.text;
}
//=
- (IBAction)resultPressed:(id)sender {
    if([self.processDisplay.text length]==0||[self.processDisplay.text hasSuffix:@"="]){
        return;
    }
    self.processDisplay.text=[self.processDisplay.text stringByAppendingString:[sender currentTitle]];
    NSString *result;
    
    self.isEntering=NO;
    if([right count]==0)
    {
        [digitalStack push:self.resultDisplay.text];
    }
    while ([operatorStack count] > 0) {
        [digitalStack push:[operatorStack pop]];
    }

    while([digitalStack count]>0){
        if([self isWhatOperator:[digitalStack peekAtHead]]==5)
        {
            [resultStack push:[digitalStack popAtHead]];
        }
        else
        {
            result = [NSString stringWithFormat:@"%f",[self getValue:[resultStack pop] and:[resultStack pop]and:[self isWhatOperator:[digitalStack popAtHead]]]];
            [resultStack push:result];
        }
    }
  
    if([[resultStack peek] length] >= 7 && [[[resultStack peek]substringFromIndex: [[resultStack peek] length]-6] isEqualToString:@"000000"])
    {
        self.resultDisplay.text=[[resultStack peek]substringToIndex: [[resultStack peek] length]-7] ;
    }
    else
    {
        self.resultDisplay.text=[resultStack pop];
    }
    
}
//MC,M+,M-,MR
-(IBAction)memoryButtonPressed:(UIButton *)sender{
    long int tag = sender.tag;
    switch (tag) {
        case KMemoryClear:
            memory = @"";
            break;
            
        case KMemoryPlus:
            if ([memory isEqualToString:@""]) {
                memory = @"0";
            }
            if(![self.resultDisplay.text isEqualToString:@""]){
                memory = [NSString stringWithFormat:@"%f",[self getValue:memory and:self.resultDisplay.text and:[self isWhatOperator:@"+"]]];
                if([memory length] >= 7 && [[memory substringFromIndex: [memory length]-6] isEqualToString:@"000000"])
                {
                    memory=[memory substringToIndex: [memory length]-7] ;
                }
            }
            break;
        case KMemorySub:
            if ([memory isEqualToString:@""]) {
                memory = @"0";
            }
            if( ![self.resultDisplay.text isEqualToString:@""]){
                memory = [NSString stringWithFormat:@"%f",[self getValue:self.resultDisplay.text and:memory and:[self isWhatOperator:@"-"]]];
                if([memory length] >= 7 && [[memory substringFromIndex: [memory length]-6] isEqualToString:@"000000"])
                {
                    memory=[memory substringToIndex: [memory length]-7] ;
                }
            }
            break;
        case KMemoryR:
            if(![memory isEqualToString:@""]){
                self.resultDisplay.text = memory;
            }
            break;
        default:
            break;
    }
}

//替换操作符号
-(NSString *)dealWithOperator:(NSString *)operator{
    NSString *newOP;
    if([operator isEqualToString:@"÷"]){
        newOP = @"/";
    }else if ([operator isEqualToString:@"×"]) {
        newOP = @"*";
    }else{
        newOP = operator;
    }
    return newOP;
}

-(int)isWhatOperator:(NSString *) current{
    if ([current isEqualToString:@"%"]) return 0;
    if([current isEqualToString:@"+"]) return 1;
    if([current isEqualToString:@"-"]) return 2;
    if([current isEqualToString:@"*"]) return 3;
    if([current isEqualToString:@"/"]) return 4;
    return 5;
}

-(double)getValue:(NSString *)NUM1 and:(NSString *)NUM2 and:(int) operation{
    
    double num2=[NUM1 doubleValue];
    double num1=[NUM2 doubleValue];
    switch (operation) {
        case 0:
            return (int)num1%(int)num2;
        case 1:
            return num1+num2;
            break;
        case 2:
            return num1-num2;
            break;
        case 3:
            return num1*num2;
            break;
        case 4:
            return num1/num2;
            break;
        default:
            break;
    }
    return 0;
}

-(int)priority:(NSString *)operator{
    //if([operator isEqualToString:@"("]) return 3;
    if([operator isEqualToString:@"%"]) return 0;
    if([operator isEqualToString:@"*"] || [operator isEqualToString:@"/"]) return 1;
    if([operator isEqualToString:@"+"] || [operator isEqualToString:@"-"]) return 2;
    return 3;
    
}
//判断两个操作符的优先级
- (BOOL)isHigh:(NSString *)top_op andAnother:(NSString *)InfixExp_op{
    if([InfixExp_op isEqualToString:@")"]) return true;
    
    
    int first = [self priority:top_op];
    int second =[self priority:InfixExp_op];
    if(first <= second){
        return  true;
    }
    return false;
}

@end

@implementation NSMutableArray (myStack)

-(void)push:(NSObject*)parm
{
    [self addObject:parm];
}

-(id)peek
{
    NSObject*item = [self objectAtIndex:([self count]-1)];
    return  item;
}

-(id)pop
{
    NSObject*item = [self peek];
    [self removeObjectAtIndex:([self count]-1)];
    return  item;
}



-(void) insertAtHead:(NSObject*)param
{
    [self insertObject:param atIndex:0];
}

-(id) peekAtHead
{
    NSObject *item = [self objectAtIndex:0];
    return  item;
    
}

-(id) popAtHead
{
    NSObject*item = [self peekAtHead];
    [self removeObjectAtIndex:0];
    return  item;
}


-(void)clear
{
    [self removeAllObjects];
}


@end


