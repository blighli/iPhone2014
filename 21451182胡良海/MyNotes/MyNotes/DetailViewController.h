//
//  DetailViewController.h
//  MyNotes
//
//  Created by hu on 14/11/14.
//  Copyright (c) 2014年 hu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MyModeldata.h"
@interface DetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;
@property (weak, nonatomic) IBOutlet UILabel *detailDescriptionLabel;


@property (strong, nonatomic) IBOutlet UITextField *detailTitle;
@property (strong, nonatomic) IBOutlet UIImageView *detailImageView;


@property (strong, nonatomic) IBOutlet UIButton *detailButton;


- (IBAction)detailButtonClick:(UIButton *)sender;

@property(retain,nonatomic)MyModeldata * modeldata;


@property (strong, nonatomic) IBOutlet UITextView *detailContentView;



@end

