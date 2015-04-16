//
//  HandDrawViewController.h
//  MyNote
//
//  Created by yjq on 14/11/23.
//  Copyright (c) 2014年 yjq. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PIDrawerView.h"
@interface HandDrawViewController : UIViewController

@property(assign,readwrite) BOOL flag;//判断是不是点击tabelview中的cell传过来的

@property (weak, nonatomic) IBOutlet PIDrawerView *drawerView;
@property(weak,nonatomic) IBOutlet UITextField *textfield;
@property(weak,nonatomic)IBOutlet UIImageView *imageview;

@property(strong,nonatomic)NSString *textString;
@property(strong,nonatomic)UIImage *handimage;

-(NSString *) handImageDocPath;
-(NSString *) textDocPath;

@end
