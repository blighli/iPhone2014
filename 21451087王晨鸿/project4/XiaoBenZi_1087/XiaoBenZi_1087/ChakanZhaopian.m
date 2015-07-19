//
//  ChakanZhaopian.m
//  XiaoBenZi_1087
//
//  Created by qtsh on 14-11-22.
//  Copyright (c) 2014年 QTSH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ChakanZhaopian.h"
#import <MediaPlayer/MediaPlayer.h>
#import "Constants.h"
#import "MySqlite3DbHelper.h"
#import <MobileCoreServices/UTCoreTypes.h>
@implementation ChakanZhaopian

-(void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    if (![UIImagePickerController isSourceTypeAvailable:
          UIImagePickerControllerSourceTypeCamera])
    {
        takePictureButton.hidden = YES;
    }
    
    if ([Constants getWhoPastit] == 0) {//查看
        takePictureButton.hidden = YES;
        saveButton .hidden =YES;
        
        NSString *aPath3=[NSString stringWithFormat:@"%@",[Constants getPastOnePiece].info];
        NSLog(@"FULLNAME:%@",aPath3);
        UIImage *imgFromUrl3=[[UIImage alloc]initWithContentsOfFile:aPath3];
        [imageView setImage:imgFromUrl3];
        
    }
    else//新建
    {
        deleteButton.hidden =YES;
    }

}

- (IBAction)shootPictureOrVideo:(id)sender
{
    [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
}
-(IBAction)save:(id)sender
{
    //保存内容到数据库
    //设置要插入的内容
    OnePiece * piece = [[OnePiece alloc] init];
    [piece setValue:[titleField text] forKey:@"title"];
    [piece setValue:@"1" forKey:@"type"];
    [piece setValue:@"temp" forKey:@"info"];
    
    
    NSString *insertSql = [NSString stringWithFormat:@"insert into contents(title,type,info) values(\"%@\",\"%@\",\"%@\")",[piece valueForKey:@"title"],[piece valueForKey:@"type"],[piece valueForKey:@"info"]];
    BOOL res = [MySqlite3DbHelper execSql:insertSql database:@"XiaoBenZi_1087.db"];
    if( NO == res )
    {
        NSLog(@"fail!");
    }
    else
    {
        NSLog(@"succeed!");
        //获取last_insert_id()，修改数据库中info
        NSInteger last = [MySqlite3DbHelper queryOneNSIntegerSql:@"select max(id) from contents" database:@"XiaoBenZi_1087.db"];
        NSString *name = [NSString stringWithFormat:@"%d_zhaopian.jpeg",last];
        NSString *fullPath = [MySqlite3DbHelper dbPathforDbName:name];
        NSString *updateSql = [NSString stringWithFormat:@"update contents set info =\"%@\" where id = \"%d\" ",fullPath,last];
        BOOL res = [MySqlite3DbHelper execSql:updateSql database:@"XiaoBenZi_1087.db"];
        if( NO == res )
        {
            NSLog(@"fail!");
        }
        else
        {
            //update成功则保存图片
            [UIImagePNGRepresentation(image) writeToFile:fullPath atomically:NO];
            [UIImageJPEGRepresentation(image, 1) writeToFile:fullPath atomically:NO];
        }
        
        //保存文件到沙盒sandbox，命名规则：id_zhaopian.jpeg
    }

}
-(IBAction)delete:(id)sender
{
    //从沙盒中删除图片
    NSFileManager* fileManager=[NSFileManager defaultManager];
    //文件名
    NSString *uniquePath=[Constants getPastOnePiece].info;
    BOOL blHave=[[NSFileManager defaultManager] fileExistsAtPath:uniquePath];
    if (!blHave) {
        NSLog(@"no  have");
    }else {
        NSLog(@" have");
        BOOL blDele= [fileManager removeItemAtPath:uniquePath error:nil];
        if (blDele) {
            NSLog(@"dele success");
            
            
            
        }else {
            NSLog(@"dele fail");
        }
        
    }
    
    //从数据库中删除图片
    NSString *deleteSql = [NSString stringWithFormat:@"delete from contents where id=\"%d\"",[Constants getPastOnePiece].iD];
    BOOL res = [MySqlite3DbHelper execSql:deleteSql database:@"XiaoBenZi_1087.db"];
    if( NO == res )
    {
        NSLog(@"fail!");
    }
    else
    {
        NSLog(@"succeed!");
    }

}
- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController
                           availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController
         isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0) {
        NSArray *mediaTypes = [UIImagePickerController
                               availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    } else {
        UIAlertView *alert =
        [[UIAlertView alloc] initWithTitle:@"Error accessing media"
                                   message:@"Unsupported media source."
                                  delegate:nil
                         cancelButtonTitle:@"Drat!"
                         otherButtonTitles:nil];
        [alert show];
    }
}

- (UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    
    CGFloat originalAspect = original.size.width / original.size.height;
    CGFloat targetAspect = size.width / size.height;
    CGRect targetRect;
    
    if (originalAspect > targetAspect) {
        // original is wider than target
        targetRect.size.width = size.width;
        targetRect.size.height = size.height * targetAspect / originalAspect;
        targetRect.origin.x = 0;
        targetRect.origin.y = (size.height - targetRect.size.height) * 0.5;
    } else if (originalAspect < targetAspect) {
        // original is narrower than target
        targetRect.size.width = size.width * originalAspect / targetAspect;
        targetRect.size.height = size.height;
        targetRect.origin.x = (size.width - targetRect.size.width) * 0.5;
        targetRect.origin.y = 0;
    } else {
        // original and target have same aspect ratio
        targetRect = CGRectMake(0, 0, size.width, size.height);
    }
    
    [original drawInRect:targetRect];
    UIImage *final = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return final;
}

#pragma mark - Image Picker Controller delegate methods
- (void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:chosenImage
                                toSize:imageView.bounds.size];
    } else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]) {
        self.movieURL = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)updateDisplay
{
    if ([_lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        imageView.image = image;
        imageView.hidden = NO;
        _moviePlayerController.view.hidden = YES;
    } else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]) {
        [_moviePlayerController.view removeFromSuperview];
        _moviePlayerController = [[MPMoviePlayerController alloc]
                                      initWithContentURL:self.movieURL];
        [self.moviePlayerController play];
        UIView *movieView = self.moviePlayerController.view;
        movieView.frame = imageView.frame;
        movieView.clipsToBounds = YES;
        [self.view addSubview:movieView];
        imageView.hidden = YES;
    }
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self updateDisplay];
}
@end