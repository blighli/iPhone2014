//
//  BookFrontView.h
//  MySecretDiary
//
//  Created by icy on 14-12-22.
//  Copyright (c) 2014年 icy. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BookViewController;
@class User;
@class FXLabel;

@interface BookFrontView : UIView
{
//    UIImageView *bookImgView;
//    UILabel *nameLabel;
//    UITextField *nameTextField;
//    UILabel *dateLabel;
//    UIButton *addNewButton;
//    UIButton *configButton;
//    UILabel *summaryLabel;
    
}


@property (strong, nonatomic) UIImageView *bookImgView;
@property (strong, nonatomic) UILabel *nameLabel;
@property (strong, nonatomic) UILabel *dateLabel;
@property (strong, nonatomic) UITextField *nameTextField;
@property (strong, nonatomic) UIButton *addNewButton;
@property (strong, nonatomic) UIButton *configButton;
@property (strong, nonatomic) UILabel *summaryLabel;
@property (assign)BookViewController *viewController;

-(void)showPlusButton;
-(void)hidePlusButton;
-(void)showConfigAndDate;

-(void)refresh;
-(void)showWins;
-(void)showLosses;
@end
