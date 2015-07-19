//
//  PaintViewController.h
//  SXDHomeWork
//
//  Created by  sephiroth on 14/12/11.
//  Copyright (c) 2014年 sephiroth. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PaintViewController : UIViewController

@property (weak, nonatomic) UIImage *image;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorSegment;
- (IBAction)changeColor:(id)sender;

@end
