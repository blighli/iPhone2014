//
//  DetailViewController.h
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController

@property (strong, nonatomic) NSDictionary *detailItem;

@property (weak, nonatomic) IBOutlet UILabel *gTitle;


@property (weak, nonatomic) IBOutlet UITextView *textContent;
@property (weak, nonatomic) IBOutlet UIImageView *imageContent;

@end

