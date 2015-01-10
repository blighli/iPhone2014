//
//  CommentCell.h
//  weiBo
//
//  Created by lixu on 15/1/9.
//  Copyright (c) 2015年 lixu. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface CommentCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIButton *share;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *favour;

@end