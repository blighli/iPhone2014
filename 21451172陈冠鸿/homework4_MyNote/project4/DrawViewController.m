//
//  DrawViewController.m
//  project4
//
//  Created by Chen.D.Guanhong on 14/11/23.
//  Copyright (c) 2014年 zju-cst. All rights reserved.
//

#import "DrawViewController.h"
#import "DrawView.h"
#import "ImageUtils.h"
#import "Note.h"
#import "TextViewController.h"

@interface DrawViewController ()
@property (strong, nonatomic) DrawView *drawView;
@end

@implementation DrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGRect viewFrame = CGRectMake(0, 105, 375, 520);
    self.drawView = [[DrawView alloc]initWithFrame:viewFrame];
    [self.drawView setBackgroundColor:[UIColor redColor]];
    [self.view addSubview: self.drawView];
    [self.view sendSubviewToBack:self.drawView];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)save:(id)sender {
    for (int i=1; i<16;i++) {
        UIView *view=[self.view viewWithTag:i];
        if ((i>=1&&i<=5)||(i>=10&&i<=15)) {
            if (view.hidden==YES) {
                continue;
            }
        }
        view.hidden=YES;
    }
    UIGraphicsBeginImageContext(self.view.bounds.size);
    [self.view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    UIImageWriteToSavedPhotosAlbum(image, self, @selector(image:didFinishSavingWithError:contextInfo:), nil);
    for (int i=1; i<16; i++) {
        if ((i>=1&&i<=5)||(i>=11&&i<=14)) {
            continue;
        }
        UIView *view=[self.view viewWithTag:i];
        view.hidden=NO;
    }
}

- (IBAction)clear:(id)sender {
    [self.drawView clear];
}

- (void)image:(UIImage *)image didFinishSavingWithError:(NSError *)error
  contextInfo:(void *)contextInfo{
    if (error != NULL){
        //失败
        //截屏成功
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"Error" message:@"Save Error" delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:@"Cancel", nil];
        [alertView show];
    }
    else{
        //成功
        NSString *imageName = [NSString stringWithFormat:@"%d.png", (int)[[NSDate date] timeIntervalSince1970]];
        NSString *imagePath = [ImageUtils saveImage:image WithName:imageName];
        NSLog(@"imagePath : %@", imagePath);
        Note *newNote = [[Note alloc]init];
        newNote.title = @"绘图";
        newNote.content = @"";
        newNote.type = @"draw";
        newNote.imagePath = imagePath;
        [newNote add];
//        [self performSegueWithIdentifier:@"addNote" sender:self];
        
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqual:@"addNote"]) {
        Note *newNote = [[Note alloc]init];
        newNote.imagePath = self.imagePath;
        TextViewController *textVC = [segue destinationViewController];
        textVC.note = newNote;
    }
}
*/

@end
