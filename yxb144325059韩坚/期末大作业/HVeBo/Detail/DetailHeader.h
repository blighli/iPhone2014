//
//  DetailHeader.h
//  HVeBo
//
//  Created by HJ on 14/12/15.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import <UIKit/UIKit.h>
@class Status;
@class DetailHeader;

typedef enum {
    kDetailHeaderBtnTypeRepost, // 转发
    kDetailHeaderBtnTypeComment, // 评论
} DetailHeaderBtnType;

@protocol DetailHeaderDelegate <NSObject>
@optional
- (void)detailHeader:(DetailHeader *)header btnClick:(DetailHeaderBtnType)index;
@end

@interface DetailHeader : UIView
+ (id)header;
- (IBAction)btnClick:(UIButton *)sender;
@property (weak, nonatomic) IBOutlet UIImageView *hint;
@property (weak, nonatomic) IBOutlet UIButton *comment;
@property (weak, nonatomic) IBOutlet UIButton *repost;
@property (weak, nonatomic) IBOutlet UIButton *attitude;
@property (nonatomic, strong) Status *status;
@property (nonatomic, weak) id<DetailHeaderDelegate> delegate;
@property (nonatomic, assign, readonly) DetailHeaderBtnType currentBtnType;
@end
