//
//  ViewController.m
//  FinalProject
//
//  Created by 李丛笑 on 15/1/4.
//  Copyright (c) 2015年 lcx. All rights reserved.
//

#import "ViewController.h"
#import "DWBubbleMenuButton.h"
#import "DBHelper.h"
#import "SetButton.h"
#import "CourseData.h"
#import "EditViewController.h"
#import <sqlite3.h>
#define kFilename @"data.sqlite3"
#define kTheme_Backgound_Format @"theme_bg_01.png"

@interface ViewController ()

@end

@implementation ViewController
@synthesize backgroundimageView;
@synthesize ttag;
int tableid ;
int buttoncount;
SetButton *stb;
int buttontag=0;
NSString *bgimage = kTheme_Backgound_Format;
UIImage *backgroundimage;

NSMutableDictionary *dic;

- (void)viewDidAppear:(BOOL)animated {
    // Create down menu button
    
    [self loadView];
      tableid = [ttag intValue];
       [self plist];
    [backgroundimageView setImage:backgroundimage];

    stb = [[SetButton alloc]init];
    buttoncount = [stb getButtonCount:tableid];
    UIScrollView *scrollview = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 64, 568, 256)];
    scrollview.contentSize = CGSizeMake(700, 600);
    [self.view addSubview:scrollview];
    [self createItemButton];
    UILabel *homeLabel;
    DWBubbleMenuButton *downMenuButton;
    UIButton *button;
    NSArray *weekdays = @[@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日"];
    UILabel *label;
    for (int i = 0;i<7;i++) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(75+70.f*i, 20.f,70.f,40.f)];
        label.text = [weekdays objectAtIndex:i];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.clipsToBounds = NO;
        [scrollview addSubview:label];
    }
    for (int i = 0; i<buttoncount; i++) {
        label = [[UILabel alloc] initWithFrame:CGRectMake(20.f, 70.f+50.f*i, 40.f,40.f)];
        label.text = [NSString stringWithFormat:@"%d",i+1];
        label.textColor = [UIColor blackColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.clipsToBounds = NO;
        
        [scrollview addSubview:label];
        NSArray *btarray = [self createDemoButtonArray:tableid Classid:i+1];
        for (int j = 0; j<7; j++) {
             [scrollview addSubview:[btarray objectAtIndex:j]];
        }
        
    }
    homeLabel = [self createHomeButtonView:buttoncount+1];
    downMenuButton = [[DWBubbleMenuButton alloc] initWithFrame:CGRectMake(20.f,70+50.f*buttoncount,
                                                                          homeLabel.frame.size.width,
                                                                          homeLabel.frame.size.height)
                                            expansionDirection:DirectionRight];
    downMenuButton.homeButtonView = homeLabel;

    [downMenuButton addButtons:[self createDemoButtonArray:tableid Classid:buttoncount+1]];
    
    [scrollview addSubview:downMenuButton];
   

}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return UIInterfaceOrientationIsLandscape(interfaceOrientation);
}

-(NSArray *)createItemButton{
    NSMutableArray *itembutton = [[NSMutableArray alloc]init];
    UIBarButtonItem *renameButton = [[UIBarButtonItem alloc] initWithTitle:@"名称"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(EditCurriculumTitle:)];
    UIBarButtonItem *themeButton = [[UIBarButtonItem alloc] initWithTitle:@"主题"
                                                                           style:UIBarButtonItemStyleBordered
                                                                          target:self
                                                                          action:@selector(SelectBG:)];
    UIBarButtonItem *deleteButton = [[UIBarButtonItem alloc] initWithTitle:@"删除"
                                                                     style:UIBarButtonItemStyleBordered
                                                                    target:self
                                                                    action:@selector(DeleteTable:)];
    [itembutton addObject:themeButton];
    [itembutton addObject:renameButton];
    [itembutton addObject:deleteButton];
    
    self.navigationItem.rightBarButtonItems = itembutton;
    return itembutton;
}



- (UILabel *)createHomeButtonView:(int)classid{
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0.f, 0.f, 40.f, 40.f)];
    if(classid == buttoncount+1)
        label.text = @"+";
    else label.text = [NSString stringWithFormat:@"%d",classid];
    label.textColor = [UIColor whiteColor];
    label.textAlignment = NSTextAlignmentCenter;
    label.layer.cornerRadius = label.frame.size.height / 2.f;
    label.backgroundColor =[UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
    label.clipsToBounds = NO;
    
    return label;
}

- (NSArray *)createDemoButtonArray :(int)tableid Classid:(int)classid{
    NSMutableArray *buttonsMutable = [[NSMutableArray alloc] init];
    
    int i = 0;
     NSArray *texts = [stb getButtonText:tableid Classid:classid];

    for (NSString *title in texts) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeSystem];
        
        [button setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [button setTitle:title forState:UIControlStateNormal];
        button.frame = CGRectMake(20.f+70.f*(i+1),30.f+50.f*classid, 50.f, 30.f);
        button.backgroundColor = [UIColor colorWithRed:0.f green:0.f blue:0.f alpha:0.5f];
        button.clipsToBounds = NO;
        i++;
        button.tag = i*10+classid;
        
        
        
        [button addTarget:self action:@selector(test:) forControlEvents:UIControlEventTouchUpInside ];
        
        
        [buttonsMutable addObject:button];
    }
    
    return [buttonsMutable copy];
}

//-------------删除课程表ItemButton-------------
-(void)DeleteTable:(UIBarButtonItem *)sender{
    DBHelper *db = [[DBHelper alloc]init];
    UIAlertView *alert3 = [[UIAlertView alloc] initWithTitle:@"删除所有课程?" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
    
    // optional - add more buttons:
    [alert3 addButtonWithTitle:@"确认"];
    [alert3 show];

}

//-------------更改课程表主题---------------
-(void)SelectBG:(UIButton *)sender{
    UIActionSheet* mySheet = [[UIActionSheet alloc]
                              initWithTitle:@"选择背景"
                              delegate:self
                              cancelButtonTitle:@"取消"
                              destructiveButtonTitle:nil
                              otherButtonTitles:@"选择默认主题",@"打开本地相册",@"打开照相机", nil];
    [mySheet showInView:self.view];
}

- (void)actionSheet:(UIActionSheet *)actionSheet didDismissWithButtonIndex:(NSInteger)buttonIndex

{
    if (buttonIndex == 1) {
        NSLog(@"SSS");
    }
    if (buttonIndex == 2) {
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
        picker.delegate = self;
        picker.allowsEditing = YES;
        [self presentModalViewController:picker animated:YES];
    }
    if (buttonIndex == 3) {
        UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
        
        if ([UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypeCamera])
            
        {
            
            UIImagePickerController *picker = [[UIImagePickerController alloc] init];
            
            picker.delegate = self;
            
            //设置拍照后的图片可被编辑
            
            picker.allowsEditing = YES;
            
            picker.sourceType = sourceType;
            
            [self presentModalViewController:picker animated:YES];
            
        }else
            
        {
            
            NSLog(@"模拟其中无法打开照相机,请在真机中使用");
            
        }
        

    }
    
   
}

-(void)imagePickerController:(UIImagePickerController*)picker didFinishPickingMediaWithInfo:(NSDictionary *)info

{
    [picker dismissViewControllerAnimated:YES completion:nil];
    UIImage *image = [info  objectForKey:@"UIImagePickerControllerOriginalImage"];
    backgroundimage = image;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
    [UIImagePNGRepresentation(image)writeToFile: filePath    atomically:YES];
    
    [self dicPaths];
}

-(void)dicPaths
{
    NSMutableArray *specialArr = [[NSMutableArray alloc] initWithCapacity:0];
    
    dic = [[NSMutableDictionary alloc]init];
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
    
    [dic setObject:filePath forKey:@"img"];
    [specialArr addObject:dic];
}

-(void)plist
{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,NSUserDomainMask, YES);
    NSString *filePath = [[paths objectAtIndex:0] stringByAppendingPathComponent:[NSString stringWithFormat:@"pic_100.png"]];   // 保存文件的名称
    UIImage *img = [UIImage imageWithContentsOfFile:filePath];
    backgroundimage = img;
}



- (void)test:(UIButton *)sender{
    NSLog(@"Button tapped, tag: %ld", (long)sender.tag);
    buttontag = (int)sender.tag;
    NSString *showcontent = [stb getButtonInfo:(int)sender.tag Tableid:tableid];
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Really reset?" message:showcontent delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];

    // optional - add more buttons:
    [alert addButtonWithTitle:@"编辑"];
    [alert addButtonWithTitle:@"删除"];

    [alert show];
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if ([alertView.title isEqualToString:@"删除?"]) {
        if (buttonIndex == 1) {
            NSLog(@"执行删除");
            NSString *tid = ttag;
            NSString *did = [NSString stringWithFormat:@"%d",buttontag/10];
            NSString *cid = [NSString stringWithFormat:@"%d",buttontag-(buttontag/10)*10];
            NSMutableString *classid = [[NSMutableString alloc]init];
            [classid appendString:ttag];
            [classid appendString:@" "];
            [classid appendString:did];
            [classid appendString:@" "];
            [classid appendString:cid];
            DBHelper *db = [[DBHelper alloc]init];
            [db CreateDB];
            [db DeleteDB:classid IfByTableid:NO];
            [self viewDidAppear:YES];
        }
    }
    else if([alertView.title isEqualToString:@"删除所有课程?"]){
        if (buttonIndex ==1) {
            NSString *tid = ttag;
            NSMutableString *classid = [[NSMutableString alloc]init];
            [classid appendString:ttag];
            [classid appendString:@"%"];
            DBHelper *db = [[DBHelper alloc]init];
            [db CreateDB];
            [db DeleteDB:classid IfByTableid:YES];
            [self.navigationController popViewControllerAnimated:NO];

        }
    }
    else{
    if (buttonIndex == 1) {
         [self performSegueWithIdentifier:@"toEdit" sender:self];
    }
    if (buttonIndex == 2) {
        UIAlertView *alert2 = [[UIAlertView alloc] initWithTitle:@"删除?" message:@" " delegate:self cancelButtonTitle:@"取消" otherButtonTitles:nil];
        [alert2 addButtonWithTitle:@"确认"];
        [alert2 show];

    }
    }
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UIViewController* view = segue.destinationViewController;
    NSString *btag = [NSString stringWithFormat:@"%d",buttontag];
    NSString *ttagforedit = [NSString stringWithFormat:@"%d",tableid];
    if ([segue.identifier isEqualToString:@"toEdit"]==YES) {
        EditViewController *editview =(EditViewController *)view;
        [editview setValue:btag forKey:@"btag"];
        [editview setValue:ttagforedit forKey:@"ttagforedit"];
    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (BOOL)prefersStatusBarHidden {
    return true;
}


-(void)viewDidUnload

{
    
    [super viewDidUnload];
    
    
}





@end

