//
//  ViewController.m
//  DoubanFM
//
//  Created by 陈聪荣 on 14/12/11.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "ViewController.h"
#import "HttpController.h"
#import <MediaPlayer/MediaPlayer.h>
#import <AVFoundation/AVFoundation.h>
#import "UIImage.h"

@implementation ViewController {
    
    HttpController *httpController;
    NSMutableArray *channelArray;
    NSMutableArray *songArray;
    NSDictionary *selectSong;
    MPMoviePlayerController *movieController;
    NSTimer *timer;
    NSInteger channelId;
    NSInteger songIndex;
    BOOL isPause;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _songTableView.delegate = self;
    _songTableView.dataSource = self;
    channelArray = [[NSMutableArray alloc]init];
    songArray = [[NSMutableArray alloc]init];
    httpController = [[HttpController alloc]init];
    [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryPlayback error:nil];
    AVAudioSession *session = [AVAudioSession sharedInstance];
    [session setActive:YES error:nil];
    [session setCategory:AVAudioSessionCategoryPlayback error:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(reloadSongView:)
                                                 name:@"reloadSongView"
                                               object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(nextSong:)
                                                 name:@"nextSong"
                                               object:nil];
    //默认在channel_id=0的频道
    channelId = 0;
    [httpController requestDoubanSongsWithChannel:channelId];
}

//切换频道，刷新歌曲列表
-(void)reloadSongView:(NSNotification*)notification
{
    NSMutableArray *tempArray = [[NSMutableArray alloc]initWithArray:[notification object]];
    NSNumber *channelNumber = [tempArray lastObject];
    [tempArray removeLastObject];
    //若channelId变化重新刷新歌曲列表，未变化增加歌曲
    if (channelId == [channelNumber integerValue]) {
        songIndex = [songArray count];
        [songArray addObjectsFromArray:tempArray];
    }else{
        songIndex = 0;
        [songArray removeAllObjects];
        [songArray addObjectsFromArray:tempArray];
    }
    channelId = [channelNumber integerValue];
    selectSong = [songArray objectAtIndex:songIndex];
    [_songTableView reloadData];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextSong" object:nil userInfo:nil];
}

//下一首
-(void)nextSong:(NSNotification*)notification
{
    NSString *picUrl = [selectSong valueForKey:@"picture"];
    NSData* imageData = [httpController requestSongImage:picUrl];
    //主视图大小修改
    UIImage *maxImage = [UIImage imageWithData:imageData];
    UIImage *maxImageFin = [maxImage transformtoSize:CGSizeMake(_songImageView.frame.size.width, _songImageView.frame.size.height)];
    _songImageView.image = maxImageFin;
    isPause = NO;
    _pauseBtn.hidden = YES;
    [_songImageView addGestureRecognizer:_tapGesture];
    // 实例化后即启动定时器，0.4秒后开始第一次触发
    _songProgressView.progress = 0.0f;    
    timer = [NSTimer scheduledTimerWithTimeInterval:0.3
                                             target:self
                                           selector:@selector(songPlayRefresh)
                                           userInfo: nil
                                            repeats: true];
    movieController = [[MPMoviePlayerController alloc]init];
    [movieController setContentURL:[NSURL URLWithString:[selectSong valueForKey:@"url"]]];
    [movieController play];
}

//歌曲播放，刷新进度条和剩余时间
- (void) songPlayRefresh{
    float current = movieController.currentPlaybackTime;
    float sum = movieController.duration;
    float time = sum - current;
    if(!isnan(time)){
        _songProgressView.progress = current / sum;
        NSString *timeString = [NSString stringWithFormat:@"%02li:%02li",
                                lround(floor(time / 60.)) % 60,
                                lround(floor(time)) % 60];
        _songLeftTime.text = timeString;
        float temp = _songProgressView.progress*10000;
        //自动跳转下一首
        if(temp>9999.0f){
            [timer invalidate];
            [movieController stop];            
            songIndex ++;
            if (songIndex < [songArray count]) {
                selectSong = [songArray objectAtIndex:songIndex];
                [[NSNotificationCenter defaultCenter] postNotificationName:@"nextSong" object:nil userInfo:nil];
            }else{//到达列表最后一首自动请求新歌到列表中
                [httpController requestDoubanSongsWithChannel:channelId];
            }
        }
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return songArray.count;
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"songCell"  forIndexPath:indexPath];
    NSDictionary* songDic = [songArray objectAtIndex:indexPath.row];
    cell.textLabel.text = [songDic valueForKey:@"title"];
    cell.detailTextLabel.text = [songDic valueForKey:@"artist"];
    NSString *picUrl = [songDic valueForKey:@"picture"];
    NSData* imageData = [httpController requestSongImage:picUrl];
    
    //缩略图大小修改
    UIImage *maxImage = [UIImage imageWithData:imageData];
    //cell.imageView.image = MaxImg;
    UIImage *maxImageFin=[maxImage transformtoSize:CGSizeMake(cell.frame.size.height, cell.frame.size.height)];
    cell.imageView.image = maxImageFin;
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [movieController stop];
    songIndex = indexPath.row;
    selectSong = [songArray objectAtIndex:songIndex];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"nextSong" object:nil userInfo:nil];
}

- (void) tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.layer.transform = CATransform3DMakeScale(0.1, 0.1, 1);
    [UIView animateWithDuration:0.25 animations: ^{
        cell.layer.transform=CATransform3DMakeScale(1, 1, 1);
    }];
}

- (IBAction)nextSongClick:(id)sender {
    [movieController stop];
    songIndex++;
    if (songIndex < [songArray count]) {
        selectSong = [songArray objectAtIndex:songIndex];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"nextSong" object:nil userInfo:nil];
    }else{
        [httpController requestDoubanSongsWithChannel:channelId];
    }
}
- (IBAction)onTap:(id)sender {
    if (isPause) {
        isPause = NO;
        _pauseBtn.hidden = true;
        [movieController play];
    }else{
        isPause = YES;
        _pauseBtn.hidden = false;
        [movieController pause];
    }
}
@end
