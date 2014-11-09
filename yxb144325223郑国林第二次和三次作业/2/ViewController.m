//
//  ViewController.m
//  001
//
//  Created by CST-112 on 14-11-5.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "ViewController.h"
#import "JS.h"
#import "JSQ.h"
#import "chongzai.h"
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


- (IBAction)button:(UIButton *)sender {
    JS *JSQ;
    static float sum=0;
    
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
        JSQ.sum+=[JSQ.result floatValue];
        NSLog(@"sum=%f",sum);
    }
    else if ([title isEqualToString:@"M-"])
    {
        sum-=[JSQ.result floatValue];
    }
    //
    //←
    else if ([title isEqualToString:@"←"]) {
        NSMutableString *Ath=[NSMutableString stringWithString:_show.text];
        NSRange last=NSMakeRange([Ath length]-1, 1);
        [Ath deleteCharactersInRange:last];
        _show.text=Ath;
    }
    //=
    else if([title isEqualToString:@"="])
    {
        JSQ=[[JS alloc]initWithString:_show.text];
        _show.text=[JSQ output];
        NSLog(@"%@",JSQ.result);
    }
 
    // + - * / 1 2 3....
    else
    {
        NSMutableString * Ath=[NSMutableString stringWithString:_show.text];
        [Ath appendString:title];
        _show.text=Ath;
    }

}
@end
