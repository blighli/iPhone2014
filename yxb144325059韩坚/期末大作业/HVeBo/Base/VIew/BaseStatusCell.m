//
//  BaseStatusCell.m
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "BaseStatusCell.h"
#import "IconView.h"
#import "ImageListView.h"
#import "UIImage+MJ.h"
#import "BaseStatusCellFrame.h"
#import "Status.h"
#import "User.h"
#import "RegexKitLite.h"
#import "StatusDetailController.h"

@interface BaseStatusCell()
{
    UILabel *_source; // 来源
    ImageListView *_image; // 配图
    
    UILabel *_retweetedScreenName; // 被转发微博作者的昵称
    MDHTMLLabel *_retweetedText; // 被转发微博的内容
    ImageListView *_retweetedImage; // 被转发微博的配图
}

@end

@implementation BaseStatusCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.userInteractionEnabled = YES;
        // 1.添加微博本身的子控件
        [self addAllSubviews];
        
        // 2.添加被转发微博的子控件
        [self addReweetedAllSubviews];
        
        //背景图片
        self.backgroundColor = KGlobalBackColour;
        self.backgroundView = [[UIImageView alloc]initWithImage:[UIImage resizedImage:@"timeline_card_middle_background.png"] highlightedImage:[UIImage resizedImage:@"timeline_card_middle_background_highlighted.png"]];
                
    }
    return self;
}
- (void)setFrame:(CGRect)frame
{
    frame.origin.y += KTableViewBorder;
    frame.size.height -= KTableViewCellMargin;
    [super setFrame:frame];
}
- (void)addAllSubviews
{
    // 4.来源
    _source = [[UILabel alloc] init];
    _source.font = kSourceFont;
    _source.backgroundColor = [UIColor clearColor];
    [self.contentView addSubview:_source];

    // 6.配图
    _image = [[ImageListView alloc] init];
    [self.contentView addSubview:_image];
}

#pragma mark 被转发微博的子控件
- (void)addReweetedAllSubviews
{
    // 1.被转发微博的父控件
    _retweeted = [[UIImageView alloc]init];
    _retweeted.userInteractionEnabled = YES;
    //_retweeted.backgroundColor = [UIColor colorWithRed:50/255 green:50/255 blue:50/255 alpha:0.03];
    _retweeted.image = [UIImage resizedImage:@"timeline_retweet_background.png"];
    [self.contentView addSubview:_retweeted];
    
    // 3.被转发微博的内容
    _retweetedText = [[MDHTMLLabel alloc] init];
    _retweetedText.numberOfLines = 0;
    _retweetedText.font = kRetweetedTextFont;
    _retweetedText.backgroundColor = [UIColor clearColor];
   
    [_retweeted addSubview:_retweetedText];
    
    // 4.被转发微博的配图
    _retweetedImage = [[ImageListView alloc] init];
    [_retweeted addSubview:_retweetedImage];
}

- (void)setStatusCellFrame:(BaseStatusCellFrame *)statusCellFrame
{
    _statusCellFrame = statusCellFrame;
    Status *s = statusCellFrame.status;
    
    // 1.头像
    _icon.frame = statusCellFrame.iconFrame;
    [_icon setUser:s.user type:kIconTypeSmall];
    
    // 2.昵称
    _screenName.frame = statusCellFrame.screenNameFrame;
    _screenName.text = s.user.screenName;
    // 判断是不是会员
    if (s.user.mbType == kMBTypeNone) {
        _screenName.textColor = kScreenNameColor;
        _mbIcon.hidden = YES;
    } else {
        _screenName.textColor = kMBScreenNameColor;
        _mbIcon.hidden = NO;
        _mbIcon.frame = statusCellFrame.mbIconFrame;
    }
    
    // 3.时间
    _time.frame = statusCellFrame.timeFrame;
    _time.text = s.createdAt;
    if ([s.createdAt  isEqual: @"刚刚"]) {
        _time.textColor = kColor(246, 165, 68);
    }else{
        _time.textColor = [UIColor blackColor];
    }
    
    // 4.来源
    _source.frame = statusCellFrame.sourceFrame;
    _source.text = s.source;
    
    // 5.内容
    _text.frame = statusCellFrame.textFrame;
    //_text.text = s.text;
    _text.htmlText = [super parseLink:s.text];
    _text.delegate = self;
    // 6.配图
    if (s.picUrls.count) {
        _image.hidden = NO;
        _image.frame = statusCellFrame.imageFrame;
        _image.imageUrls = s.picUrls;
    } else {
        _image.hidden = YES;
    }
    
    // 7.被转发微博
    if (s.retweetedStatus) {
        _retweeted.frame = statusCellFrame.retweetedFrame;
        // 8.昵称
        NSString *name = [NSString stringWithFormat:@"@%@:", s.retweetedStatus.user.screenName];
        _retweetedScreenName.frame = statusCellFrame.retweetedScreenNameFrame;
        _retweetedScreenName.text = name;
        // 9.内容
        _retweetedText.frame = statusCellFrame.retweetedTextFrame;
        _retweetedText.htmlText = [self parseLink:s.retweetedStatus.text];
        _retweetedText.delegate = self;
        // 10.配图
        if (s.retweetedStatus.picUrls.count) {
            _retweetedImage.hidden = NO;
            _retweetedImage.frame = statusCellFrame.retweetedImageFrame;
            _retweetedImage.imageUrls = s.retweetedStatus.picUrls;
        } else {
            _retweetedImage.hidden = YES;
        }
    }else{
        _retweeted.hidden = YES;
    }
}


@end
