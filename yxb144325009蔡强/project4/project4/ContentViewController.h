//
//  ContentViewController.h
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ContentViewController : UIViewController
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (strong, nonatomic) NSMutableArray *notesArray;
@property (strong, nonatomic) NSIndexPath *indexPath;

@end
