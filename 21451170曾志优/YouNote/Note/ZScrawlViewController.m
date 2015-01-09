//
//  ZScrawlViewController.m
//  Note
//
//  Created by Mac on 14-11-23.
//  Copyright (c) 2014年 Mac. All rights reserved.
//

#import "ZScrawlViewController.h"
#import "DBHelper.h"
#import "Scrawl.h"


@implementation ZScrawlViewController


- (void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    if (![_topic isExclusiveTouch]) {
        [_topic resignFirstResponder];
    }
 
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    NSLog(@"viewDidLoad");
    [super viewDidLoad];
    
    self.topic.text=self.paramTopic;
    
    _imageView.frame=CGRectMake(0, 0,self.myCrawl.frame.size.width, self.myCrawl.frame.size.height);
    [self.myCrawl addSubview:_imageView];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)setDetailItem:(id)scrawl
{
    
    NSLog(@"setDetailItem");
    Scrawl *noteScrawl =(Scrawl *)scrawl;
    self.paramTopic=noteScrawl.topicStr;
    self.binScrawl = noteScrawl.binScrawl;
    
    UIImage *image =[UIImage imageWithData:self.binScrawl];
  
    _imageView = [[UIImageView alloc] initWithImage:image];
    
}

-(UIImage *)CaptureImageWithView:(UIView *)view
{
    //1.创建bitmap图形上下文
    UIGraphicsBeginImageContext(view.frame.size);
    //2.将要保存的view的layer绘制到bitmap图形上下文中
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    //3.取出绘制好的图片
    UIImage *newImage=UIGraphicsGetImageFromCurrentImageContext();
    //4.返回获取的图片
    return newImage;
}


- (void)saveImageToPhotos:(UIImage*)savedImage
{
    UIImageWriteToSavedPhotosAlbum(savedImage, self, @selector(image:didFinishSavingWithError:contextInfo:), NULL);
}
// 指定回调方法
- (void)image: (UIImage *) image didFinishSavingWithError: (NSError *) error contextInfo: (void *) contextInfo
{
    NSString *msg = nil ;
    if(error != NULL){
        msg = @"保存图片失败" ;
    }else{
        msg = @"保存图片成功" ;
    }
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"保存图片结果提示"
                                                    message:msg
                                                   delegate:self
                                          cancelButtonTitle:@"确定"
                                          otherButtonTitles:nil];
    [alert show];
}


 


- (IBAction)saveButtonPressed:(UIButton *)sender {
    
    NSString *topicStr=self.topic.text;
    UIImage *image =[self CaptureImageWithView:self.myCrawl];
   
   // UIImage *image2 = [UIImage imageNamed:@"test.jpg"];
  //  [self saveImageToPhotos:image2];
    
    NSData *imageData;
    if (UIImagePNGRepresentation(image) == nil) {
       imageData = UIImageJPEGRepresentation(image, 1);
    } else {
       imageData = UIImagePNGRepresentation(image);
    }
    
    sqlite3 *database = [DBHelper getDatabase];
    
    NSString *insertSQL = @"insert into scrawl(topic,binScrawl) values(?,?)";
    sqlite3_stmt *statement;
    char *errorMsg;
    
    if(sqlite3_prepare_v2(database, [insertSQL UTF8String], -1,&statement, nil)==SQLITE_OK){
        sqlite3_bind_text(statement,1,[topicStr UTF8String],-1,NULL);
        sqlite3_bind_blob(statement,2,[imageData bytes],[imageData length],NULL);
        
    }
    if(sqlite3_step(statement)!=SQLITE_DONE){
        NSAssert(0,@"Error inserting table : %s",errorMsg);
    }
    sqlite3_finalize(statement);
    [DBHelper closeDatabase:database];
  
    
}
@end
