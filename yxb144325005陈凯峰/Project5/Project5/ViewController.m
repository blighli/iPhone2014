//
//  ViewController.m
//  Project5
//
//  Created by jingcheng407 on 14-12-29.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end
int nowNum=0;
int score=0;
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self PaintColor];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(int)getRandomNum {
    int value = (arc4random() % 4) + 1;
    return value;
}

-(void)PaintColor{
    int a=0;
    a=[self getRandomNum];
    while(a==nowNum){
        a=[self getRandomNum];
    }
    nowNum=a;
    if(a==1){
        self.button1.backgroundColor=[UIColor blackColor];
    }else{
        self.button1.backgroundColor=[UIColor whiteColor];
    }
    if(a==2){
        self.button2.backgroundColor=[UIColor blackColor];
    }else{
        self.button2.backgroundColor=[UIColor whiteColor];
    }
    if(a==3){
        self.button3.backgroundColor=[UIColor blackColor];
    }else{
        self.button3.backgroundColor=[UIColor whiteColor];
    }
    if(a==4){
        self.button4.backgroundColor=[UIColor blackColor];
    }else{
        self.button4.backgroundColor=[UIColor whiteColor];
    }
    
}

- (IBAction)button1:(id)sender {
    if (self.button1.backgroundColor==[UIColor blackColor]) {
        [self PaintColor];
        score++;
        self.text2.text=[@"分数：" stringByAppendingFormat:@"%d",score];
    }
    
}

- (IBAction)button2:(id)sender {
    if (self.button2.backgroundColor==[UIColor blackColor]) {
        [self PaintColor];
        score++;
        self.text2.text=[@"分数：" stringByAppendingFormat:@"%d",score];
    }
}

- (IBAction)button3:(id)sender {
    if (self.button3.backgroundColor==[UIColor blackColor]) {
        [self PaintColor];
        score++;
        self.text2.text=[@"分数：" stringByAppendingFormat:@"%d",score];
    }
}

- (IBAction)button4:(id)sender {
    if (self.button4.backgroundColor==[UIColor blackColor]) {
        [self PaintColor];
        score++;
        self.text2.text=[@"分数：" stringByAppendingFormat:@"%d",score];
    }
}
@end
