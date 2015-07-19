//
//  DrawViewController.m
//  MyNotes
//
//  Created by tanglie on 14/11/22.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"
#import "UIImage+DrawcaptureView.h"
#import "DBUtilis.h"
#import "AlertUtilis.h"

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

- (IBAction)clearOnClick:(UIButton *)sender{
    [self.customView clearView];
}

- (IBAction) backOnClick:(UIButton *)sender{
    [self.customView backView];
}
//
//- (IBAction) saveBtnOnClick:(UIButton *)sender{
//    UIImage *newImage = [UIImage DrawcaptureImageWithview:self.customView];
//    NSData *imageData = UIImagePNGRepresentation(newImage);
//    NSString *title = self.pictureTitle.text;
//}
- (IBAction) saveBtnOnClick:(UIButton *)sender{
    UIImage *newImage = [UIImage DrawcaptureImageWithview:self.customView];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    NSString *title = self.pictureTitle.text;
    DBUtilis *dbUtility = [[DBUtilis alloc] init];
    [dbUtility insertText:nil OrImage:imageData WithTitle:title ofType:@"image"];
    [AlertUtilis alertWithTitle:@"添加绘图"];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)tapBackground:(id)sender{
    [sender resignFirstResponder];
}
@end
