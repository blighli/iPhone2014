//
//  WeiboTableCell.m
//  MyWeibo
//
//  Created by 焦守杰 on 15/1/5.
//  Copyright (c) 2015年 焦守杰. All rights reserved.
//

#import "WeiboTableCell.h"

@implementation WeiboTableCell

- (void)awakeFromNib {
    // Initialization code
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self=[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if(self==nil){
//        self.commentButton.titleLabel.text=[NSString stringWithFormat:@"评(%@)",_commentCount];
//        self.retraButton.titleLabel.text=[NSString stringWithFormat:@"转(%@)",_retraCount];
//        self.praiseButton.titleLabel.text=[NSString stringWithFormat:@"赞(%@)",_praiseCount];

    }
    return self;
}
-(void)setCommentCount:(NSString *)commentCount{
    self->_commentCount=commentCount;
    self.commentButton.titleLabel.text=[NSString stringWithFormat:@"评(%@)",_commentCount];
}
-(void)setRetraCount:(NSString *)retraCount{
    self->_retraCount=retraCount;
    self.retraButton.titleLabel.text=[NSString stringWithFormat:@"转(%@)",_retraCount];
}
-(void)setPraiseCount:(NSString *)praiseCount{
    self->_praiseCount=praiseCount;
    self.praiseButton.titleLabel.text=[NSString stringWithFormat:@"赞(%@)",_praiseCount];
}
@end

