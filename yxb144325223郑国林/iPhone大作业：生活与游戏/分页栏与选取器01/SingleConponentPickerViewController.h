//
//  SingleConponentPickerViewController.h
//  分页栏与选取器01
//
//  Created by CST-112 on 14-11-30.
//  Copyright (c) 2014年 CST-112. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SingleConponentPickerViewController : UIViewController<UIPickerViewDelegate,UIPickerViewDataSource>

@property (weak, nonatomic) IBOutlet UIPickerView *singlePiker;
- (IBAction)buttonPressed:(UIButton *)sender;
@property(strong,nonatomic) NSArray* characterName;
@end
