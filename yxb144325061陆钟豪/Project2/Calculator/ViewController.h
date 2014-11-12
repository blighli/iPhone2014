//
//  ViewController.h
//  Project2
//
//  Created by 陆钟豪 on 14/11/4.
//  Copyright (c) 2014年 陆钟豪. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *numbers;
@property (nonatomic, retain) IBOutletCollection(UIButton) NSArray *operators;
@property (nonatomic, retain) IBOutlet UITextField* display;
@property (weak, nonatomic) IBOutlet UIButton *mr;

- (IBAction)onButtonClick:(id)sender;

@end

