//
//  CustomPickerViewController.m
//  分页栏与选取器01
//
//  Created by CST-112 on 14-11-30.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import "CustomPickerViewController.h"
#import <AudioToolbox/AudioToolbox.h>

@interface CustomPickerViewController ()
{
    NSDictionary *_dictionary;
}

@end

@implementation CustomPickerViewController
{
    SystemSoundID winSoundID;
    SystemSoundID crunchSoundID;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    NSBundle *bundle = [NSBundle mainBundle];
    NSString *path = [bundle pathForResource:@"expressiondic.plist" ofType:nil];
    _dictionary = [NSDictionary dictionaryWithContentsOfFile:path];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)btnAction:(NSString *)filename withcount:(int)count
{
    NSMutableArray * images = [[NSMutableArray alloc]init];
    for (int i=0; i<count; i++) {
        NSString *name = [NSString stringWithFormat:@"%@_%02d.jpg",filename,i];
        NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:nil];
        //        UIImage * img = [UIImage imageNamed:name];
        UIImage *img = [[UIImage alloc] initWithContentsOfFile:path];
        [images addObject:img];
    }
    _cat.animationImages = images;
    _cat.animationRepeatCount = 1;
    _cat.animationDuration = 0.1*count;
    [_cat startAnimating];
}


- (IBAction)ButtonAction:(UIButton *)sender {
    if (_cat.isAnimating) {
        return;
    }
    
    NSString *title = [sender titleForState:UIControlStateNormal];
    int count = [_dictionary[title] intValue];
    [self btnAction:title withcount:count];
    
}
@end
