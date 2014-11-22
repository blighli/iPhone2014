//
//  drawViewController.h
//  mynote
//
//  Created by Van on 14/11/21.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface drawViewController : UIViewController{
    CGPoint lastPoint;
    CGFloat red;
    CGFloat green;
    CGFloat blue;
    CGFloat brush;
    CGFloat opacity;
    BOOL mouseSwiped;
}

@property (weak, nonatomic) IBOutlet UIImageView *mainImage;
@property (weak, nonatomic) IBOutlet UIImageView *tempDrawImage;

- (IBAction)clear:(id)sender;
- (IBAction)save:(id)sender;



@end
