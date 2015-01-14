//
//  EditViewController.h
//  FinalProject
//
//  Created by 李丛笑 on 15/1/5.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EditViewController : UIViewController<UIPickerViewDelegate, UITextFieldDelegate,UIPickerViewDataSource>
{
    NSMutableArray *hourarray;
    NSMutableArray *minutearray;
}
@property (strong,nonatomic) NSString *btag;
@property (strong,nonatomic) NSString *ttagforedit;
//@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
//@property (weak, nonatomic) IBOutlet UITextField *nameBox;
- (IBAction)saveBtn:(id)sender;
@property (weak, nonatomic) IBOutlet UIPickerView *hourPicker;
@property (weak, nonatomic) IBOutlet UITextField *nameBox;


@end
