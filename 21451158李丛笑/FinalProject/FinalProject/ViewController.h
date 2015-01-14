//
//  ViewController.h
//  FinalProject
//
//  Created by 李丛笑 on 15/1/4.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController

@property (strong,nonatomic) NSString *ttag;
- (IBAction)insert:(id)sender;
- (IBAction)query:(id)sender;
- (IBAction)deletedb:(id)sender;
- (IBAction)deleteTable:(id)sender;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundimageView;




@end

