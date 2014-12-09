//
//  WechatViewController.m
//  justread
//
//  Created by Van on 14/12/7.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "WechatViewController.h"

@interface WechatViewController ()

@end

@implementation WechatViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (id)init{
    if(self = [super init]){
        _scene = WXSceneSession;
    }
    return self;
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
- (Boolean) shareToWechatwith :(NSString *)title
                          with:(NSString *)description
                          with:(NSString *)shareUrl
                          with:(BOOL)isSendToTimeline{
    if ([WXApi isWXAppInstalled] && [WXApi isWXAppSupportApi]) {
        if (isSendToTimeline) {
            _scene=WXSceneTimeline;
        }
        else{
            _scene=WXSceneSession;
        }
        WXMediaMessage *message = [WXMediaMessage message];
        message.title = title;
        message.description = description;
        [message setThumbImage:[UIImage imageNamed:@"icon80.png"]];
        WXWebpageObject *ext = [WXWebpageObject object];
        ext.webpageUrl = shareUrl;
        message.mediaObject = ext;
        SendMessageToWXReq* req = [[SendMessageToWXReq alloc] init];
        req.bText = NO;
        req.message = message;
        req.scene =_scene;
        
        [WXApi sendReq:req];
        return YES;
    }else{
        NSLog(@"没有安装微信");
        return NO;
    }
}
- (void) changeScene:(NSInteger)scene
{
    _scene = scene;
}
- (void) sendLinkContent
{
    
}
@end
