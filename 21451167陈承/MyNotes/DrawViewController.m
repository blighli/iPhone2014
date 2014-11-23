//
//  DrawViewController.m
//  MyNotes
//
//  Created by chencheng on 14/11/21.
//  Copyright (c) 2014年 jikexueyuan. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"
#import "UIImage+DrawcaptureView.h"
#import "DBUtilis.h"


@interface DrawViewController ()

@property (weak, nonatomic) IBOutlet DrawView *customView;
- (IBAction)clearOnClick:(UIButton *)sender;
- (IBAction)backOnClick:(UIButton *)sender;
- (IBAction)saveBtnOnClick:(UIButton *)sender;


@end
@implementation DrawViewController

- (void)viewDidLoad{
    [super viewDidLoad];
}
//调用清理方法
- (IBAction)clearOnClick:(UIButton *)sender{
    [self.customView clearView];
}
//调用回退方法
- (IBAction) backOnClick:(UIButton *)sender{
    [self.customView backView];
}
//保存按钮的实现
- (IBAction) saveBtnOnClick:(UIButton *)sender{
    UIImage *newImage = [UIImage DrawcaptureImageWithview:self.customView];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    NSString *title = self.pictureTitle.text;
    DBUtilis *dbUtility = [[DBUtilis alloc] init];
    [dbUtility insertText:nil OrImage:imageData WithTitle:title ofType:@"image"];
    UIAlertView *alert =[[UIAlertView alloc]initWithTitle:@"添加手绘图" message:@"恭喜您，添加手绘图成功"delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
    [alert show];

}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)tapBackground:(id)sender{
    [sender resignFirstResponder];
}
@end
