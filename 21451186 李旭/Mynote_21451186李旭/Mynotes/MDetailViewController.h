//
//  MDetailViewController.h
//  Mynotes
//
//  Created by lixu on 14/11/23.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Datas.h"

@interface MDetailViewController : UIViewController
@property (weak, nonatomic) IBOutlet UILabel *content;
@property (weak, nonatomic) IBOutlet UIImageView *image;
@property (strong, nonatomic) Datas *datas;
@end
