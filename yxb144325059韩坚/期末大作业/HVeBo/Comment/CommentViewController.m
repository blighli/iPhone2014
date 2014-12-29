//
//  CommentViewController.m
//  HVeBo
//
//  Created by HJ on 14/12/20.
//  Copyright (c) 2014年 hj. All rights reserved.
//

#import "CommentViewController.h"
#import "Status.h"
#import "UIButton+HJ.h"
#import "UIViewExt.h"
#import "NSString+MJ.h"
#import "HttpTool.h"

@interface CommentViewController ()
@property (nonatomic, strong)NSMutableArray *buttons;
@end

@implementation CommentViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if (self == [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboaedShowNotification:) name:UIKeyboardWillShowNotification object:nil];
    }
    return self;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"评论微博";
    
    UIBarButtonItem *right = [[UIBarButtonItem alloc] initWithTitle:@"评论" style:UIBarButtonItemStylePlain target:self action:@selector(sentAction)];
    self.navigationItem.rightBarButtonItem = right;
    
    [self _initView];
}
- (void)viewWillAppear:(BOOL)animated
{
    [self.sendTextView becomeFirstResponder];
}
- (void)viewWillDisappear:(BOOL)animated
{
    [self.sendTextView resignFirstResponder];
}
- (void)_initView
{
    _buttons = [NSMutableArray array];
    NSArray *imageNames = [NSArray arrayWithObjects:
                           //@"compose_locatebutton_background.png",
                           //@"compose_camerabutton_background.png",
                           @"compose_trendbutton_background.png",
                           @"compose_mentionbutton_background.png",
                           @"compose_emoticonbutton_background.png",
                           @"compose_keyboardbutton_background.png",
                           nil];
    
    for (int i = 0; i < imageNames.count; i++) {
        UIButton *button = [UIButton itemWithIcon:imageNames[i] highlightedIcon:[imageNames[i] fileAppend:@"_highlighted"] target:self action:@selector(buttonAction:)];
        button.tag = 30 + i;
        
        CGFloat w = [UIScreen mainScreen].bounds.size.width / 3;
        
        button.frame = CGRectMake(w*i+30, 9, 23, 19);
        [self.editorBar addSubview:button];
        
        if (i == 5) {
            button.hidden = YES;
            CGRect f = button.frame;
            f.origin.x -= w;
            button.frame = f;
        }
        [_buttons addObject:button];
    }
    
}
#pragma mark - 键盘上方bar
- (void)buttonAction:(UIButton *)button
{
    
    if (button.tag == 30) {
        _sendTextView.text = [NSString stringWithFormat:@"%@##",_sendTextView.text];
        NSRange range = _sendTextView.selectedRange;
        range.location -= 1;
        _sendTextView.selectedRange = range;
    }
    if (button.tag == 31) {
        _sendTextView.text = [NSString stringWithFormat:@"%@@",_sendTextView.text];
    }
    if (button.tag == 32) {
        
    }
    
}
#pragma mark - 监听键盘将要弹出
- (void)keyboaedShowNotification:(NSNotification *)notification
{
    NSValue *keyboardValue = [notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey];
    CGRect frame = [keyboardValue CGRectValue];
    CGFloat keyboardHight = frame.size.height;
    
    self.editorBar.bottom = [UIScreen mainScreen].bounds.size.height - keyboardHight;
    self.sendTextView.height = self.editorBar.top;
}
#pragma mark - 发微博
- (void)sentAction
{
    NSString *text = self.sendTextView.text;
    if (text.length > 140) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"内容大于140字!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    if (text.length == 0) {
        UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"提示" message:@"评论内容为空!" delegate:nil cancelButtonTitle:@"确定" otherButtonTitles:nil];
        [alert show];
        return;
    }
    [self dismissViewControllerAnimated:YES completion:nil];
    [super showStatuxsTip:YES title:@"评论中..."];
    NSString *ID = [NSString stringWithFormat:@"%lld",_status.ID];
    NSMutableDictionary *params = [NSMutableDictionary dictionaryWithCapacity:3];
    [params setObject:text forKey:@"comment"];
    [params setObject:ID forKey:@"id"];
        [HttpTool wbHttpRequest:@"comments/create.json" httpMethod:@"POST" params:params hander:^(WBHttpRequest *request, id result, NSError *error) {
            if (!error) {
                [super showStatuxsTip:NO title:@"评论成功"];
    
            }else{
                [super showStatuxsTip:NO title:@"发送失败"];
            }
        }];
    
}
@end
