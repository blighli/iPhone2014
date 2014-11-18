//
//  NoteImageViewController.h
//  AnyNote
//
//  Created by 黄盼青 on 14/11/18.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "NoteData.h"

@interface NoteImageViewController : UIViewController
@property (strong,nonatomic) NoteData *currentNote;
@property (weak,nonatomic) id delegate;

@property (strong, nonatomic) IBOutlet UIImageView *image;

- (IBAction)closeView:(id)sender;
@end
