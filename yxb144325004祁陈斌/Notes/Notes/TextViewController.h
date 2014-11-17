//
//  TextViewController.h
//  Notes
//
//  Created by xsdlr on 14/11/17.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController
@property (weak, nonatomic) NSNumber* noteIndex;
@property (weak, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet UITextView *textView;
@end
