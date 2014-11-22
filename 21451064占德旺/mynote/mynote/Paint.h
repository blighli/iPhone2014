//
//  Paint.h
//  mynote
//
//  Created by Devon on 14/11/20.
//  Copyright (c) 2014年 Devon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
#import "NewNoteViewController.h"

@interface Paint : UIViewController

@property (nonatomic,retain) id<ImageDelegate> delegate;

-(IBAction)clear:(id)sender;
- (IBAction)colorSet:(id)sender;
-(IBAction)widthSet:(id)sender;
- (IBAction)save:(id)sender;
@end
