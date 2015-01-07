//
//  DrawViewController.m
//  MyNotes
//
//  Created by 王威 on 14/11/15.
//  Copyright (c) 2014年 zju. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"
#import "UIImage+DrawcaptureView.h"
#import "DBUtilis.h"
#import "AlertUtilis.h"

#define ADD_DRAWED_PICTURE NSLocalizedStringFromTable(@"ADD_DRAWED_PICTURE", @"DrawViewController", @" add a drawed picture")


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

- (IBAction) saveBtnOnClick:(UIButton *)sender{
    UIImage *newImage = [UIImage DrawcaptureImageWithview:self.customView];
    NSData *imageData = UIImagePNGRepresentation(newImage);
    NSString *title = self.pictureTitle.text;
    DBUtilis *dbUtility = [[DBUtilis alloc] init];
    [dbUtility insertText:nil OrImage:imageData WithTitle:title ofType:@"image"];
    [AlertUtilis alertWithTitle:ADD_DRAWED_PICTURE];
}

- (IBAction)textFieldDoneEditing:(id)sender{
    [sender resignFirstResponder];
}

- (IBAction)tapBackground:(id)sender{
    [sender resignFirstResponder];
}
@end
