//
//  PictureDetailViewController.m
//  MyNotes
//
//  Created by rth on 14/11/27.
//  Copyright (c) 2014年 MSE.ZJU. All rights reserved.
//

#import "PictureDetailViewController.h"

@interface PictureDetailViewController ()
@property (strong, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation PictureDetailViewController
@synthesize sendPictureName;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    NSLog(@"hahaa");
    NSLog(@"%@",sendPictureName);
    if (sendPictureName) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
        NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"%@",sendPictureName]];
        UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:filePath];
        self.imageView.image = imgFromUrl;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
