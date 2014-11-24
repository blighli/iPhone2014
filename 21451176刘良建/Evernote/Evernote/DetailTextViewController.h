//
//  DetailTextViewController.h
//  Evernote
//
//  Created by JANESTAR on 14-11-16.
//  Copyright (c) 2014年 JANESTAR. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Text.h"

@interface DetailTextViewController : UIViewController<UITextViewDelegate,UITextFieldDelegate>
@property (nonatomic,retain)UITextView * textView;
@property (nonatomic)NSUInteger rows;
@property (nonatomic)BOOL flag;
@property (nonatomic)Text* txt;
@property(nonatomic)BOOL mark;
@end
