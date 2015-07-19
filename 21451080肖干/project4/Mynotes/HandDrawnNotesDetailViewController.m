//
//  HandDrawnNotesDetailViewController.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/28/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "HandDrawnNotesDetailViewController.h"

@interface HandDrawnNotesDetailViewController ()
@end

@implementation HandDrawnNotesDetailViewController

@synthesize titleLabel = _titleLabel;
@synthesize titleText = _titleText;
@synthesize rowIndex = _rowIndex;

@synthesize handDrawnNote = _handDrawnNote;

#pragma mark - Managing the detail item

- (void)setHandDrawnNote:(HandDrawnData *)note
{
    if (_handDrawnNote != note) {
        _handDrawnNote = note;
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:243.0/255 green:243.0/255 blue:243.0/255 alpha:1];
    self.titleText.enabled = NO;
    if (self.handDrawnNote) {
        self.navigationItem.title = [self.handDrawnNote dateString];
        self.titleText.text  = self.handDrawnNote.title;
        
        self.imageView.image = self.handDrawnNote.image;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
