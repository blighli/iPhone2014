//
//  ViewController.h
//  Calculator
//
//  Created by Joker on 14/11/4.
//  Copyright (c) 2014年 Joker. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Stack.h"

@interface ViewController : UIViewController

@property(strong,nonatomic)NSMutableString *formulaString;
@property(assign,nonatomic)int memory;

@end

