//
//  MDetailViewController.m
//  Mynotes
//
//  Created by lixu on 14/11/23.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "MDetailViewController.h"


@interface MDetailViewController ()


@end

@implementation MDetailViewController
@synthesize datas;

- (void)viewDidLoad {
    [super viewDidLoad];
    if (datas.Type==0) {
        self.navigationItem.title=@"文本";
        _image.hidden=YES;
        _content.text=datas.Note;
    }else if(datas.Type==1){
        self.navigationItem.title=@"图片";
        _content.hidden=YES;
        NSString *imageURL=datas.Note;
        UIImage *image=[[UIImage alloc] initWithContentsOfFile:imageURL];
        _image.image=image;
    }else{
        self.navigationItem.title=@"手绘";
        NSString *imageURL=datas.Note;
        UIImage *image=[[UIImage alloc] initWithContentsOfFile:imageURL];
        _image.image=image;
    }
    // Do any additional setup after loading the view from its nib.
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
