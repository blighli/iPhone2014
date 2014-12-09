//
//  TVListTableViewCell.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/5.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "TVListTableViewCell.h"

#define IS_IPHONE_5S_LAST_SCREEN [UIScreen mainScreen].bounds.size.height <= 568.0f
#define IS_IPHONE_6_LATER_SCREEN [UISCreen mainScreen].bounds.size.height >= 667.0f

@interface TVListTableViewCell()

@property (strong,nonatomic) UIView *listContentView;
@property (strong,nonatomic) UIImageView *circleLogoView;
@property (strong,nonatomic) UILabel *lblTvName;
@property (strong,nonatomic) UILabel *lblTvSourceCount;
@property (strong,nonatomic) UIButton *playBtn;
@property (assign,nonatomic) NSInteger pathRow;

@property (assign,nonatomic) SEL btnSel;
@property (strong,nonatomic) id btnTarget;

@end

@implementation TVListTableViewCell


#pragma mark - Cell Cycle
-(instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if(self)
    {
        //初始化内容框
        CGSize screenSize = [UIScreen mainScreen].bounds.size;
        NSString *sysVersion = [UIDevice currentDevice].systemVersion;
        
        //iOS8以下旋转屏幕时不修改长宽值
        if(sysVersion.floatValue < 8.0f)
        {
            if(UIDeviceOrientationIsLandscape([UIApplication sharedApplication].statusBarOrientation))
            {
                CGSize newScreenSize = CGSizeMake(screenSize.height, screenSize.width);
                screenSize = newScreenSize;
            }
        }
        
        _listContentView = [[UIView alloc]initWithFrame:CGRectMake(10, 10, screenSize.width-20, 107.0f)];
        _listContentView.layer.borderColor = [UIColor colorWithWhite:0.835 alpha:1.000].CGColor;
        _listContentView.layer.borderWidth = 1.0f;
        _listContentView.layer.cornerRadius = 5.0f;
        UIImage *cellBg = [UIImage imageNamed:@"cellbg"];
        _listContentView.backgroundColor = [UIColor colorWithPatternImage:cellBg];
        
        [self.contentView addSubview:_listContentView];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        //初始化圆形Logo
        _circleLogoView = [[UIImageView alloc]initWithFrame:CGRectMake(0, 0, 85, 85)];
        _circleLogoView.center = _listContentView.center;
        CGRect _rect = _circleLogoView.frame;
        _rect.origin.x = 20.0f;
        _rect.origin.y = _rect.origin.y-10;
        _circleLogoView.frame = _rect;
        _circleLogoView.layer.masksToBounds = YES;
        _circleLogoView.backgroundColor = [UIColor whiteColor];
        _circleLogoView.layer.cornerRadius = 42.5;
        _circleLogoView.layer.borderWidth = 1.0f;
        _circleLogoView.layer.borderColor = [UIColor colorWithWhite:0.835 alpha:1.000].CGColor;
        [self.listContentView addSubview:_circleLogoView];
        
        //初始化标签
        _lblTvName = [[UILabel alloc]initWithFrame:CGRectMake(120, 25, 200, 30)];
        _lblTvName.font = [UIFont boldSystemFontOfSize:14.0f];
        _lblTvName.textColor = [UIColor colorWithRed:0.325 green:0.318 blue:0.322 alpha:1.000];
        _lblTvName.text = @"电视台名";
        [self.listContentView addSubview:_lblTvName];
        
        _lblTvSourceCount = [[UILabel alloc]initWithFrame:CGRectMake(120, 45, 100, 30)];
        _lblTvSourceCount.font = [UIFont systemFontOfSize:12.0f];
        _lblTvSourceCount.textColor = [UIColor colorWithWhite:0.537 alpha:1.000];
        _lblTvSourceCount.text = @"直播源:0";
        [self.listContentView addSubview:_lblTvSourceCount];
        
        //初始化播放按钮
        _playBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        CGRect _contentRect = _listContentView.bounds;
        _playBtn.frame = CGRectMake(_contentRect.size.width-110, _contentRect.size.height/2-18, 100, 40);
        _playBtn.layer.borderColor = [UIColor colorWithWhite:0.835 alpha:1.000].CGColor;
        _playBtn.layer.borderWidth = 1.0f;
        _playBtn.layer.cornerRadius = 5.0f;
        _playBtn.titleLabel.font = [UIFont systemFontOfSize:13.0f];
        [_playBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_playBtn setTitleColor:[UIColor colorWithWhite:0.341 alpha:1.000] forState:UIControlStateHighlighted];
        [_playBtn setTitle:@"播放" forState:UIControlStateNormal];
        [_playBtn setTitle:@"播放" forState:UIControlStateHighlighted];
        [_playBtn addTarget:self action:@selector(didPlayBtnClicked) forControlEvents:UIControlEventTouchUpInside];
        _playBtn.showsTouchWhenHighlighted = YES;
        [self.listContentView addSubview:_playBtn];
        
        
        
        //适配iPhone5S之前的机型
        if(IS_IPHONE_5S_LAST_SCREEN)
        {
            _lblTvName.font = [UIFont systemFontOfSize:12.0f];
            CGRect playbtnRect = _playBtn.frame;
            playbtnRect.size.width = 70.0f;
            playbtnRect.origin.x+=25;
            playbtnRect.origin.y-=5;
            _playBtn.frame = playbtnRect;
        }
        
    }
    return self;
}


- (void)awakeFromNib {
    // Initialization code
}

#pragma mark - 视图控制
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    if(selected)
    {
        _listContentView.layer.borderColor = [UIColor colorWithRed:0.227 green:0.694 blue:0.996 alpha:1.000].CGColor;
        _listContentView.layer.borderWidth = 1.5f;
    }
    else
    {
        _listContentView.layer.borderColor = [UIColor colorWithWhite:0.835 alpha:1.000].CGColor;
        _listContentView.layer.borderWidth = 1.0f;
    }
}

//播放按钮点击事件
-(void)didPlayBtnClicked{
    [self.btnTarget performSelectorOnMainThread:self.btnSel withObject:[NSNumber numberWithInteger:self.pathRow] waitUntilDone:NO];
}

#pragma mark - 设置成员变量
-(void)setLogoImage:(UIImage *)image{
    self.circleLogoView.image = image;
}

-(void)setTVName:(NSString *)name{
    self.lblTvName.text = name;
}

-(void)setSourceCount:(NSInteger)count{
    self.lblTvSourceCount.text = [NSString stringWithFormat:@"直播源:%ld",(long)count];
}

-(void)setPathRow:(NSInteger)pathRow{
    _pathRow = pathRow;
}

-(void)setBtnTarget:(id)btnTarget andSelector:(SEL)selector{
    self.btnTarget = btnTarget;
    self.btnSel = selector;
}

@end
