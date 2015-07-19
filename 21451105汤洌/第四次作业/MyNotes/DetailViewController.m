//
//  DetailViewController.m
//  MyNotes
//
//  Created by tanglie on 14/11/22.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem {
    if (_detailItem != newDetailItem) {
        _detailItem = newDetailItem;
            
        [self configureView];
    }
}

- (void)configureView {

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
//- (void)viewDidLoad {
//    [super viewDidLoad];
//    [self configureView];
//}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
