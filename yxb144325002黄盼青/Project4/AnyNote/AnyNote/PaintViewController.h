//
//  PaintViewController.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PaintView.h"

@interface PaintViewController : UIViewController

@property (strong, nonatomic) IBOutlet UIBarButtonItem *lineWidthLabel;
@property (strong, nonatomic) IBOutlet PaintView *paintView;
@property (strong, nonatomic) IBOutlet UIStepper *lineWidthStepper;


- (IBAction)viewExit:(id)sender;
- (IBAction)clearPaintView:(id)sender;
- (IBAction)changeLineWidth:(UIStepper *)sender;
- (IBAction)chooseColor:(UIBarButtonItem *)sender;
@end
