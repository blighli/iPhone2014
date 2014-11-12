//
//  ViewController.h
//  Project2
//
//  Created by 江山 on 11/11/14.
//  Copyright (c) 2014 jiangshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
@property(retain,nonatomic) UIButton *button;
@property(retain,nonatomic) UILabel *label;
@property(retain,nonatomic) NSMutableString *string, *temp;  //NSMutableString用来处理可变对象，如需要处理字符串并更改字符串中的字符
@property(retain,nonatomic) NSNumber *mem;
@property(retain,nonatomic) NSMutableArray *stack1, *stack2;//stack1 is for calculate while stack2 is for save data

@end
