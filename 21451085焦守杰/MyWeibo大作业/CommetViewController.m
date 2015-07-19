//
//  CommetViewController.m
//  MyWeibo
//
//  Created by 焦守杰 on 14/12/3.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "CommetViewController.h"
#import "Comment.h"
@interface CommetViewController ()
@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation CommetViewController
@synthesize id;
//@synthesize accessToken;

- (IBAction)clickConfirmButton:(id)sender {
    NSString *com=self.textView.text;
    NSString *encode=[com stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    Comment *comment=[[Comment alloc]init];
    comment.id=id;
    comment.comment=encode;
//    NSLog(@"%@",encode);
    [NSThread detachNewThreadSelector:@selector(postComment:) toTarget:_weibo withObject:comment];
    [self.navigationController popViewControllerAnimated:YES];
}



- (void)viewDidLoad {
    [super viewDidLoad];
    _weibo=[Weibo getInstance];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


@end
