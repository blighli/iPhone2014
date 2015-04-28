//
//  DetailPicViewController.h
//  Notes
//
//  Created by 陈聪荣 on 14/12/6.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface DetailPicViewController : UIViewController
@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)returnOnclick:(id)sender;

@end
