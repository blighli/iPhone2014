//
//  DrawViewController.h
//  MyNotes
//
//  Created by cstlab on 14/11/12.
//  Copyright (c) 2014年 cstlab. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>

@interface DrawViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIButton *ColorBtn;      // 颜色按钮自身的属性
//  界面按钮事件
- (IBAction)ClearAll:(UIButton *)sender;     // 清屏按钮
//- (IBAction)SelectColor:(UIButton *)sender;
- (IBAction)Save:(UIButton *)sender;       // 保存按钮
- (IBAction)TapWithBtn:(UIButton *)sender;   // 宽度 （4个按钮）
- (IBAction)TapColorBtn:(UIButton *)sender;   // 颜色（4个按钮）
- (IBAction)selectColor:(UIButton *)sender;  // 颜色按钮
- (IBAction)Back:(UIButton *)sender;
// 回退按钮
- (IBAction)SelectWidth:(UIButton *)sender; // the 宽度 按钮
 // 画图设置与事件定义
- (IBAction)Delete:(UIButton *)sender;


@end

