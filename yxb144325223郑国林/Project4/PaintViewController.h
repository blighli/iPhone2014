//
//  PaintViewController.h
//  Project4
//
//  Created by CST-112 on 14-11-19.
//  Copyright (c) 2014年 CST-112. All rights reserved.

#import <UIKit/UIKit.h>

@interface PaintViewController : UIViewController
{
    NSMutableArray *array;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
- (IBAction)changeColor:(id)sender;
- (IBAction)changeShape:(id)sender;

@end
