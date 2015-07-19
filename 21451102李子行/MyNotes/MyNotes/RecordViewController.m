//
//  RecordViewController.m
//  MyNotes
//
//  Created by lzx on 24/11/14.
//  Copyright (c) 2014年 lzx. All rights reserved.
//

#import "RecordViewController.h"

@interface RecordViewController ()

@end

@implementation RecordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //用来为record设置参数
    [self audio];
    [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



- (IBAction)recordButtonClick:(UIButton *)sender {
    if ([recorder prepareToRecord]) {
        [recorder record];
    }
    timer = [NSTimer scheduledTimerWithTimeInterval:0 target:self selector:@selector(detectionVoice) userInfo:nil repeats:YES];
    self.recordbutton.enabled = NO;
    
}

-(void)detectionVoice
{
    [recorder updateMeters];//刷新音量数据
    //用来观察声音的大小控制图片内容
    double lowpassresult = pow(10, (0.05*[recorder peakPowerForChannel:0]));
    
    if (0<lowpassresult<=0.06) {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_01.png"]];
    }else if(0.06<lowpassresult<=0.13)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_02.png"]];
    }else if (0.13<lowpassresult<=0.20)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_03.png"]];
    }else if (0.20<lowpassresult<=0.27)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_04.png"]];
    }else if (0.27<lowpassresult<=0.34)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_05.png"]];
    }else if (0.34<lowpassresult<=0.41)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_06.png"]];
    }else if (0.41<lowpassresult<=0.48)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_07.png"]];
    }else if (0.48<lowpassresult<=0.55)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_08.png"]];
    }else if (0.55<lowpassresult<=0.62)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_09.png"]];
    }else if (0.62<lowpassresult<=0.69)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_10.png"]];
    }else if (0.69<lowpassresult<=0.76)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_11.png"]];
    }else if (0.76<lowpassresult<=0.83)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_12.png"]];
    }else if (0.83<lowpassresult<=0.9)
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_13.png"]];
    }else
    {
        [self.recordImageView setImage:[UIImage imageNamed:@"record_animate_14.png"]];
    }
}


- (IBAction)stopButtonClick:(UIButton *)sender
{
    //用来停止录音的按钮
    self.recordbutton.enabled = YES;
    double ctime = recorder.currentTime;
    if (ctime<2) {
        UIAlertView * alertview = [[UIAlertView alloc] initWithTitle:@"Waring" message:@"录音时间太短不会被保存" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles: nil];
        [alertview show];
    }
    [recorder stop];
    [timer invalidate];
}

-(void)audio
{
    NSMutableDictionary *recordSetting = [[NSMutableDictionary alloc] init];
    // 设置录音格式AVFormatIDKey==kAudioFormatLinearPCM
    [recordSetting setValue:[NSNumber numberWithInt:kAudioFormatMPEG4AAC] forKey:AVFormatIDKey];
    ////设置录音采样率(Hz) 如：AVSampleRateKey==8000/44100/96000（影响音频的质量）
    [recordSetting setValue:[NSNumber numberWithFloat:44100] forKey:AVSampleRateKey];
    //录音通道数  1 或 2
    [recordSetting setValue:[NSNumber numberWithInt:1] forKey:AVNumberOfChannelsKey];
    //线性采样位数  8、16、24、32
    [recordSetting setValue:[NSNumber numberWithInt:16] forKey:AVLinearPCMBitDepthKey];
    //录音的质量
    [recordSetting setValue:[NSNumber numberWithInt:AVAudioQualityHigh] forKey:AVEncoderAudioQualityKey];
    
    NSString * strUrl = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)lastObject];
    NSURL * url = [NSURL fileURLWithPath:[NSString stringWithFormat:@"%@/lll.aac",strUrl]];
    self.urlplay = url;
    NSError * error;
    recorder = [[AVAudioRecorder alloc] initWithURL:url settings:recordSetting error:&error];
    recorder.meteringEnabled = YES;
    recorder.delegate = self;
    
    
}

@end
