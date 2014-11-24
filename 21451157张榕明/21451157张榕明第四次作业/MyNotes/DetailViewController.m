//
//  DetailViewController.m
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
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
        self.detailDescriptionLabel.text = [self.detailItem description];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.detailTitle.text = self.modeldata.title;

    switch (self.modeldata.type) {
        case 1:
        case 3:
        {
            self.detailImageView.hidden = NO;
            self.detailImageView.image =[UIImage imageWithData:self.modeldata.contentdata];
        }
        break;
        case 2:
        {
            self.detailImageView.hidden =NO;
            self.detailButton.hidden = NO;
            self.detailImageView.image = [UIImage imageNamed:@"record_animate_01.png"];
        }
        case 4:
        {
            self.detailContentView.hidden = NO;
            self.detailContentView.text = [[NSString alloc] initWithData:self.modeldata.contentdata encoding:NSUTF8StringEncoding];
            break;
        }
        case 5:
        {
            self.detailContentView.hidden = NO;
            self.detailContentView.text = [[NSString alloc] initWithData:self.modeldata.contentdata encoding:NSUTF8StringEncoding];
            break;
        }
        default:
            break;
    }
    [self configureView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)detailButtonClick:(UIButton *)sender {
    //用来播放录音
    
}
@end
