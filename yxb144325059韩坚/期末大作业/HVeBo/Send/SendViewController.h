//
//  SendViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/18.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseViewController.h"


@interface SendViewController : BaseViewController

@property (weak, nonatomic) IBOutlet UITextView *sendTextView;
@property (weak, nonatomic) IBOutlet UIView *editorBar;
@property (weak, nonatomic) IBOutlet UIImageView *placeBcakgroundView;
@property (weak, nonatomic) IBOutlet UILabel *placeLabel;

@property (nonatomic, assign) NSInteger openTag;
@property (nonatomic, assign) UIImagePickerControllerSourceType sorceType;
@end
