//
//  ViewController.m
//  test
//
//  Created by qtsh on 14-11-6.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _show=[[NSMutableString alloc] init];
    
}
-(BOOL)isInteger:(NSString *)input
{
    
    return YES;
};

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)btn_1_click
{
    [_show appendString:@"1"];
    [_showField setText:_show];
    NSLog(@"1");
    NSLog(@"%@",_show);
}
-(IBAction)btn_2_click{[_show appendString:@"2"];[_showField setText:_show];}
-(IBAction)btn_3_click{[_show appendString:@"3"];[_showField setText:_show];}
-(IBAction)btn_4_click{[_show appendString:@"4"];[_showField setText:_show];}
-(IBAction)btn_5_click{[_show appendString:@"5"];[_showField setText:_show];}
-(IBAction)btn_6_click{[_show appendString:@"6"];[_showField setText:_show];}
-(IBAction)btn_7_click{[_show appendString:@"7"];[_showField setText:_show];}
-(IBAction)btn_8_click{[_show appendString:@"8"];[_showField setText:_show];}
-(IBAction)btn_9_click{[_show appendString:@"9"];[_showField setText:_show];}
-(IBAction)btn_0_click{[_show appendString:@"0"];[_showField setText:_show];}
-(IBAction)btn_MC_click{memory=0;}
-(IBAction)btn_MP_click{
    @try{
        NSString * temp=_showField.text;float tempFloat=[temp floatValue];
        memory+=tempFloat;
    }
    @catch(NSException *ex)
    {
    }
}
-(IBAction)btn_MM_click
{
    @try{
        NSString * temp=_showField.text;float tempFloat=[temp floatValue];
        memory-=tempFloat;
    }
    @catch(NSException *ex)
    {
    }

}
-(IBAction)btn_MR_click{
    NSMutableString * temp=[NSMutableString stringWithFormat:@"%g",memory];
    _show=temp;
    [_showField setText:_show];
}
-(IBAction)btn_BACK_click{
    if( 0!=[_show length])
    {
        NSString * temp =[_show substringToIndex:[_show length]-1];
        _show=Nil;
        _show = [[NSMutableString alloc] init];
        [_show appendString:temp];
        [_showField setText:_show];
        if(0==[_show length])
        {
            _show=[[NSMutableString alloc] init];
        }
        NSLog(@"%@",_show);
    }
    else
    {
        _show=Nil;
        _show=[[NSMutableString alloc] init];
    }
}
-(IBAction)btn_L_click{[_show appendString:@"("];[_showField setText:_show];}
-(IBAction)btn_R_click{[_show appendString:@")"];[_showField setText:_show];}
-(IBAction)btn_MOD_click{[_show appendString:@"%"];[_showField setText:_show];}
-(IBAction)btn_PLUSS_click{[_show appendString:@"+"];[_showField setText:_show];}
-(IBAction)btn_MINUS_click{[_show appendString:@"-"];[_showField setText:_show];}
-(IBAction)btn_MULTI_click{[_show appendString:@"*"];[_showField setText:_show];}
-(IBAction)btn_DIVID_click{[_show appendString:@"/"];[_showField setText:_show];}
-(IBAction)btn_AC_click{_show=Nil;[_showField setText:_show];_show=[[NSMutableString alloc] init];}
-(IBAction)btn_EQUAL_click
{
    NSString * temp=
    (NSMutableString *)[FormulaStringCalcUtility calcComplexFormulaString:_show];
    _show=Nil;
    _show=[[NSMutableString alloc] init];
    [_show appendString:temp];
    [_showField setText:_show];
}
-(IBAction)btn_DOT_click{[_show appendString:@"."];[_showField setText:_show];}
-(IBAction)btn_POSORNEG_click
{
    NSString* temp;
    if( 0!=[_show length])
    {
    temp=[_show substringFromIndex:[_show length]-1];
        NSLog(@"%@",temp);
    if([temp hasPrefix:@"+"])
    {
        [_show replaceCharactersInRange:NSMakeRange([_show length]-1, 1) withString:@"-"];
        [_showField setText:_show];
    }
    else if([temp hasPrefix:@"-"])
    {
        [_show replaceCharactersInRange:NSMakeRange([_show length]-1, 1) withString:@"+"];
        [_showField setText:_show];
    }
    else
    {
        [_show appendString:@"+"];
        [_showField setText:_show];
    }
    }
    else
    {
        [_show appendString:@"+"];
        [_showField setText:_show];
    }
}

@end
