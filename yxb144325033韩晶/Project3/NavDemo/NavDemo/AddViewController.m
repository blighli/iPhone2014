//
//  AddViewController.m
//  NavDemo
//
//  Created by hanxue on 14/11/17.
//  Copyright (c) 2014年 hanxue. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
{
    UITextView *textview;
    UIButton *imageBtn0;
    UIButton *imageBtn1;
    UIButton *imageBtn2;
    UIButton *imageBtn3;
    UIImage *image;
    NSString *lastChosenMediaType;
    BOOL isHave;
    NSInteger ImageFlag;
}
@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.title=@"New";
    CGRect textFrame=CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height-200);
    textview=[[UITextView alloc] initWithFrame:textFrame];
    textview.delegate=self;
    textview.backgroundColor=[UIColor blackColor];
    textview.textColor=[UIColor whiteColor];
    textview.font=[UIFont fontWithName:@"Arial" size:18.0];
    textview.scrollEnabled=YES;
    [self.view addSubview:textview];
    
    UIBarButtonItem *rightButton=[[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(cameraBtn:)];
    
    
    NSMutableArray *buttons=[[NSMutableArray alloc]initWithCapacity:2];
    [buttons addObject:rightButton];
    [self.navigationItem setRightBarButtonItems:buttons animated:YES];
    
    imageBtn0=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame0=CGRectMake(0, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn0.hidden=YES;
    [imageBtn0 setTag:1];
    [imageBtn0 setFrame:imageFrame0];
    [imageBtn0 setBackgroundColor:[UIColor blueColor]];
    [imageBtn0 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn0 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn0];
    
    imageBtn1=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame1=CGRectMake(self.view.frame.size.width/4, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn1.hidden=YES;
    [imageBtn1 setTag:2];
    [imageBtn1 setFrame:imageFrame1];
    [imageBtn1 setBackgroundColor:[UIColor redColor]];
    [imageBtn1 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn1 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn1];
    
    imageBtn2=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame2=CGRectMake(self.view.frame.size.width/2, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn2.hidden=YES;
    [imageBtn2 setTag:3];
    [imageBtn2 setFrame:imageFrame2];
    [imageBtn2 setBackgroundColor:[UIColor greenColor]];
    [imageBtn2 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn2 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn2];
    
    imageBtn3=[UIButton buttonWithType:UIButtonTypeRoundedRect];
    CGRect imageFrame3=CGRectMake(3*self.view.frame.size.width/4, self.view.frame.size.height-200, self.view.frame.size.width/4, self.view.frame.size.width/4);
    imageBtn3.hidden=YES;
    [imageBtn3 setTag:4];
    [imageBtn3 setFrame:imageFrame3];
    [imageBtn3 setBackgroundColor:[UIColor orangeColor]];
    [imageBtn3 setTitle:@"" forState:UIControlStateNormal];
    [imageBtn3 addTarget:self action:@selector(imageBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:imageBtn3];
    
    if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
        isHave=true;
    }else{
        isHave=false;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self updateDisplay];
}
-(void)updateDisplay{
    
    if (ImageFlag&&ImageFlag>=0) {
        switch (ImageFlag) {
            case 0:
                [imageBtn0 setBackgroundImage:image forState:UIControlStateNormal];
                break;
            case 1:
                [imageBtn1 setBackgroundImage:image forState:UIControlStateNormal];
                break;
            case 2:
                [imageBtn2 setBackgroundImage:image forState:UIControlStateNormal];
                break;
            case 3:
                [imageBtn3 setBackgroundImage:image forState:UIControlStateNormal];
                break;
            default:
                break;
        }
    }
}

-(void)imageBtn:(id)sender{
    NSLog(@"%ld",(long)[sender tag]);
    switch ([sender tag]) {
        case 1:
            
            break;
        case 2:
            
            break;
        case 3:
            
            break;
        case 4:
            
            break;
        default:
            break;
    }
}

-(void)showImageBtn{
    if (imageBtn0.hidden) {
        imageBtn0.hidden=NO;
        ImageFlag=0;
    }else if(imageBtn1.hidden){
        imageBtn1.hidden=NO;
        ImageFlag=1;
    }else if(imageBtn2.hidden){
        imageBtn2.hidden=NO;
        ImageFlag=2;
    }else if(imageBtn3.hidden){
        imageBtn3.hidden=NO;
        ImageFlag=3;
    }else{
        
    }
}


-(void)cameraBtn:(id)sender{
    
    UIActionSheet *sheet=[[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:@"New Photo",@"From Library", nil];
    sheet.actionSheetStyle=UIActionSheetStyleDefault;
    [sheet showInView:self.view];
}

-(void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    switch (buttonIndex) {
        case 0:
            if (isHave) {
                [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
            }
            break;
        case 1:
            [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        default:
            break;
    }
}



-(void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType{
    NSArray *mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType]&&[mediaTypes count]>0) {
        NSArray *mediaTypes=[UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker=[[UIImagePickerController alloc] init];
        picker.mediaTypes=mediaTypes;
        picker.delegate=self;
        picker.allowsEditing=YES;
        picker.sourceType=sourceType;
        [self presentViewController:picker animated:YES completion:NULL];
    }else{
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:@"Error" message:@"Device" delegate:nil cancelButtonTitle:@"Dratl" otherButtonTitles: nil];
        [alert show];
    }
}

-(UIImage *)shrinkImage:(UIImage *)original toSize:(CGSize)size{
    UIGraphicsBeginImageContextWithOptions(size, YES, 0);
    [original drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *final=UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return final;
}

-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info{
    lastChosenMediaType=info[UIImagePickerControllerMediaType];
    UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
    UIImage *shrunkenImage=[self shrinkImage:chosenImage toSize:CGSizeMake(self.view.frame.size.width/4, self.view.frame.size.width/4)];
    image=shrunkenImage;
    [picker dismissViewControllerAnimated:YES completion:NULL];
    [self showImageBtn];
}
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:NULL];
    ImageFlag=-1;
}
@end
