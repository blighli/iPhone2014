//
//  ViewController.m
//  Counter
//
//  Created by Mac on 14-11-7.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ViewController.h"
#import "counter.h"

#include "NSString+Operator.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [_show setTextColor:[UIColor whiteColor]];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(UIButton *)sender {
    
    static counter *countor;
    static float sum=0;
    
    //counter *count;
    
    NSString *title=[sender titleForState:UIControlStateNormal];
    //C
    if ([title isEqualToString:@"C"])
        _show.text=@"";
    //MR,M+,M-,MC
    else if ([title isEqualToString:@"MR"])
    {
        _show.text=[NSString stringWithFormat:(@"%f"),sum];
    }
    else if([title isEqualToString:@"MC"])
    {
        sum=0;
    }
    else if ([title isEqualToString:@"M+"])
    {
        sum+=countor.result;
        NSLog(@"sum=%f",sum);
    }
    else if ([title isEqualToString:@"M-"])
    {
        
       sum-=countor.result;
        NSLog(@"sum=%f",sum);
    }
    //
    //<--
    else if ([title isEqualToString:@"<--"]) {
        NSMutableString *Ath=[NSMutableString stringWithString:_show.text];
        @try{
            NSRange last=NSMakeRange([Ath length]-1, 1);
            [Ath deleteCharactersInRange:last];
        }
        @catch(NSException *ex)
        {
            
        }
        _show.text=Ath;
    }
    //=
    else if([title isEqualToString:@"="])
    {
        
        
        countor=[[counter alloc]initWithString:_show.text];
        _show.text=[countor print];
    }
    //
    // + - * / 1 2 3....
    else
    {
        NSMutableString * Ath=[NSMutableString stringWithString:_show.text];
        [Ath appendString:title];
        _show.text=Ath;
    }
}
@end

