//
//  ViewController.m
//  MyCaculate
//
//  Created by LFR on 14/11/7.
//  Copyright (c) 2014年 LFR. All rights reserved.
//

#import "ViewController.h"
#import "Model.h"


@interface ViewController ()

@property (nonatomic, strong) Model* myCaculate;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.myCaculate = [[Model alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)numBtn:(UIButton *)sender {
    [_myCaculate updateCurrentNum:sender.titleLabel.text];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)clear:(UIButton *)sender {
    [_myCaculate clearCurrentNum];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)changeOperator:(UIButton *)sender {
    [_myCaculate changeOperator];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)deleteBtn:(UIButton *)sender {
    [_myCaculate deleteNum];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)operatorBtn:(UIButton *)sender {
    [_myCaculate caculateWithOperation:sender.titleLabel.text];
    self.currentNumView.text = _myCaculate.currentNum;
}
- (IBAction)leftBracketBtn:(UIButton *)sender {
    [_myCaculate leftBracket];
}

- (IBAction)rightBracketBtn:(UIButton *)sender {
    [_myCaculate rightBracket];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)equalBtn:(UIButton *)sender {
    [_myCaculate equal];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)percentageBtn:(UIButton *)sender {
    [_myCaculate percentage];
    self.currentNumView.text = _myCaculate.currentNum;
}

- (IBAction)MCleanBtn:(UIButton *)sender {
    [_myCaculate MClean];
    [self changeMRColor];
}

- (IBAction)MAddBtn:(id)sender {
    [_myCaculate MAdd];
    self.currentNumView.text = _myCaculate.memoryNum;
    [self changeMRColor];
}

- (IBAction)MMinus:(id)sender {
    [_myCaculate MMinus];
    self.currentNumView.text = _myCaculate.memoryNum;
    [self changeMRColor];
}

- (IBAction)MRBtn:(UIButton *)sender {
    [_myCaculate storeCurrentNum];
    self.currentNumView.text = _myCaculate.memoryNum;
}

- (void)changeMRColor {
    if (_myCaculate.isMemoryed) {
        self.MRBtn.backgroundColor = [UIColor blueColor];
    } else {
        self.MRBtn.backgroundColor = [UIColor colorWithRed:0.4 green:0.8 blue:1.0 alpha:1];
    }
}



@end
