//
//  ChakanShouxie.h
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import<UIKit/UIKit.h>

@interface ChakanShouxie : UIViewController<UIImagePickerControllerDelegate>
{
    CGPoint MyBeganpoint;
    CGPoint MyMovepoint;
    IBOutlet UITextField* titleField;
    IBOutlet UIButton* saveButton;
    IBOutlet UIButton* deleButton;
    IBOutlet UIButton* undoButton;
    IBOutlet UIButton* cleaButton;
    
}
    @property (nonatomic) CGPoint firstTouch;
    @property (nonatomic) CGPoint lastTouch;
    @property (strong, nonatomic) UIColor *currentColor;
    @property (nonatomic, strong) UIImage *drawImage;
    @property (nonatomic) BOOL useRandomColor;
@property (nonatomic,strong)UITextField * titleField;




@property IBOutlet UIImageView * imageView;
@property IBOutlet UIButton* saveButton;
@property IBOutlet UIButton* deleButton;
@property IBOutlet UIButton* undoButton;
@property IBOutlet UIButton* cleaButton;
@end