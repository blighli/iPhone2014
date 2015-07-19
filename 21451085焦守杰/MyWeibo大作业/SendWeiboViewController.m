
//
//  SendWeiboViewController.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/4.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "SendWeiboViewController.h"
#import <QuartzCore/QuartzCore.h>
@interface SendWeiboViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UILabel *wordCountLabel;

@end

@implementation SendWeiboViewController
- (IBAction)clickCancelButton:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (IBAction)clickSendButton:(id)sender {
    NSString *content=[self.textView.text stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    [NSThread detachNewThreadSelector:@selector(updateWeibo:) toTarget:_weibo withObject:content];
    [_weibo updateWeibo:content];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    _weibo=[Weibo getInstance];
    self.textView.layer.borderWidth =1.0;
    self.textView.layer.cornerRadius =5.0;
    [self.textView setDelegate:self];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text{
    int count=140-[self.textView.text length];
    NSString *s=[NSString stringWithFormat:@"%d个字",count];
    self.wordCountLabel.text=s;
    return YES;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
