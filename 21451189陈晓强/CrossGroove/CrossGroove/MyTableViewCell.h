//
//  MyTableViewCell.h
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/22.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol MyTableViewCellDelegate;
@interface MyTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *myImageView;
@property (weak, nonatomic) IBOutlet UILabel *usernameLabel;
@property (weak, nonatomic) IBOutlet UILabel *reviewLabel;
@property (weak, nonatomic) IBOutlet UILabel *grooveLabel;
@property (weak, nonatomic) IBOutlet UIButton *cButton;


@property (strong, nonatomic) id<MyTableViewCellDelegate> delegate;

@property (copy, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *username;
@property (copy, nonatomic) NSString *review;
@property (copy, nonatomic) NSString *groove;
@property (copy, nonatomic) NSString *buttonString;

@end


@protocol MyTableViewCellDelegate <NSObject>

@optional
- (void)MyTableViewCellButtonClickCell:(MyTableViewCell*)cell andCountLabel:(UILabel *)countLabel;

@end
