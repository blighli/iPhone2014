//
//  XLMeViewController.m
//  XinLang
//
//  Created by 周舟 on 14-10-1.
//  Copyright (c) 2014年 zzking. All rights reserved.
//

#import "XLMeViewController.h"
#import "XLAccount.h"
#import "XLAccountTool.h"
#import "XLUserInfoResult.h"
#import "XLUserInfoParam.h"
#import "XLUserTool.h"
#import "XLUser.h"
#import "UIImageView+WebCache.h"

@interface XLMeViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *photoImage;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UIButton *followersBtn;
@property (weak, nonatomic) IBOutlet UIButton *friendsBtn;
@property (weak, nonatomic) IBOutlet UIButton *statusCountBtn;

@end

@implementation XLMeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self configView];
}

- (void)configView
{
    XLUserInfoParam *param = [[XLUserInfoParam alloc] init];
    
    param.uid = @([XLAccountTool account].uid);
    
    [XLUserTool userInfoWithParam:param success:^(XLUserInfoResult *result) {
        
        NSURL *url = [[NSURL alloc] initWithString:result.avatar_large];
        [_photoImage sd_setImageWithURL:url placeholderImage:nil];
        _nameLabel.text = result.name;
        _descriptionLabel.text = [NSString stringWithFormat:@"简介:%@", result.s_description];
        [self setBtn:_followersBtn withCount:result.friends_count andText:@"关注:"];
        [self setBtn:_friendsBtn withCount:result.followers_count andText:@"粉丝:"];
        [self setBtn:_statusCountBtn withCount:result.statuses_count andText:@"微博:"];
    } failure:^(NSError *error) {
        NSLog(@"%@",error.localizedDescription);
       
    }];
}

- (void)setBtn:(UIButton *)button withCount:(int)count andText:(NSString *)typeText;
{
    NSString *text;
    if (count < 10000) {
        text = [NSString stringWithFormat:@"%@%d", typeText,count];
    }
    else
    {
        text = [NSString stringWithFormat:@"%@%.2f万", typeText,count / 10000.0];
        //NSLog(@"%.2f",1.094738);
    }
    [button setTitle:text forState:UIControlStateNormal];
    [button setTitle:text forState:UIControlStateHighlighted];
}

@end
