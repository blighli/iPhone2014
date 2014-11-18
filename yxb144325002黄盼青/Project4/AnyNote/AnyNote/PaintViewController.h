//
//  PaintViewController.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MagicalRecord/CoreData+MagicalRecord.h>
#import "NoteData.h"
#import "PaintView.h"
#import "ViewController.h"

@interface PaintViewController : UIViewController

@property (weak,nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UIBarButtonItem *lineWidthLabel;
@property (strong, nonatomic) IBOutlet PaintView *paintView;
@property (strong, nonatomic) IBOutlet UIStepper *lineWidthStepper;


- (IBAction)viewExit:(id)sender;
- (IBAction)clearPaintView:(id)sender;
- (IBAction)changeLineWidth:(UIStepper *)sender;
- (IBAction)chooseColor:(UIBarButtonItem *)sender;
- (IBAction)savePaint:(id)sender;
@end
