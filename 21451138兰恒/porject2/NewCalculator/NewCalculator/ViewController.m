//
//  ViewController.m
//  NewCalculator
//
//  Created by lh on 14-11-4.
//  Copyright (c) 2014年 lh. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"
#import "Memory_cal.h"

@interface ViewController ()
@property (nonatomic) BOOL userInter;
@property (nonatomic,strong) CalculatorBrain *brain;
@property (nonatomic,strong) Memory_cal *mem_cal;
@end

@implementation ViewController
@synthesize display = _display;
@synthesize Oquation = _Oquation;
@synthesize display_M =_display_M;
@synthesize userInter =_userInter;
@synthesize brain = _brain;
@synthesize mem_cal = _mem_cal;
- (CalculatorBrain*)brain
{
    if(_brain == nil)
        _brain = [[CalculatorBrain alloc]init];
    return _brain;
        
}
- (Memory_cal*)mem_cal
{
    if(_mem_cal == nil)
        _mem_cal = [[Memory_cal alloc]init];
    return  _mem_cal;
}
- (IBAction)digitPressed:(UIButton*)sender
{
    NSString *digit = [sender currentTitle];
    if(self.userInter)
    {
        if([digit isEqualToString:@"%"])
            digit = @"*0.01";
        self.Oquation.text = [self.Oquation.text stringByAppendingString:digit];
    }
    else
    {
        self.Oquation.text = digit;
        self.userInter = YES;
    }
        
}
- (IBAction)valueAs:(id)sender
{
    NSString*content =  self.Oquation.text;
    if(![content isEqualToString:@""])
    {
        double value = [self.brain dealWhitString:content];
        if(!(fabs(value) <= 1e-15 ) && !abs(value + 999999) <= 1e-15)
        {
            if(fabs(value) >= 1)
            {
                self.display.text =[[NSString stringWithFormat:@"%6f",value]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
                self.display.text =[self.display.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
                

            }
            else
                self.display.text =[NSString stringWithFormat:@"%6f",value];
                        
            
        }
        else if((fabs(value) <= 1e-15 ))
            self.display.text = @"0";
        else
            self.display.text =@"表达式错误！";
        
        NSLog(@"%f",value);
        
    }
    else

        NSLog(@"nothing");
    
}

- (IBAction)acZero:(id)sender
{
    self.Oquation.text  = @"";
}
- (IBAction)delectDigitOrSmybol:(id)sender
{
    NSString *newtext = self.Oquation.text;
    if(newtext.length >0)
        newtext = [newtext substringToIndex:newtext.length  -1];
    self.Oquation.text = newtext;
}
- (IBAction)nevOrpre:(UIButton*)sender
{
    NSString *isNeg = self.display.text;
    int length =0;
    
    int a = [isNeg characterAtIndex:0];
    if(!([isNeg isEqualToString:@"0"] || (a > 0x4e00 && a < 0x9fff)))
    {
        length = [isNeg length];
        if([[isNeg substringWithRange:NSMakeRange(0, 1)] isEqualToString:@"-"])
            isNeg = [isNeg substringFromIndex:1];
        else
        {
            NSString *a = @"-";
            isNeg = [a stringByAppendingString:isNeg];
            
        }
        
        self.display.text = isNeg;
          
        
    }
        

    
    NSLog(@"%@",self.display.text);
    
            
}
- (IBAction)memory_pressed:(UIButton *)sender
{
    self.display_M.text =@"M";
    NSString *operator = [sender currentTitle];
    if([operator isEqualToString:@"MC"])
        [self.mem_cal memory_clean];
    else if([operator isEqualToString:@"M+"])
        [self.mem_cal memory_add:[self.display.text doubleValue]];
    else if([operator isEqualToString:@"M-"])
        [self.mem_cal memory_minus:[self.display.text doubleValue]];
    else
    {
        if((fabs([self.mem_cal memory_recall]) >= 1 ))
        {
            self.display.text =[[NSString stringWithFormat:@"%6f",[self.mem_cal memory_recall]]stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"0"]];
            self.display.text =[self.display.text stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"."]];
            
        }
        else if(fabs([self.mem_cal memory_recall] <= 1e-15))
            self.display.text = @"0";
        else
            self.display.text =[NSString stringWithFormat:@"%6f",[self.mem_cal memory_recall]];
            
            

    }
       
    
    
}

@end
