//
//  ImageViewController.m
//  Project4-Note
//
//  Created by  ws on 11/23/14.
//  Copyright (c) 2014 ws. All rights reserved.
//

#import "ImageViewController.h"
#import "ViewController.h"
#import "Data.h"

@interface ImageViewController ()

@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    ViewController *nodesListView = (ViewController *)self.delegate;
    if (self.noteIndex != nil) {
       Data* note = [nodesListView.mynotes objectAtIndex:[self.noteIndex integerValue]];
        if ([note.type isEqualToString: Data.IMAGE_TYPE] || [note.type isEqualToString: Data.DRAW_TYPE]) {
            NSLog(@"---%@",note.attribute);
            UIImage* image = [[UIImage alloc]initWithContentsOfFile: note.attribute];
            self.imageView.image = image;
        } else {
            [[[UIAlertView alloc] initWithTitle:@"错误" message:@"非图片信息" delegate:nil cancelButtonTitle:@"确认" otherButtonTitles:nil, nil] show];
        }
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
