//
//  ContentViewController.m
//  project4
//
//  Created by zack on 14-11-22.
//  Copyright (c) 2014年 zack. All rights reserved.
//

#import "ContentViewController.h"
#import "ViewController.h"

@interface ContentViewController ()

@end

@implementation ContentViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    Note *note = _notesArray[[_indexPath row]];
    if ([note.type isEqualToString:@"文本"]) {
        _textView.text = note.content;
        _textView.hidden = FALSE;
    } else {
        _imageView.image = [[UIImage alloc]initWithContentsOfFile: note.content];
        _imageView.hidden = FALSE;
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
