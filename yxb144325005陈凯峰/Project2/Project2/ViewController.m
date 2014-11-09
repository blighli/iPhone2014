//
//  ViewController.m
//  Project2
//
//  Created by jingcheng407 on 14-11-9.
//  Copyright (c) 2014年 chenkaifeng. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *TextLabel;

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
- (IBAction)equalButton:(id)sender {
    //self.TextLabel.text = [NSString stringWithFormat:@"1"];
 
    }
- (IBAction)Button1:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"1";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"1"];
    }
}

- (IBAction)Button2:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"2";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"2"];
    }
}

- (IBAction)Button3:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"3";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"3"];
    }}

- (IBAction)Button4:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"4";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"4"];
    }
}

- (IBAction)Button5:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"5";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"5"];
    }
}

- (IBAction)Button6:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"6";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"6"];
    }
}

- (IBAction)Button7:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"7";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"7"];
    }
}

- (IBAction)Button8:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"8";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"8"];
    }
}

- (IBAction)Button9:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"9";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"9"];
    }
}

- (IBAction)ButtonDot:(id)sender {

    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"."];
}

- (IBAction)ButtonAdd:(id)sender {
    
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"+"];
}

- (IBAction)ButtonSubtract:(id)sender {
   
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"—"];
}

- (IBAction)ButtonMultiply:(id)sender {
    
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"×"];
}

- (IBAction)ButtonDivide:(id)sender {
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"÷"];
}

- (IBAction)ButtonSign:(id)sender {
    
}

- (IBAction)ButtonAC:(id)sender {
    self.TextLabel.text = @"0";
}

- (IBAction)ButtonMC:(id)sender {
    
}

- (IBAction)ButtonMAdd:(id)sender {
    
}

- (IBAction)ButtonMSubtract:(id)sender {
    
}

- (IBAction)ButtonMR:(id)sender {
    
}

- (IBAction)ButtonDel:(id)sender { //删除按钮
    if (![self.TextLabel.text isEqualToString:@"0"]) {
        if(self.TextLabel.text.length!=1){
            self.TextLabel.text = [self.TextLabel.text substringWithRange:NSMakeRange(0,self.TextLabel.text.length-1)];
        }
        else{
            self.TextLabel.text = @"0";
        }
    }
}

- (IBAction)ButtonPercent:(id)sender {
    self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"%"];}

- (IBAction)ButtonLeftBracket:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @"(";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@"("];
    }}

- (IBAction)ButtonRightBracket:(id)sender {
    if ([self.TextLabel.text isEqualToString:@"0"]) {
        self.TextLabel.text = @")";
    }
    else{
        self.TextLabel.text = [self.TextLabel.text stringByAppendingString:@")"];
    }
}


@end
