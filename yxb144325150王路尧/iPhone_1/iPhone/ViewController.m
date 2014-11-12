//
//  ViewController.m
//  iPhone
//
//  Created by 王路尧 on 14/11/8.
//  Copyright (c) 2014年 wangluyao. All rights reserved.
//

#import "ViewController.h"
#import "Test.h"
#import "Controller.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)push:(UIButton *)sender {
    
    static Test *countor;
    static BOOL clear=NO;
    static float sum=0;
    
    NSString *title=[sender titleForState:UIControlStateNormal];
    if ([title isEqualToString:@"C"])
        _show.text=@"";
    else if ([title isEqualToString:@"MR"])
    {
        _show.text=[NSString stringWithFormat:(@"%f"),sum];
        countor.result=[NSString stringWithString:_show.text];
    }
    else if([title isEqualToString:@"MC"])
    {
        
        sum=0;
    }
    else if ([title isEqualToString:@"M+"])
    {
        
        sum+=[countor.result floatValue];
        
    }
    else if ([title isEqualToString:@"M-"])
    {
        
        sum-=[countor.result floatValue];
    }
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
    else if([title isEqualToString:@"="])
    {
        countor=[[Test alloc]initWithString:_show.text];
        _show.text=[countor output];
        clear=YES;
    }
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
