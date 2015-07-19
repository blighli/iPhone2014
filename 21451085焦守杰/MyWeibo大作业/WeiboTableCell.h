//
//  WeiboTableCell.h
//  MyWeibo
//
//  Created by 焦守杰 on 15/1/5.
//  Copyright (c) 2015年 焦守杰. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WeiboTableCell : UITableViewCell

@property  (strong,nonatomic) NSString *commentCount;
@property (strong,nonatomic) NSString *retraCount;
@property (strong,nonatomic) NSString *praiseCount;

@property (weak, nonatomic) IBOutlet UIImageView *headImage;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UIButton *commentButton;
@property (weak, nonatomic) IBOutlet UIButton *retraButton;
@property (weak, nonatomic) IBOutlet UIButton *praiseButton;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end
