//
//  enterTheCategoryViewController.h
//  mount
//
//  Created by 江山 on 1/3/15.
//  Copyright (c) 2015 jiangshan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface enterTheCategoryViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *TitleLabel;
@property (strong, nonatomic) IBOutlet UITextField *TextFieldStr;
@property (strong, nonatomic) IBOutlet UILabel *TextFieldName;
- (IBAction)addButton:(id)sender;
@property(nonatomic,strong)NSNumber*number;
@end
