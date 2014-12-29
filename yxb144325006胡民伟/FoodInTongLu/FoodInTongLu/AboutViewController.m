//
//  AboutViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/16.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "AboutViewController.h"

@interface AboutViewController ()

@end

@implementation AboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)sendEmail:(id)sender {
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composer = [[MFMailComposeViewController alloc]init];
        composer.mailComposeDelegate = self;
        [composer setToRecipients:@[@"cocoahoo@gmail.com"]];
        composer.navigationBar.tintColor = [UIColor whiteColor];
        [self presentViewController:composer animated:true completion:nil];
        [UIApplication.sharedApplication setStatusBarStyle:UIStatusBarStyleLightContent];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error{
    switch (result ) {
        case MFMailComposeResultCancelled:
            printf("Mail cancelled");
        case MFMailComposeResultSaved:
            printf("Mail saved");
        case MFMailComposeResultSent:
            printf("Mail sent");
        case MFMailComposeResultFailed:
            printf("Failed to send mail: \(error.localizedDescription)");
        default:
            break;
    }
    // Dismiss the Mail interface
    [self dismissViewControllerAnimated:true completion:nil];
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
