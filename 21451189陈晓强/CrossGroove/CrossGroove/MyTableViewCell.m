//
//  MyTableViewCell.m
//  CrossGroove
//
//  Created by 陈晓强 on 14/12/22.
//  Copyright (c) 2014年 陈晓强. All rights reserved.
//

#import "MyTableViewCell.h"

@implementation MyTableViewCell


@synthesize username;
@synthesize groove;
@synthesize review;
@synthesize image;
@synthesize buttonString;

- (void)setUsername:(NSString *)name
{
    if (![name isEqual:username]) {
        username = [name copy];
        self.usernameLabel.text = username;
    }
}


- (void)setGroove:(NSString *)gro
{
    if (![groove isEqual:gro]) {
        groove = [gro copy];
        self.grooveLabel.text = groove;
    }
}


- (void)setReview:(NSString *)rew
{
    if (![rew isEqual:review]) {
        review = [rew copy];
        self.reviewLabel.text = review;
    }
}


- (void)setImage:(UIImage *)img
{
    if (![img isEqual:image]) {
        image = [img copy];
        self.myImageView.image = image;
    }
}

- (void)setButtonString:(NSString *)bString
{
    if (![bString isEqual:buttonString]) {
        buttonString = [bString copy];
        
        self.cButton.titleLabel.text = buttonString;
    }
}
- (IBAction)cButtonClick:(id)sender {
    [self.delegate MyTableViewCellButtonClickCell:self andCountLabel:self.grooveLabel];
}

@end
