//
//  AddHandDrawnViewController.m
//  Mynotes
//
//  Created by xiaoo_gan on 11/27/14.
//  Copyright (c) 2014 xiaoo_gan. All rights reserved.
//

#import "AddHandDrawnViewController.h"
#import "DrawingView.h"

#import "HandDrawnData.h"
#import "HandDrawnDataSource.h"

#import <QuartzCore/QuartzCore.h>

#define kActionSheetColor   100
#define kActionSheetTool    101

@interface HandDrawnViewController ()<UIActionSheetDelegate, drawingViewDelegate>

@end

@implementation HandDrawnViewController

@synthesize titleLabel = _titleLabel;
@synthesize titleText = _titleText;
@synthesize drawingView = _drawingView;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.drawingView.delegate = self;
    self.titleText.delegate = self;
    
    self.lineWidthSlider.value = self.drawingView.lineWidth;
    self.lineAlphaSlider.value = self.drawingView.lineAlpha;
    
    [self.titleText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (void) updateButtonStatus
{
    self.undoButton.enabled = [self.drawingView canUndo];
    self.redoButton.enabled = [self.drawingView canRedo];
}

// 动作方法
- (IBAction)undo:(id)sender
{
    [self.drawingView undoLatestStep];
    [self updateButtonStatus];
}
- (IBAction)redo:(id)sender
{
    [self.drawingView redoLatestStep];
    [self updateButtonStatus];
}
- (IBAction)clear:(id)sender
{
    [self.drawingView clear];
    [self updateButtonStatus];
}

//- (IBAction)takeScreenshot:(id)sender
//{
//    //显示预览图像
//    self.previewImageView.image = self.drawingView.image;
//    self.previewImageView.hidden = NO;
//    
//    //3秒后自动关闭
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 3 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{self.previewImageView.hidden = YES;});
//}
//触摸点在画布上时
- (void) drawingView:(drawingView *)view willBeginDrawUsingTool:(id<drawingTool>)tool
{
    self.lineWidthSlider.hidden = YES;
    self.lineAlphaSlider.hidden = YES;
}
//触摸点不在画布上时
- (void) drawingView:(drawingView *)view didEndDrawUsingTool:(id<drawingTool>)tool
{
    [self updateButtonStatus];
}


#pragma mark - Settings
//颜色工具
- (IBAction)colorChange:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择一种颜色"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles:@"黑色", @"红色", @"绿色", @"蓝色",nil];
    [actionSheet setTag:kActionSheetColor];
    [actionSheet showInView:self.view];
}
//画笔工具
- (IBAction)toolChange:(id)sender
{
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"选择一种画笔形状"
                                                             delegate:self
                                                    cancelButtonTitle:@"取消"
                                               destructiveButtonTitle:nil
                                                    otherButtonTitles: @"铅笔", @"直线", @"矩形（线条）", @"矩形（填充）", @"椭圆（线条）", @"椭圆（填充）", @"橡皮擦", nil];
    [actionSheet setTag:kActionSheetTool];
    [actionSheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (actionSheet.cancelButtonIndex != buttonIndex) {
        if (actionSheet.tag == kActionSheetColor) {
            self.colorButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
            switch (buttonIndex) {
                case 0:
                    self.drawingView.lineColor = [UIColor blackColor];
                    break;
                case 1:
                    self.drawingView.lineColor = [UIColor redColor];
                    break;
                case 2:
                    self.drawingView.lineColor = [UIColor greenColor];
                    break;
                case 3:
                    self.drawingView.lineColor = [UIColor blueColor];
                    break;
            }
        } else {
            self.toolButton.title = [actionSheet buttonTitleAtIndex:buttonIndex];
            switch (buttonIndex) {
                case 0:
                    self.drawingView.drawTool = drawingToolTypePen;
                    break;
                case 1:
                    self.drawingView.drawTool = drawingToolTypeLine;
                    break;
                case 2:
                    self.drawingView.drawTool = drawingToolTypeRectagleStroke;
                    break;
                case 3:
                    self.drawingView.drawTool = drawingToolTypeRectagleFill;
                    break;
                case 4:
                    self.drawingView.drawTool = drawingToolTypeEllipseStroke;
                    break;
                case 5:
                    self.drawingView.drawTool = drawingToolTypeEllipseFill;
                    break;
                case 6:
                    self.drawingView.drawTool = drawingToolTypeEraser;
                    break;
            }
            //当画笔为橡皮擦时，画笔颜色，画笔大小按钮不可用
            if (buttonIndex == 6) {
                self.colorButton.enabled = NO;
                self.alphaButton.enabled = NO;
            } else {
                self.colorButton.enabled = YES;
                self.alphaButton.enabled = YES;
            }
            
        }
    }
}

- (IBAction)toggleWidthSlider:(id)sender
{
    self.lineWidthSlider.hidden = !self.lineWidthSlider.hidden;
    self.lineAlphaSlider.hidden = YES;
}

- (IBAction)widthChange:(UISlider *)sender
{
    self.drawingView.lineWidth = sender.value;
}

- (IBAction)toggleAlphaSlider:(id)sender
{
    self.lineAlphaSlider.hidden = !self.lineAlphaSlider.hidden;
    self.lineWidthSlider.hidden = YES;
}

- (IBAction)alphaChange:(UISlider *)sender
{
    self.drawingView.lineAlpha = sender.value;
}
//取消按钮
- (IBAction)onCancel:(UIBarButtonItem *)sender {
    [self dismissViewControllerAnimated:YES completion:^(void) {}];
}
//完成按钮
- (IBAction)onDone:(UIBarButtonItem *)sender {
    
    if ([self.titleText.text isEqualToString:@""]) {
        UIAlertView *no_title = [[UIAlertView alloc] initWithTitle:@"标题为空"
                                                           message:@"请输入标题"
                                                          delegate:nil
                                                 cancelButtonTitle:@"好的"
                                                 otherButtonTitles:nil, nil];
        [no_title show];
        return;
    }
    
    HandDrawnData *newNote = [[HandDrawnData alloc] init];
    newNote.title = self.titleText.text;
    newNote.date = [NSDate date];
    newNote.image = self.drawingView.image;
    [[HandDrawnDataSource sharedInstance] addNote:newNote];
    
    [self dismissViewControllerAnimated:YES completion:^(void) {}];
}
@end
