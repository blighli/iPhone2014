//
//  ViewController.m
//  CounterApp
//
//  Created by  sephiroth on 14/11/6.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import "ViewController.h"
#import "counter.h"
#import "Count.h"
#include "NSString+Operator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    countor=[[Count alloc]init];
    [self.view setBackgroundColor:
     [UIColor yellowColor]];}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)push:(UIButton *)sender {
    
    //static Count *countor;
    //countor=[[Count alloc]init];
    //countor=[[Count alloc]initWithString:@""];
    static BOOL clear=NO;
    
    NSString *title=[sender titleForState:UIControlStateNormal];
    //C
    if ([title isEqualToString:@"C"])
        _show.text=@"";
    //MR,M+,M-,MC
    else if ([title isEqualToString:@"MR"])
    {
        _show.text=[NSString stringWithFormat:(@"%f"),[Count sumget]];
        //显示过之后，当前的结果就变为寄存器的值
        countor.result=[NSString stringWithString:_show.text];
    }
    else if([title isEqualToString:@"MC"])
    {
        [Count sumsub:[Count sumget]];
    }
    else if ([title isEqualToString:@"M+"])
    {
        [Count sumpluse:[countor.result floatValue]];
        
    }
    else if ([title isEqualToString:@"M-"])
    {
        [Count sumsub:[countor.result floatValue]];
    }
    //
    //<--
    else if ([title isEqualToString:@"<--"]) {
        NSMutableString *Ath=[NSMutableString stringWithString:_show.text];
        @try
        {
            NSRange last=NSMakeRange([Ath length]-1, 1);
            [Ath deleteCharactersInRange:last];
        }
        @catch(NSException *ex)
        {
            _show.text=@"You can't do this";
        }
       
        _show.text=Ath;
    }
    //=
    else if([title isEqualToString:@"="])
    {
        /*
        count=[[counter alloc]initWithString:_show.text];
        _show.text=[count print];
         */
        
       countor.Arithmetic=[NSMutableString stringWithString:_show.text];
       // countor=[[Count alloc]initWithString:_show.text];
        NSLog(@"%@",countor.Arithmetic);
        _show.text=[countor output];
        clear=YES;
       // NSLog(@"%@",countor.result);
    }
    //
    // + - * / 1 2 3....
    else
    {
        if([title isEqualToString:@"-"]||
           [title isEqualToString:@"+"]||
           [title isEqualToString:@"*"]||
           [title isEqualToString:@"/"])
        {
            clear=NO;
        }
        else if (clear==YES) {
            _show.text=@"";
            clear=NO;
        }
        NSMutableString * Ath=[NSMutableString stringWithString:_show.text];
        [Ath appendString:title];
        _show.text=Ath;
    }
}
@end
