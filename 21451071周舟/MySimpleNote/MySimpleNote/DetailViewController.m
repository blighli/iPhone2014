//
//  DetailViewController.m
//  MySimpleNote
//
//  Created by 周舟 on 24/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@property (nonatomic,weak) UIImageView *imageView;
@property (nonatomic, weak) UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *canvasView;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configView];
}

- (void)configView
{
    if (self.imagePath != nil)
    {
        NSLog(@"imagePath;%@",_imagePath);
        
        UIImageView *imageView = [[UIImageView alloc] init];
        imageView.frame = CGRectMake(50, 60, self.view.frame.size.width - 100, self.view.frame.size.height - 150);
        UIImage *image = [[UIImage alloc] initWithContentsOfFile:self.imagePath];
        NSLog(@"image:%@",image);
        
        imageView.image = image;
        imageView.hidden = NO;
        [self.canvasView addSubview:imageView];
        NSLog(@"imageView:%@",imageView);
        self.imageView = imageView;
    }
    else
    {
        UITextView *textView = [[UITextView alloc]init];
        textView.frame = CGRectMake(50, 60, self.view.frame.size.width - 100, self.view.frame.size.height - 150);;
        textView.text = self.contentStr;
        textView.userInteractionEnabled = NO;
        [self.canvasView addSubview:textView];
        self.textView = textView;
    }
}



@end
