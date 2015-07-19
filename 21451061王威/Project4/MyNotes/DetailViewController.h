//
//  DetailViewController.h
//  MyNotes
//
//  Created by 王威 on 14/11/15.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *gTitle;


@property (weak, nonatomic) IBOutlet UITextView *textContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageContent;

@end

