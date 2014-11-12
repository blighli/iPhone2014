//
//  ViewController.h
//  Calculator
//
//  Created by yjq on 14/11/3.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController
{
    
}
@property(copy,nonatomic)NSString *title;//获取button上的title
@property(readwrite,nonatomic)NSMutableString *num1,*num2;//num2存储最近的一个字符存储数据
@property (weak, nonatomic) IBOutlet UIButton *MemoryRead;
@property(readwrite,nonatomic)IBOutlet UILabel *textLabel;//显示的label

-(IBAction)number:(id)sender;//传递数字键
-(IBAction)Result:(id)sender;//显示结果
-(IBAction)allClear:(id)sender;//清零
-(IBAction)Operators:(id)sender;//运算符操作
-(IBAction)Back:(id)sender;//回退一个字符
-(IBAction)MemoryButton:(id)sender;//关于寄存器的操作按钮集
-(IBAction)ChangeSign:(id)sender;//改变正负号
-(IBAction)spotButton:(id)sender;//小数点
-(IBAction)Persentage:(id)sender;
//-(IBAction)ClearMemory:(id)sender;
//-(IBAction)AddMemory:(id)sender;
//-(IBAction)ReadMemory:(id)sender;
//-(IBAction)MemoryDcrease:(id)sender;
//-(IBAction)two:(id)sender;
-(IBAction)three:(id)sender;
-(IBAction)four:(id)sender;
-(IBAction)five:(id)sender;
-(IBAction)six:(id)sender;
-(IBAction)seven:(id)sender;

@end

