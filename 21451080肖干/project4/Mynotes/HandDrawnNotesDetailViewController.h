//
//  HandDrawnNotesDetailViewController.h
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HandDrawnData.h"
#import "HandDrawnDataSource.h"
#import "DrawingView.h"

@class drawingView;
@class HandDrawnData;
@interface HandDrawnNotesDetailViewController : UIViewController<UITextFieldDelegate, drawingViewDelegate>

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UITextField *titleText;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@property  NSInteger rowIndex;
@property (strong, nonatomic) HandDrawnData *handDrawnNote;

@end
