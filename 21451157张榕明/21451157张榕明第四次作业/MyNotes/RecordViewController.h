//
//  RecordViewController.h
//  MyNotes
//
//  Created by 张榕明 on 14/11/22.
//  Copyright (c) 2014年 张榕明. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <AVFoundation/AVFoundation.h>
@interface RecordViewController : UIViewController <AVAudioRecorderDelegate>
{
    AVAudioRecorder * recorder;
    NSTimer * timer;
}

@property (strong, nonatomic) IBOutlet UIImageView *recordImageView;

- (IBAction)recordButtonClick:(UIButton *)sender;
- (IBAction)stopButtonClick:(UIButton *)sender;

@property (strong, nonatomic) IBOutlet UIButton *stopbutton;

@property (strong, nonatomic) IBOutlet UIButton *recordbutton;

@property(strong,nonatomic)NSURL * urlplay;

@end
