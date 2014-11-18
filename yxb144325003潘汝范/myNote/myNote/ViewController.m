//
//  ViewController.m
//  mynote
//
//  Created by Van on 14/11/16.
//  Copyright (c) 2014年 Van. All rights reserved.
//

#import "ViewController.h"
#import <MobileCoreServices/UTCoreTypes.h>
#import "Notes.h"

@interface ViewController (){
    CGPoint point;
}
@end

@implementation ViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.isEdit = NO;
    if (self.note!=nil) {
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *Directory = [documentsDirectory stringByAppendingPathComponent:@"notesData"];
        NSString *path = [Directory stringByAppendingPathComponent:self.note.fileName];
        NSLog(@"path is %@",path);
        NSString *str=[[NSString alloc] initWithContentsOfFile:path];
        NSLog(@"%@",str);
        [self.webview loadHTMLString:str baseURL:nil];

        self.isEdit = YES;
    }else{
        self.isEdit = NO;
        NSBundle *bundle = [NSBundle mainBundle];
        NSURL *indexFileURL = [bundle URLForResource:@"index" withExtension:@"html"];
        [self.webview loadRequest:[NSURLRequest requestWithURL:indexFileURL]];
    }
   
    self.webview.keyboardDisplayRequiresUserAction = NO;
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    UITapGestureRecognizer* singleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    [self.view addGestureRecognizer:singleTap];
    singleTap.delegate = self;
    singleTap.cancelsTouchesInView = NO;
    self.webview.scrollView.scrollEnabled = YES;
    self.navigationitem.title = @"新建笔记";
    self.myDelegate = [[UIApplication sharedApplication] delegate];
    self.managedObjectContext = [ self.myDelegate managedObjectContext];
}
- (void)viewDidDisappear:(BOOL)animated{
    if(self.v&&self.toolBar){
        [self.toolBar removeFromSuperview];
    }
    self.v =nil;
    self.toolBar = nil;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Build toolbar

- (void)keyboardWillShow:(NSNotification *)note {
    [self performSelector:@selector(buildCustomToolbar) withObject:nil afterDelay:0];
}

- (void) buildCustomToolbar{
    // Locate non-UIWindow.
    
    UIWindow *keyboardWindow = nil;
    UIView* toolBarContainer = nil;
    NSArray* windows = [[UIApplication sharedApplication] windows];
    for (UIWindow *possibleWindow in windows) {
        if (![[possibleWindow class] isEqual:[UIWindow class]]) {
            keyboardWindow = possibleWindow;
            break;
        }
    }
    CGRect frm = keyboardWindow.frame;
    CGRect toolbarFrame = CGRectMake(0.0f, frm.size.height, frm.size.width, 44.0f);
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    // Locate UIWebFormView.
    for (UIView *possibleFormView in [keyboardWindow subviews])
    {
        if(version >= 8.0){
            if([[possibleFormView description] hasPrefix:@"<UIInputSetContainerView"])
            {
                for(int i = 0 ; i < [possibleFormView.subviews count] ; i++)
                {
                    UIView* hostkeyboard = [possibleFormView.subviews objectAtIndex:i];
                    if([[hostkeyboard description] hasPrefix:@"<UIInputSetHostView"])
                    {
                        for (id temp in hostkeyboard.subviews)
                        {
                            if ([[temp description] hasPrefix:@"<UIWebFormAccessory"])
                            {
                                UIView* currentToolBar = (UIView*)temp;
                                currentToolBar.hidden = true;
                                toolbarFrame = currentToolBar.frame;
                                toolBarContainer = hostkeyboard;
                            }
                        }
                    }
                }
            }
        }else{
            if ([[possibleFormView description] rangeOfString:@"UIPeripheralHostView"].location != NSNotFound) {
                for (UIView *subviewWhichIsPossibleFormView in [possibleFormView subviews]) {
                    if ([[subviewWhichIsPossibleFormView description] rangeOfString:@"UIWebFormAccessory"].location != NSNotFound) {
                        [subviewWhichIsPossibleFormView removeFromSuperview];
                    }
                }
            }
        }
        
    }
    self.toolBar = [[UIToolbar alloc] initWithFrame:toolbarFrame];
    NSMutableArray *items = [[NSMutableArray alloc] init];
    UIBarButtonItem *FlexibleSpace = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    [items addObject:FlexibleSpace];
    UIBarButtonItem *Bold =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"bold.png"] style:UIBarButtonItemStylePlain target:self action:@selector(bold)];
    [items addObject:Bold];
    UIBarButtonItem *Italic =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"italic.png"]style:UIBarButtonItemStylePlain target:self action:@selector(italic)];
    [items addObject:Italic];
    UIBarButtonItem *Underline =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"underline.png"]style:UIBarButtonItemStylePlain target:self action:@selector(underline)];
    [items addObject:Underline];
    UIBarButtonItem *Image =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"image.png"]style:UIBarButtonItemStylePlain target:self action:@selector(selectPhoto)];
     [items addObject:Image];
    UIBarButtonItem *Camera =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"camera.png"]style:UIBarButtonItemStylePlain target:self action:@selector(camera)];
   
    [items addObject:Camera];
    UIBarButtonItem *Undo =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"undo"]style:UIBarButtonItemStylePlain target:self action:@selector(undo)];
    [items addObject:Undo];
    UIBarButtonItem *Redo =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"redo"]style:UIBarButtonItemStylePlain target:self action:@selector(redo)];
    [items addObject:Redo];
    UIBarButtonItem *KeyboardDown =[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"keyboard.png"]style:UIBarButtonItemStylePlain target:self action:@selector(dismissKeyboard)];
    [items addObject:KeyboardDown];
    [items addObject:FlexibleSpace];

    self.toolBar.items = [NSArray arrayWithArray:items];
    if(toolBarContainer){
        [toolBarContainer addSubview:self.toolBar];
    }else{
        [keyboardWindow addSubview:self.toolBar];
        
        [UIView animateWithDuration:0.25 animations:^{
            self.toolBar.frame = CGRectMake(0.0f, 220.0f, toolbarFrame.size.width, toolbarFrame.size.height);
        }];
        
        self.toolBar.frame = CGRectMake(0.0f, 0.0f, 320.0, 44.0f);
        
        self.v = [[keyboardWindow subviews] objectAtIndex:0];
        [self.v addSubview:self.toolBar];
    }
    
    
    keyboardWindow = nil;
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer{
    return YES;
}
-(void)handleSingleTap:(UITapGestureRecognizer *)sender{
    point = [sender locationInView:self.view];
    NSLog(@"handleSingleTap!pointx:%f,y:%f",point.x,point.y);
    [self.webview
     stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('body')[0].focus()"];
}
#pragma mark B/I/U

- (void)bold {
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Bold\")"];
}

- (void)italic {
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Italic\")"];
}

- (void)underline {
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.execCommand(\"Underline\")"];
}
#pragma mark dismissKeyBoard

- (void)dismissKeyboard {
    [self.webview endEditing:YES];
}
#pragma mark Undo/Redo

- (void)undo {
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.execCommand('undo')"];
}

- (void)redo {
    [self.webview stringByEvaluatingJavaScriptFromString:@"document.execCommand('redo')"];
}

- (IBAction)SaveNote:(id)sender {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSString *Directory = [documentsDirectory stringByAppendingPathComponent:@"notesData"];
    NSDate *localDate = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];
    NSString *fileName = [timeSp stringByAppendingString:@".html"];
    NSString *Path = [Directory stringByAppendingPathComponent:fileName];
    [fileManager createDirectoryAtPath:Directory withIntermediateDirectories:YES attributes:nil error:nil];    
    NSString *html = [self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    if (self.isEdit) {
        NSString *Path2 = [Directory stringByAppendingPathComponent:self.note.fileName];
        [fileManager createFileAtPath:Path2 contents:[html  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }else{
        [fileManager createFileAtPath:Path contents:[html  dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
//        NSLog(@"%@",html);
        if(self.managedObjectContext != nil){
            Notes *note = (Notes *)[NSEntityDescription insertNewObjectForEntityForName:@"Notes" inManagedObjectContext:self.managedObjectContext];
            [note setFileName:fileName];
            NSManagedObjectID *moID = [note objectID];
            NSString *identifier=[moID.URIRepresentation absoluteString];
            [note setId:identifier];
            NSError *error;
            //托管对象准备好后，调用托管对象上下文的save方法将数据写入数据库
            BOOL isSaveSuccess = [self.managedObjectContext save:&error];
            if (!isSaveSuccess) {
                //NSLog(@"Error: %@,%@",error,[error userInfo]);
            }else {
                //NSLog(@"Save successful!");
            }
        }else{
            NSLog(@"空指针");
        }

    }
    [[NSNotificationCenter defaultCenter] postNotificationName:@"saveChange" object:self];
    [self dismissViewControllerAnimated:YES completion:nil];
   
}
- (void) camera{
    NSLog(@"camera is click");
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    if ([self isCameraAvailable]&& [self doesCameraSupportTakingPhotos]){
        [controller setSourceType:UIImagePickerControllerSourceTypeCamera];// 设置类型
        if ([self canUserPickPhotosFromPhotoLibrary]){
            [mediaTypes addObject:(NSString *)kUTTypeImage];
            NSLog(@"before");
        }
    }
    [controller setMediaTypes:mediaTypes];
    [controller setDelegate:self];
    [self presentViewController:controller animated:YES completion:nil];
}

#pragma mark select photo from photolibrary
- (void) selectPhoto{
    UIImagePickerController *controller = [[UIImagePickerController alloc] init];
    NSMutableArray *mediaTypes = [[NSMutableArray alloc] init];
    if ([self isPhotoLibraryAvailable] && [self canUserPickPhotosFromPhotoLibrary]){
        [controller setSourceType:UIImagePickerControllerSourceTypePhotoLibrary];// 设置类型
        if ([self canUserPickPhotosFromPhotoLibrary]){
            [mediaTypes addObject:(NSString *)kUTTypeImage];
            NSLog(@"before");
        }
    }
    [controller setMediaTypes:mediaTypes];
    [controller setDelegate:self];
    [self presentViewController:controller animated:YES completion:nil];
    
    
}
#pragma mark iamgepicker callback
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info {
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSDate *localDate = [NSDate date];
    NSString *timeSp = [NSString stringWithFormat:@"%ld", (long)[localDate timeIntervalSince1970]];
    NSString *prefix =@"Photo_";
    NSString *imageName =[[prefix stringByAppendingString:timeSp] stringByAppendingString:@".png"];
    NSString *imagePath = [documentsDirectory stringByAppendingPathComponent:imageName];
    NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
    if ([mediaType isEqualToString:@"public.image"]){
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        NSData *data = UIImagePNGRepresentation(image);
        [data writeToFile:imagePath atomically:YES];
    }
    [self.webview stringByEvaluatingJavaScriptFromString:@"placeCaretAtEnd(document.getElementById('content'))"];
    NSLog(@"调用图片 路径是 %@",imagePath);
   // NSString *javascript = [NSString stringWithFormat:@"moveImageAtTo(%f, %f,'%@')",point.x,point.y,imagePath];
    //[self.webview stringByEvaluatingJavaScriptFromString:javascript];
    //[self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementById('content').focus()"];
    [self.webview stringByEvaluatingJavaScriptFromString:[NSString stringWithFormat:@"document.execCommand('insertImage', false, '%@')", imagePath]];
    [picker dismissViewControllerAnimated:YES completion:nil];
}
#pragma mark error callback
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
        NSLog(@"Image was saved successfully.");
    } else {
        NSLog(@"An error happened while saving the image.");
        NSLog(@"Error = %@", paramError);
    }
}
#pragma mark cancel callback
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker{
    [picker dismissViewControllerAnimated:YES completion:nil];
}

- (void) getHTML{
    NSString *html = [self.webview stringByEvaluatingJavaScriptFromString:@"document.getElementsByTagName('html')[0].innerHTML"];
    NSLog(@"%@",html);
}

#pragma mark 检查是否有摄像头
- (BOOL) isCameraAvailable{
    return [UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark 检查摄像头是否支持拍照
- (BOOL) doesCameraSupportTakingPhotos{
    return [self cameraSupportsMedia:(NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypeCamera];
}

#pragma mark 检查摄像头支持的媒体格式
- (BOOL) cameraSupportsMedia:(NSString *)paramMediaType sourceType:(UIImagePickerControllerSourceType)paramSourceType{
    __block BOOL result = NO;
    if ([paramMediaType length] == 0){
        NSLog(@"Media type is empty.");
        return NO;
    }
    NSArray *availableMediaTypes =[UIImagePickerController availableMediaTypesForSourceType:paramSourceType];
    [availableMediaTypes enumerateObjectsUsingBlock:^(id obj, NSUInteger idx, BOOL *stop) {
        NSString *mediaType = (NSString *)obj;
        if ([mediaType isEqualToString:paramMediaType]){
            result = YES;
            *stop= YES;
        }
        
    }];
    return result;
}
#pragma mark 检测图库是否可用
- (BOOL) isPhotoLibraryAvailable{
    return [UIImagePickerController isSourceTypeAvailable: UIImagePickerControllerSourceTypePhotoLibrary];
}
#pragma mark 检测是否支持从图库选择图片
- (BOOL) canUserPickPhotosFromPhotoLibrary{
    return [self cameraSupportsMedia:( NSString *)kUTTypeImage sourceType:UIImagePickerControllerSourceTypePhotoLibrary];
}
@end
