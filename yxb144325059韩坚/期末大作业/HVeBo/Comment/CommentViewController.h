//
//  CommentViewController.h
//  HVeBo
//
//  Created by HJ on 14/12/20.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseViewController.h"
@class Status;

@interface CommentViewController : BaseViewController
@property (weak, nonatomic) IBOutlet UITextView *sendTextView;
@property (weak, nonatomic) IBOutlet UIView *editorBar;
@property (nonatomic, strong)Status *status;
@end
