//
//  DrawingViewController.h
//  MyNotes
//
//  Created by 杨长湖 on 14/11/26.
//  Copyright (c) 2014年 杨长湖. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DrawingViewController : UIViewController{
    CGPoint lastPoint;
    UIImageView *drawImage;
    BOOL mouseSwiped;
    int mouseMoved;
    UIColor *currentColor;
    int lineSize;
}

@property (weak, nonatomic) IBOutlet UISlider *sliderValue;
- (IBAction)sliderChanged:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *blackH;
@property (weak, nonatomic) IBOutlet UIButton *redH;
@property (weak, nonatomic) IBOutlet UIButton *yellowH;
@property (weak, nonatomic) IBOutlet UIButton *greenH;
@property (weak, nonatomic) IBOutlet UIButton *blueH;
- (IBAction)setColors:(id)sender;
- (IBAction)pointSize:(id)sender;
- (IBAction)bleck:(id)sender;
- (IBAction)red:(id)sender;
- (IBAction)yellow:(id)sender;
- (IBAction)green:(id)sender;
- (IBAction)blue:(id)sender;

@property CGPoint lastPoint;
@property (nonatomic, retain) UIImageView *drawImage;
@property BOOL mouseSwiped;
@property (nonatomic, retain) UIColor *currentColor;

@end
