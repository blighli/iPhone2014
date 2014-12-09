//
//  BBPlayerControlViewController.m
//  balabalaTV
//
//  Created by 黄盼青 on 14/12/7.
//  Copyright (c) 2014年 docee. All rights reserved.
//

#import "BBPlayerControlViewController.h"
#import "BBPlayerViewController.h"

@interface BBPlayerControlViewController ()<UITableViewDelegate,UITableViewDataSource>

@property (strong,nonatomic) UIControl *topControlView;
@property (strong,nonatomic) UIControl *bottomControlView;
@property (strong,nonatomic) BBPlayerViewController *rootViewController;
@property (strong,nonatomic) UIControl *backgroundView;

@property (strong,nonatomic) UIButton *exitButton;
@property (strong,nonatomic) UIButton *changeSourceBtn;
@property (strong,nonatomic) UIButton *playStateControl;

@property (strong,nonatomic) UITableView *sourceView;

@end

@implementation BBPlayerControlViewController

static CGFloat TOP_CONTROL_HEIGHT = 60.0f;//顶部控件视图高度
static CGFloat BOTTOM_CONTROL_HEIGHT = 60.0f;//底部控件视图高度
static UIColor *CONTROL_BGCOLOR = nil;//控件视图颜色
static CGFloat CONTROL_ALPHA = 0.9f;//控制视图透明度
static CGFloat SOURCE_VIEW_WIDTH = 250.0f;//源选择视图宽度
static CGFloat SOURCE_VIEW_HEIGHT = 200.0f;//源选择视图高度
static UIColor *SOURCE_VIEW_BGCOLOR = nil;//源选择视图背景颜色
static CGFloat SOURCE_VIEW_RADIUS = 5.0f;//源选择视图圆角
static CGFloat SOURCE_VIEW_ALPHA = 0.9f;//源选择视图透明度




#pragma mark - Life Cycle
- (instancetype)init
{
    self = [super init];
    if (self) {
        
        CONTROL_BGCOLOR = [UIColor colorWithWhite:0.186 alpha:1.000];
        SOURCE_VIEW_BGCOLOR = [UIColor colorWithWhite:0.186 alpha:1.000];
        
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    CGSize screenSize = self.view.bounds.size;
    
    //初始化Background视图
    _backgroundView = [[UIControl alloc]initWithFrame:self.view.bounds];
    [_backgroundView addTarget:self action:@selector(closePlayerControl) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:_backgroundView];
    
    
    //初始化顶部控制视图
    _topControlView = [[UIControl alloc]initWithFrame:CGRectMake(0, 0, screenSize.width, TOP_CONTROL_HEIGHT)];
    _topControlView.backgroundColor = CONTROL_BGCOLOR;
    _topControlView.alpha = CONTROL_ALPHA;
    [self.view addSubview:_topControlView];
    
    
    //初始化底部控制视图
    _bottomControlView = [[UIControl alloc]initWithFrame:CGRectMake(0, screenSize.height-BOTTOM_CONTROL_HEIGHT, screenSize.width, BOTTOM_CONTROL_HEIGHT)];
    _bottomControlView.backgroundColor = CONTROL_BGCOLOR;
    _bottomControlView.alpha = CONTROL_ALPHA;
    [self.view addSubview:_bottomControlView];
    
    
    //初始化退出按钮
    _exitButton = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGPoint exitBtnCenter = _topControlView.center;
    exitBtnCenter.x = 30.0f;
    exitBtnCenter.y += 5.0f;
    _exitButton.center = exitBtnCenter;
    [_exitButton setBackgroundImage:[UIImage imageNamed:@"btn-back"] forState:UIControlStateNormal];
    [_exitButton addTarget:self action:@selector(didExitBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.topControlView addSubview:_exitButton];
    
    
    //播放控制按钮
    _playStateControl = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
    CGPoint playStateCenter = CGPointMake(_bottomControlView.bounds.size.width/2, _bottomControlView.bounds.size.height/2);
    _playStateControl.center = playStateCenter;
    
    //根据当前播放状态显示控制按钮图标
    if([_rootViewController.player.mediaPlayer isPlaying])
    {
        [_playStateControl setImage:[UIImage imageNamed:@"btn-pause"] forState:UIControlStateNormal];
    }else
    {
        [_playStateControl setImage:[UIImage imageNamed:@"btn-play"] forState:UIControlStateNormal];
    }
    
    [_playStateControl addTarget:self action:@selector(didPlayStateControlClicked) forControlEvents:UIControlEventTouchUpInside];
    [self.bottomControlView addSubview:_playStateControl];
    
    //初始化更换源按钮
    _changeSourceBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 60, 40)];
    CGPoint changeBtnCenter = _topControlView.center;
    changeBtnCenter.x = _topControlView.bounds.size.width - 40.0f;
    changeBtnCenter.y += 5.0f;
    _changeSourceBtn.center = changeBtnCenter;
    [_changeSourceBtn setBackgroundImage:[UIImage imageNamed:@"btn-channel"] forState:UIControlStateNormal];
    [_changeSourceBtn addTarget:self action:@selector(didSourceViewBtnCliked) forControlEvents:UIControlEventTouchUpInside];
    [self.topControlView addSubview:_changeSourceBtn];
    
    //初始化源选择视图
    _sourceView = [[UITableView alloc]initWithFrame:CGRectMake(0, 0, SOURCE_VIEW_WIDTH, SOURCE_VIEW_HEIGHT)];
    _sourceView.layer.cornerRadius = SOURCE_VIEW_RADIUS;
    _sourceView.backgroundColor = SOURCE_VIEW_BGCOLOR;
    _sourceView.center = _backgroundView.center;
    _sourceView.alpha = SOURCE_VIEW_ALPHA;
    [_sourceView setSeparatorStyle:UITableViewCellSeparatorStyleNone];
    _sourceView.hidden = YES;
    _sourceView.delegate = self;
    _sourceView.dataSource = self;
    [self.view addSubview:_sourceView];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - 视图控制

-(void)viewWillLayoutSubviews{
    
    CGSize screenSize = self.view.bounds.size;
    
    _backgroundView.frame = self.view.bounds;
    _topControlView.frame = CGRectMake(0, 0, screenSize.width, TOP_CONTROL_HEIGHT);
    _bottomControlView.frame = CGRectMake(0, screenSize.height-BOTTOM_CONTROL_HEIGHT, screenSize.width, BOTTOM_CONTROL_HEIGHT);
    
    //计算旋屏后播放控制按钮的位置
    CGPoint playStateCenter = CGPointMake(_bottomControlView.bounds.size.width/2, _bottomControlView.bounds.size.height/2);
    _playStateControl.center = playStateCenter;
    
    //计算旋屏后换源按钮的位置
    CGPoint changeBtnCenter = _topControlView.center;
    changeBtnCenter.x = _topControlView.bounds.size.width - 40.0f;
    changeBtnCenter.y += 5.0f;
    _changeSourceBtn.center = changeBtnCenter;
    
    //计算旋屏后源选择视图的位置
    _sourceView.center = _backgroundView.center;
    
}

-(void)showPlayerControl:(UIViewController *)vc{
    self.rootViewController = (BBPlayerViewController *)vc;
    self.view.frame = vc.view.bounds;
    [vc.view addSubview:self.view];
    [vc addChildViewController:self];
    
    //加载动画效果
    CGPoint topControlCenter = _topControlView.center;
    topControlCenter.y-=TOP_CONTROL_HEIGHT;
    _topControlView.center = topControlCenter;
    
    CGPoint bottomControlCenter = _bottomControlView.center;
    bottomControlCenter.y+=BOTTOM_CONTROL_HEIGHT;
    _bottomControlView.center = bottomControlCenter;
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint topControlCenter = _topControlView.center;
        topControlCenter.y+=TOP_CONTROL_HEIGHT;
        _topControlView.center = topControlCenter;
        
        CGPoint bottomControlCenter = _bottomControlView.center;
        bottomControlCenter.y-=BOTTOM_CONTROL_HEIGHT;
        _bottomControlView.center = bottomControlCenter;
        
    }];
}

-(void)closePlayerControl{
    
    //退出动画效果
    
    [UIView animateWithDuration:0.2 animations:^{
        
        CGPoint topControlCenter = _topControlView.center;
        topControlCenter.y-=TOP_CONTROL_HEIGHT;
        _topControlView.center = topControlCenter;
        
        CGPoint bottomControlCenter = _bottomControlView.center;
        bottomControlCenter.y+=BOTTOM_CONTROL_HEIGHT;
        _bottomControlView.center = bottomControlCenter;
        
        _sourceView.alpha = 0.0f;
        
    } completion:^(BOOL finished) {
        
        [self.view removeFromSuperview];
        [self removeFromParentViewController];
        
    }];
}

#pragma mark - 事件监听
//退出按钮点击
-(void)didExitBtnClicked{
    [_rootViewController.player.mediaPlayer stop];
    [_rootViewController dismissViewControllerAnimated:NO completion:nil];
}

//播放控制按钮点击
- (void)didPlayStateControlClicked {

    //加锁防止重复点击
  @synchronized(self) {
    VLCMediaListPlayer *player = _rootViewController.player;
    NSInteger state = player.mediaPlayer.state;

    if ([player.mediaPlayer isPlaying]) {
      [player pause];
      [_playStateControl setImage:[UIImage imageNamed:@"btn-play"]
                         forState:UIControlStateNormal];
    }
      
    if (state == VLCMediaPlayerStatePaused) {
      [player play];
      [_playStateControl setImage:[UIImage imageNamed:@"btn-pause"]
                         forState:UIControlStateNormal];
    }
      
  }
    
}

//直播源按钮点击事件
-(void)didSourceViewBtnCliked{
    
    if(_sourceView.hidden){
        _sourceView.hidden = NO;
    }else
    {
        _sourceView.hidden = YES;
    }
}

#pragma mark - 源选择视图控制
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _rootViewController.player.mediaList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [[UITableViewCell alloc]init];
    cell.textLabel.text = [NSString stringWithFormat:@"直播源%ld",indexPath.row+1];
    cell.textLabel.font = [UIFont boldSystemFontOfSize:14.0f];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.backgroundColor = [UIColor clearColor];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSNumber *index = [NSNumber numberWithInteger:indexPath.row];
    [_rootViewController.player playItemAtIndex:index.intValue];
    
    _sourceView.hidden = YES;
}

@end
