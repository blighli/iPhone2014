//
//  DetailViewController.m
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        // Update the view.
        [self configureView];
    }
}

- (void)configureView {
    // Update the user interface for the detail item.
    if (self.detailItem) {
        NSString *type = self.detailItem[@"type"];
        self.gTitle.text = self.detailItem[@"title"];
        if ([type isEqual:@"text"]) {
            self.textContent.hidden = NO;
            self.imageContent.hidden = YES;
            
            self.textContent.text = self.detailItem[@"text"];
        }else{
            self.textContent.hidden = YES;
            self.imageContent.hidden = NO;
            self.imageContent.image = [UIImage imageWithData:self.detailItem[@"image"]];
        }
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
