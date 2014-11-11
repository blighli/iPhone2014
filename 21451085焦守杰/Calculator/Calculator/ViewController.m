//
//  ViewController.m
//  Calculator
//
//  Created by 焦守杰 on 14/11/4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *label;
- (IBAction)pressButton:(id)sender;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initNumAndFlag];
    isContinueOper=false;
    preNum=0;
    result=0;
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)pressButton:(id)sender {
    UIButton *button=(UIButton *)sender;
    NSString *buttonTitle=button.titleLabel.text;
    NSArray *array=[NSArray arrayWithObjects: @"0",@"1",@"2",@"3",@"4",@"5",@"6",@"7",@"8",@"9",@".",@"MR",@"M+",@"M-",@"+",@"-",@"*",@"/",@"%",@"C",@"=",@"MC",nil];
    int index=[array indexOfObject: buttonTitle];
    switch(index){
        case 0:
        case 1:
        case 2:
        case 3:
        case 4:
        case 5:
        case 6:
        case 7:
        case 8:
        case 9:
            pressMR=false;
            isContinueOper=false;
            pressOper=false;
            if(!dot){
            num=num*10+index;
        }else{
            num=num+index*pow(10, t*(-1));
            t++;
        }
            [self showResult:num];
        break;
        case 10: if(!dot) {
            dot=true;
            t=1;
            }
            break;
        case 11:
            [self showResult:MR];
            [self initNumAndFlag];
            pressMR=true;
            break;
        case 12:MR+=showNum;
            [self initNumAndFlag];
            break;
        case 13:MR-=showNum;
            [self initNumAndFlag];
            break;
        case 14:
            if(pressOper){
                break;
            }
            pressOper=true;
            [self dealWithOper];
            add=true;
            break;
        case 15:
            if(pressOper){
                break;
            }
            pressOper=true;
           [self dealWithOper];
            minus=true;
            break;
        case 16:
            if(pressOper){
                break;
            }
            pressOper=true;
           [self dealWithOper];
            multiply=true;
            break;
        case 17:
            if(pressOper){
                break;
            }
            pressOper=true;
            [self dealWithOper];
            divide=true;
            break;
        case 18:
            if(pressOper){
                break;
            }
            pressOper=true;
            [self dealWithOper];
            mod=true;
          
            break;
        case 19:
            [self initNumAndFlag];
            isContinueOper=false;
            preNum=0;
            [_label setText:@"0"];
            break;
        case 20:
             [self calculateResult];
            [self initNumAndFlag];
            isContinueOper=true;
            break;
        case 21:
            MR=0;
            pressMR=false;
            break;
    }
   
   
 }
-(void)initNumAndFlag{           //初始化标志位
    r=10;
    num=0;
    t=0;
    dot=false;
    add=false;
    minus=false;
    multiply=false;
    divide=false;
    mod=false;
    canCalculate=false;
    isFirst=true;
    pressOper=false;
    pressMR=false;

}
-(void)resetFlag{           //重置标志位
    r=10;
    t=1;
    dot=false;
    num=0;

}
-(void)calculateResult{       //进行运算
    NSLog(@"%f %f",preNum,num);
    if(add){
        result=preNum+num;
        preNum=result;
        [self showResult:result];
        add=false;
    }else if(minus){
        result=preNum-num;
        preNum=result;
        [self showResult:result];
        minus=false;
    }else if(multiply){
        result=preNum*num;
        preNum=result;
        [self showResult:result];
        multiply=false;
    }else if(divide){
        if (num==0) {
            [_label setText:@"除数不能为0！"];
            showNum=0;
        }else{
            result=preNum/num;
            preNum=result;
            [self showResult:result];
        }
        divide=false;
    }else if(mod){
        if ((int)preNum==preNum&&(int)num==num) {
            if(num==0){
                [_label setText:@"不能对0求模！"];
                showNum=0;
            }else{
                result=(int)preNum%(int)num;
                preNum=result;
                [self showResult:result];
            }
        }else{
            [_label setText:@"只有整数才能求模！"];
            showNum=0;
        }
        mod=false;
    }
    
}
-(void)showResult:(double) _showNum{        //显示数字
    showNum=_showNum;
    NSNumber *number=[NSNumber numberWithDouble:_showNum];
    NSString *s=[number stringValue];
    [_label setText:s];
}
-(void)dealWithOper{
    if(isFirst){
        if(!isContinueOper)
            preNum=num;
        if(pressMR){
            preNum=MR;
            pressMR=false;
        }
        isFirst=false;
    }
    if(canCalculate){
        [self calculateResult];
    }
    else
        canCalculate=true;
    pressMR=false;
    [self resetFlag];

}
@end
