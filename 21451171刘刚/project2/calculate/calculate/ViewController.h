//
//  ViewController.h
//  calculate
//
//  Created by liug on 14-11-5.
//  Copyright (c) 2014年 liug. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UILabel *display;
@property (retain,nonatomic) NSMutableString *string;
@property(nonatomic)double onenum,memory;

- (void)  Translate:(const char []) str another: (char []) exp;//转换为逆波兰表达式
- (double) CompValue:(const char *)exp; //求逆波兰表达式的值
-(double) CharToDouble:(const char *)str; //将数字字符串转换为浮点数
@end
