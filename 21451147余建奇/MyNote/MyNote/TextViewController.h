//
//  TextViewController.h
//  MyNote
//
//  Created by yjq on 14/11/26.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TextViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (copy, nonatomic) NSString *textString;//保存tableview中的cell传递来的数据
-(NSString *) textDocPath;
@end
