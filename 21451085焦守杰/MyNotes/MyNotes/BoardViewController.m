//
//  BoardViewController.m
//  MyNotes
//
//  Created by 焦守杰 on 14/11/23.
//  Copyright (c) 2014年 焦守杰. All rights reserved.
//

#import "BoardViewController.h"
#import "BoardView.h"
#import "DatabaseUtil.h"
@interface BoardViewController (){
    BoardView *_boardView;
    DatabaseUtil *_dbu;
}
- (IBAction)changeSize:(id)sender;
- (IBAction)clickColorButton:(id)sender;
- (IBAction)clickEraserButton:(id)sender;
- (IBAction)clickPenpointButton:(id)sender;
- (IBAction)clickClearButton:(id)sender;
- (IBAction)changeColor:(id)sender;
- (IBAction)clickSaveButton:(id)sender;
@property (weak, nonatomic) IBOutlet UISlider *lengthSlider;
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorBoard;



@end

@implementation BoardViewController
//@synthesize name;
- (void)viewDidLoad {
    [super viewDidLoad];
    _colorBoard.hidden=YES;
    _lengthSlider.hidden=YES;
    _boardView=[[BoardView alloc]initWithFrame:self.view.frame ];
    _boardView.color=0;
    _boardView.size=7;
//    NSLog(@" %d   %d  ",_color,_size);
    if (_name) {
        NSString *aPathImage=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),_name];
        UIImage *imgFromUrl=[[UIImage alloc]initWithContentsOfFile:aPathImage];
        UIColor *bgColor = [UIColor colorWithPatternImage: imgFromUrl];
        [_boardView setBackgroundColor:bgColor];
    } else
        [_boardView setBackgroundColor:[UIColor whiteColor]];

  //  [_boardView setBackgroundColor:[UIColor whiteColor]];
    [self.view addSubview:_boardView];
    [self.view sendSubviewToBack:_boardView];
    _dbu=[[DatabaseUtil alloc]init];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources tha/var/folders/ps/x7j_jkyj4zs3jc0ktwt82r_r0000gn/T/com.evernote.Evernote/com.evernote.Evernote/WebKitDnD.Z7rL7C/76c59154aa38155f3d199c2e7eb5ec7a.jpegt can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)changeSize:(id)sender {
    _boardView.size=(int)round(_lengthSlider.value*19)+1;
    }

- (IBAction)clickColorButton:(id)sender {
    _colorBoard.hidden=NO;
    _lengthSlider.hidden=YES;
}

- (IBAction)clickEraserButton:(id)sender {
    _boardView.color=7;
}

- (IBAction)clickPenpointButton:(id)sender {
 
    _lengthSlider.hidden=!(_lengthSlider.hidden);
    _colorBoard.hidden=YES;
}

- (IBAction)clickClearButton:(id)sender {
    [_boardView clear];
}

- (IBAction)changeColor:(id)sender {
   
    _boardView.color=[_colorBoard selectedSegmentIndex];
    _colorBoard.hidden=YES;
}
- (IBAction)clickSaveButton:(id)sender {
    if(!_name){
        UIAlertView *alertView=[[UIAlertView alloc]initWithTitle:@"保存绘图" message:@"请输入文件名：" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定" , nil];
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
    }else{
        [self savePicWithName:_name andFlag:NO];
    }
}
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==1){
        UITextField *tf=[alertView textFieldAtIndex:0];
        NSString *ss=[tf.text  stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]];
        if(ss.length!=0){
            _name=ss;
            [self savePicWithName:_name andFlag:YES];
        }
        else{
            UIAlertView *alv=[[UIAlertView alloc]initWithTitle:@"提示" message:@"文件名不能为空" delegate:self cancelButtonTitle:@"确定" otherButtonTitles:nil, nil];
       //     alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
            [alv show];
            
        }
    }else if(buttonIndex==0){
        [self clickSaveButton:nil];
    }
}
-(void)savePicWithName:(NSString*)name andFlag:(BOOL)flag{
    UIGraphicsBeginImageContext(_boardView.bounds.size);
    [_boardView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
  
    NSString *aPath=[NSString stringWithFormat:@"%@/Documents/%@",NSHomeDirectory(),name];
    NSData *imgData = UIImageJPEGRepresentation(image,0);
    [imgData writeToFile:aPath atomically:YES];
    if(flag)
        [_dbu saveToDatabase:name withType:@"1"];
   
    NSString *thumbAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail",NSHomeDirectory()];
    if (![[NSFileManager defaultManager] fileExistsAtPath:thumbAPath]) {
        NSFileManager *fileManager = [NSFileManager defaultManager];
        NSString *testDirectory = [documentsDirectory stringByAppendingPathComponent:@"thumbnail"];
    
        [fileManager createDirectoryAtPath:testDirectory withIntermediateDirectories:YES attributes:nil error:nil];
    }

    NSString *thumbSaveAPath = [NSString stringWithFormat:@"%@/Documents/thumbnail/%@",NSHomeDirectory(),name];
    CGSize size = CGSizeMake(40, 40);
    [self createThumbImage:image size:size percent:100 toPath:thumbSaveAPath];
    
  //  [self dismissViewControllerAnimated:YES completion:nil];
}
-(void)createThumbImage:(UIImage *)image size:(CGSize)thumbSize percent:(float)percent toPath:(NSString *)thumbPath
{
    CGSize imageSize = image.size;
    CGFloat width = imageSize.width;
    CGFloat height = imageSize.height;
    CGFloat scaleFactor = 0.0;
    CGPoint thumbPoint = CGPointMake(0.0,0.0);
    CGFloat widthFactor = thumbSize.width / width;
    CGFloat heightFactor = thumbSize.height / height;
    if (widthFactor > heightFactor)  {
        scaleFactor = widthFactor;
    } else {
        scaleFactor = heightFactor;
    }
    
    CGFloat scaledWidth  = width * scaleFactor;
    CGFloat scaledHeight = height * scaleFactor;
    if (widthFactor > heightFactor)
    {
        thumbPoint.y = (thumbSize.height - scaledHeight) * 0.5;
    } else if (widthFactor < heightFactor)
    {
        thumbPoint.x = (thumbSize.width - scaledWidth) * 0.5;
    }
    
    UIGraphicsBeginImageContext(thumbSize);
    CGRect thumbRect = CGRectZero;
    thumbRect.origin = thumbPoint;
    thumbRect.size.width  = scaledWidth;
    thumbRect.size.height = scaledHeight;
    [image drawInRect:thumbRect];
    
    UIImage *thumbImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    NSData *thumbImageData = UIImageJPEGRepresentation(thumbImage, percent);
    [thumbImageData writeToFile:thumbPath atomically:NO];
}
@end
