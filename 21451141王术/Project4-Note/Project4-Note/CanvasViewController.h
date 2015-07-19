//
//  CanvasViewController.h
//  Project4-Note
//
//  Created by  ws on 11/20/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CanvasView.h"

@interface CanvasViewController : UIViewController
@property (weak, nonatomic) NSNumber* noteIndex;
@property (weak, nonatomic) id delegate;
@property (strong,nonatomic) UIColor *color;
@property (weak, nonatomic) IBOutlet CanvasView *drawView;
@property (nonatomic) NSManagedObjectContext *managedObjectContext;
@end
