//
//  DrawViewController.h
//  Notes
//
//  Created by xsdlr on 14/11/18.
//  Copyright (c) 2014年 xsdlr. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DrawView.h"

@interface DrawViewController : UIViewController
@property (weak, nonatomic) NSNumber* noteIndex;
@property (weak, nonatomic) id delegate;
@property (weak, nonatomic) IBOutlet DrawView *drawView;
@property (strong,nonatomic) UIColor *color;

@end
