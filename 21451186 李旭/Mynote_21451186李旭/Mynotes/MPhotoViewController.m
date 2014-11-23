//
//  MPhotoViewController.m
//  Mynotes
//
//  Created by lixu on 14/11/15.
//  Copyright (c) 2014年 lixu. All rights reserved.
//

#import "MPhotoViewController.h"

@interface MPhotoViewController ()
@property (weak, nonatomic) IBOutlet UIImageView *imageView;
- (IBAction)chooseImage:(id)sender;
- (IBAction)saveImage:(id)sender;

@end

@implementation MPhotoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self showActionSheet];
}
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{   UIImagePickerController * imagePicker=[[UIImagePickerController alloc] init];
    imagePicker.delegate=self;
    if (buttonIndex == 0) {
        //打开摄像头
        imagePicker.sourceType=UIImagePickerControllerSourceTypeCamera;
        [self presentViewController:imagePicker animated:YES completion:nil];
    }else if (buttonIndex == 1){
        //打开相册
        imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
        [self presentViewController:imagePicker animated:YES completion:nil];
    };

}

-(void) imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    [self dismissViewControllerAnimated:YES completion:nil];
    UIImage* chosenImage=info[UIImagePickerControllerOriginalImage];
    _imageView.image=chosenImage;
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

- (IBAction)chooseImage:(id)sender {
    [self showActionSheet];

}

- (IBAction)saveImage:(id)sender {
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"名称" message:@"请输入想要保存的名称" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        alert.alertViewStyle=UIAlertViewStylePlainTextInput;
        [alert show];
    }
    
    -(void) alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
    {
        NSLog(@"+++++++这是MPHOTO,alertview+++++++++++++");
        UITextField *textfield=[alertView textFieldAtIndex:0];
        NSString *sendName=textfield.text;
        NSString* imagePath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),sendName];
        if (buttonIndex==1) {
            NSData *data=UIImageJPEGRepresentation(_imageView.image, 0);
            [data writeToFile:imagePath atomically:YES];
            NSString* name=[sendName stringByAppendingString:@"----图片"];
            _dbAcess=[[MDBAccess alloc] init];
            [_dbAcess initializeDatabase];
            [_dbAcess createTable];
            [_dbAcess saveDatas:imagePath Type:1 NibName:name];
            
            [_dbAcess closeDatabase];
        }
    }


-(void) showActionSheet{
    UIActionSheet *actionSheet=[[UIActionSheet alloc] initWithTitle:@"设置图片" delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拍照" otherButtonTitles:@"选取照片", nil];
    actionSheet.actionSheetStyle=UIActionSheetStyleDefault;
    [actionSheet showInView:self.view];

    
}

@end
