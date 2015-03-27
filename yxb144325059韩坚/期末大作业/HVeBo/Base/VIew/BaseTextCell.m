//
//  BaseTextViewCell.m
//  HVeBo
//
//  Created by HJ on 14/12/16.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseTextCell.h"
#import "IconView.h"
#import "BaseTextcellframe.h"
#import "BaseText.h"
#import "User.h"
#import "UIImage+MJ.h"

@interface BaseTextCell()

@end

@implementation BaseTextCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {

    //背景图片
    self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage resizedImage:@"statusdetail_comment_background_middle.png"] highlightedImage:[UIImage resizedImage:@"statusdetail_comment_background_middle_highlighted.png"]];
     }
    return self;
}

-(void)setCellFrame:(BaseTextCellFrame *)cellFrame
{
    _cellFrame = cellFrame;
    
    BaseText *baseText = cellFrame.baseText;
    //1头像
    _icon.frame = cellFrame.iconFrame;
    [_icon setUser:baseText.user type:kIconTypeSmall];

    //2昵称
    _screenName.frame = cellFrame.screenNameFrame;
    _screenName.text = baseText.user.screenName;
    // 3判断是不是会员
    if (baseText.user.mbType == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = cellFrame.mbIconFrame;
    }
    
    // 4.内容
    _text.frame = cellFrame.textFrame;
    _text.htmlText = [self parseLink:baseText.text];
    _text.delegate = self;
    // 5.时间
    _time.frame = cellFrame.timeFrame;
    _time.text = baseText.createdAt;
    if ([baseText.createdAt  isEqual: @"刚刚"]) {
        _time.textColor = kColor(246, 165, 68);
    }else{
        _time.textColor = [UIColor blackColor];
    }
}
@end
