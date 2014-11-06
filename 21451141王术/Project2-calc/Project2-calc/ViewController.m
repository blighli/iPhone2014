//
//  ViewController.m
//  Project2-calc
//
//  Created by  ws on 14/11/5.
//  Copyright (c) 2014年 ws. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UITextField *display;
@property (strong, nonatomic) IBOutlet UILabel *showSpecial;
@property (strong, nonatomic) IBOutlet UILabel *showFoperator;
@property (strong, nonatomic) IBOutlet UIButton *msubButton;
@property NSString *operator;
@property double fstOperand;
@property double sumOperand;
@property BOOL bBegin;
@property BOOL cptOpen;
@property BOOL backOpen;
@property double mrOperand;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _display.text = @"";
    _showFoperator.text = @"";
    _showSpecial.text = @"";
    _operator = @"=";
    _fstOperand = 0;
    _sumOperand = 0;
    _bBegin = YES;
    _cptOpen = NO;
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)buttonClicked:(id)sender {
    UIButton *btn = (UIButton *)sender;
    int tag = btn.tag;
    
    switch (tag)
    {
            // 初始化清屏
        case clearBtn:	// C    1
            [self clearDisplay];
            break;
            
            // 退格
        case backBtn:	// ←    2
            [self backSpace];
            break;
            
            // 双操作数运算符
        case plusBtn:	// +    3
        case subBtn:	// -    4
        case mulBtn:	// x    5
        case divBtn:	// ÷    6
        case percBtn:	// %	9
        case equalBtn:	// =    7
            [self inputDoubleOperator:btn.titleLabel.text];
            break;
            
        case signBtn:	// +/-  8
            [self addSign];
            break;
        
        // 操作数保留
        case mrBtn:		// MR   10
        case msubBtn:	// M-   11
        case mplusBtn:	// M+   12
        case mcBtn:     //MC    13
            [self numberMemory:btn.titleLabel.text];
            break;
            // 增加小数点
        case dotBtn:	// .    14
            [self addDot];
            break;
            
            // 数字分支
        default:
            [self inputNumber:btn.titleLabel.text];
            break;
    }
 
    
}
- (void)clearDisplay
{
    _display.text = @"";
    _showFoperator.text = @"C";
    _operator = @"=";
    _fstOperand = 0;
    _sumOperand = 0;
    _bBegin = YES;
    _cptOpen = NO;
}
- (void)backSpace
{
    _showFoperator.text = @"←";
    
    if (_backOpen)
    {
        if (_display.text.length == 1)
        {
            _display.text = @"";
        }
        else if (![_display.text isEqualToString:@""])
        {
            _display.text = [_display.text substringToIndex:_display.text.length -1];
        }
    }
}
- (void)inputDoubleOperator: (NSString *)dbopt
{
    _showFoperator.text = dbopt;
    _backOpen = NO;
    
    if(![_display.text isEqualToString:@""])
    {
        _fstOperand = [_display.text doubleValue];
        
        if(_bBegin)
        {
            _operator = dbopt;
        }
        else
        {
            if([_operator isEqualToString:@"="])
            {
                _sumOperand = _fstOperand;
            }
            else if([_operator isEqualToString:@"+"])
            {
                _sumOperand += _fstOperand;
                _display.text = [NSString stringWithFormat:@"%g",_sumOperand];
            }
            else if([_operator isEqualToString:@"-"])
            {
                _sumOperand -= _fstOperand;
                _display.text = [NSString stringWithFormat:@"%g",_sumOperand];
            }
            else if([_operator isEqualToString:@"x"])
            {
                _sumOperand *= _fstOperand;
                _display.text = [NSString stringWithFormat:@"%g",_sumOperand];
            }
            else if([_operator isEqualToString:@"÷"])
            {
                if(_fstOperand!= 0)
                {
                    _sumOperand /= _fstOperand;
                    _display.text = [NSString stringWithFormat:@"%g",_sumOperand];
                }
                else
                {
                    _display.text = @"nan";
                    _operator= @"=";
                }
            }
            else if([_operator isEqualToString:@"%"]){
                if(_fstOperand!= 0)
                {
                    _sumOperand = ((int)_sumOperand)%(int)_fstOperand;
                    _display.text = [NSString stringWithFormat:@"%g",_sumOperand];
                }
                else
                {
                    _display.text = @"nan";
                    _operator= @"=";
                }
            }
            
            _bBegin= YES;
            _operator= dbopt;
        }
    }
}
- (void)addSign
{
    _showFoperator.text = @"+/-";
    
    if(![_display.text isEqualToString:@""] && ![_display.text isEqualToString:@"0"] && ![_display.text isEqualToString:@"-"])
    {
        double number = [_display.text doubleValue];
        number = number*(-1);
        _display.text= [NSString stringWithFormat:@"%g",number];
        
        if(_bBegin)
        {
            _sumOperand = number;
        }
    }    
}
// 增加.方法
- (void)addDot
{
    _showFoperator.text = @".";
    
    if(![_display.text isEqualToString:@""] && ![_display.text isEqualToString:@"-"])
    {
        NSString *currentStr = _display.text;
        BOOL notDot = ([_display.text rangeOfString:@"."].location == NSNotFound);
        if (notDot)
        {
            currentStr= [currentStr stringByAppendingString:@"."];
            _display.text= currentStr;
        }
    }
}
// 数字输入方法
- (void)inputNumber: (NSString *)nbstr
{
    _backOpen = YES;
    _cptOpen = NO;
    
    if(_bBegin)
    {
        _showFoperator.text = @"";
        _display.text = nbstr;
    }
    else
    {
        _display.text = [_display.text stringByAppendingString:nbstr];
    }
    _bBegin = NO;
}
// 操作数保留方法
- (void)numberMemory: (NSString *)nmopt
{
    _showFoperator.text = nmopt;
    _operator = nmopt;
    _bBegin= YES;
    
    if([_operator isEqualToString:@"MR"])
    {
        _display.text=[NSString stringWithFormat:@"%g",_mrOperand];
    }
    else if([_operator isEqualToString:@"M+"])
    {
        _mrOperand += [_display.text doubleValue];
    }
    else if([_operator isEqualToString:@"MC"])
    {
        _mrOperand = 0;
    }
    else if([_operator isEqualToString:@"M-"]){
         _mrOperand -= [_display.text doubleValue];
    }
}

- (void)viewDidUnload {
    self.display = nil;
    self.showFoperator = nil;
    self.showSpecial = nil;
    self.msubButton = nil;
}





@end
