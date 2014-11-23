//
//  detailViewController.m
//  Note
//
//  Created by HJ on 14/11/15.
//  Copyright (c) 2014年 cstlab.hj.NOTE. All rights reserved.
//

#import "detailViewController.h"
#import "SqliteManage.h"
#import <MediaPlayer/MediaPlayer.h>
#import <MobileCoreServices/UTCoreTypes.h>

#import "PaintViewControlly.h"

@interface detailViewController() <UITextViewDelegate, UITableViewDelegate, UITableViewDataSource, UIActionSheetDelegate ,UIImagePickerControllerDelegate, UINavigationControllerDelegate, UIPopoverControllerDelegate>
{
    CGRect bounds;
    SqliteManage *mySqliteManage;
}
@property (strong, nonatomic ) UIImageView *imageView;
@property (strong, nonatomic ) UIImageView *paintView;
@property (strong, nonatomic) UIImage *paintImage;
@property (strong, nonatomic) UIImage *image;
@property (copy, nonatomic) NSString *lastChosenMediaType;
@property (strong, nonatomic) NSURL *movieURL;
@property (strong, nonatomic) MPMoviePlayerController *moviePlayerController;
//@property (strong, nonatomic) UITableViewCell *prototypeCell;
@property (strong, nonatomic)  C5 *cell5;
@property (strong, nonatomic) UILabel *myLable;
@end

@implementation detailViewController
-(void)passValue:(UIImage *)value
{
    _paintImage = value;
    _paintView.image = _paintImage;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    bounds = [UIScreen mainScreen].bounds;
    mySqliteManage = [SqliteManage sqliteManage];
    _image = [mySqliteManage readImage:_item];
    _paintImage = [mySqliteManage readPaint:_item];
    //初始化按钮
    UIBarButtonItem *myImageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(myImageAction:)];
    UIBarButtonItem *myCoolButton = [[UIBarButtonItem alloc] initWithTitle:@"Paint" style:UIBarButtonItemStyleDone target:self action:@selector(myCoolAction:)];
    //UIBarButtonItem *myCoolButton = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"paintIcon.png"] style:UIBarButtonItemStyleDone target:self action:@selector(myCoolAction:)];
    
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myImageButton, myCoolButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray;
    
    //c5
    UINib *cellNib = [UINib nibWithNibName:@"C5" bundle:nil];
    [self.tableView registerNib:cellNib forCellReuseIdentifier:@"C5"];
    //self.prototypeCell  = [self.tableView dequeueReusableCellWithIdentifier:@"C5"];
    _cell5 = [self.tableView dequeueReusableCellWithIdentifier:@"C5"];
    _cell5.myTextView.delegate = self;
    _cell5.selectionStyle = UITableViewCellSelectionStyleNone;
    _cell5.myTextView.text = [mySqliteManage readDB:(int)_item];
    
    //_cell5.myTextView.autoresizingMask = UIViewAutoresizingFlexibleHeight;//自适应高度
    //_cell5.myTextView.font = [UIFont fontWithName:nil size:18];//设置字体名字和字体大小
    
    [_cell5.myTextView setFrame:CGRectMake(_cell5.myTextView.frame.origin.x, _cell5.myTextView.frame.origin.y, bounds.size.width, bounds.size.width)];
    NSDictionary *attribute =@{NSFontAttributeName: [UIFont systemFontOfSize:19.0]};
    
    //NSDictionary *attribute =@{NSFontAttributeName: _cell5.myTextView.font};
    CGSize size = [_cell5.myTextView.text boundingRectWithSize:_cell5.myTextView.bounds.size
                                               options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                            attributes:attribute context:nil].size;
    [_cell5.myTextView setFrame:CGRectMake(_cell5.myTextView.frame.origin.x, _cell5.myTextView.frame.origin.y, size.width, size.height+15)];
    
    //lable
    _myLable = [[UILabel alloc]initWithFrame:CGRectMake(0, 3, 320, 30) ];
    _myLable.backgroundColor = [UIColor clearColor];
    _myLable.font = _cell5.myTextView.font;
    if (_cell5.myTextView.text.length == 0) {
        _myLable.text = @"  Tap here to input texts...";
    }else{
        _myLable.text = @"";
    }
     _myLable.enabled = NO;
    [_cell5.contentView addSubview:_myLable];
    
    //_imageView
    _imageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,bounds.size.width, bounds.size.width)];
    if (_image == nil) {
        self.imageView.hidden = YES;
    }else{
        _imageView.image = _image;
    }
    //paintView
    _paintView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0,_paintImage.size.width, _paintImage.size.height)];
    _paintView.image = _paintImage;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    _paintView.frame = CGRectMake(0, 0,_paintImage.size.width, _paintImage.size.height);
    [self updateDisplay];
}
- (void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    if ([self.navigationController.viewControllers indexOfObject:self]==NSNotFound)
    {
        if (![_cell5.myTextView.text isEqualToString:@""] || _image!=nil || _paintImage!=nil)
        {
            [mySqliteManage saveImageAndPaint:(int)_item data:_cell5.myTextView.text image:_image andPaint:_paintImage];
        }
    }
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    //NSLog(@"cellForRowAtIndexPath: indexPath.row= %ld",(long)indexPath.row);
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"detailCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"detailCell"];
    }
    if (indexPath.row == 0) {
            //[cell addSubview: _textView];//加入到整个页面中
        return _cell5;
    }
    if(indexPath.row == 1) {
        [cell addSubview: _imageView];//加入到整个页面中
        return cell;
    }
    [cell addSubview: _paintView];
    return cell;
}
#pragma mark 每行的高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        return _cell5.myTextView.frame.size.height > 60 ? _cell5.myTextView.frame.size.height : 60;
    }
    if (indexPath.row == 1) {
        if (_image == nil) {
            return 0;
        }else return bounds.size.width;
    }
    return _paintImage.size.height;
}
#pragma mark 自动高度
- (void) textViewDidChange:(UITextView *)textView
{
    if (textView.text.length == 0) {
        _myLable.text = @"  Tap here to input texts...";
    }else{
        _myLable.text = @"";
    }
    
    CGRect frame = textView.frame;
    frame.size.height = textView.contentSize.height;
    if (frame.size.height >= 60) {
        textView.frame = frame;
    }
    [self.tableView beginUpdates];
    [self.tableView endUpdates];
}
#pragma mark 隐藏键盘
- (void) textViewDidBeginEditing:(UITextView *)textView
{
    [UIView beginAnimations:nil context: nil];
    //[UIView setAnimationDuration: 1.0];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    UIBarButtonItem * doneButton = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneAction:)];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: doneButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray;
    
    [UIView commitAnimations];
}
- (void) doneAction: (id)sender
{
    [UIView beginAnimations:nil context: nil];
    //[UIView setAnimationDuration: 1.0];
    [UIView setAnimationCurve: UIViewAnimationCurveEaseOut];
    
    [_cell5.myTextView resignFirstResponder];
    UIBarButtonItem *myImageButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCamera target:self action:@selector(myImageAction:)];
    UIBarButtonItem *myCoolButton = [[UIBarButtonItem alloc] initWithTitle:@"Paint" style:UIBarButtonItemStyleDone target:self action:@selector(myCoolAction:)];
    NSArray *myButtonArray = [[NSArray alloc] initWithObjects: myImageButton, myCoolButton, nil];
    self.navigationItem.rightBarButtonItems = myButtonArray;
    
    [UIView commitAnimations];
}
#pragma mark 现实图片
- (void)updateDisplay
{
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage]) {
        self.imageView.image = self.image;
        self.imageView.hidden = NO;
        self.moviePlayerController.view.hidden = YES;
    } else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie]) {
        [self.moviePlayerController.view removeFromSuperview];
        self.moviePlayerController = [[MPMoviePlayerController alloc]
                                      initWithContentURL:self.movieURL];
        [self.moviePlayerController play];
        UIView *movieView = self.moviePlayerController.view;
        movieView.frame = self.imageView.frame;
        //剪裁超出父视图范围的部分
        movieView.clipsToBounds = YES;
        [self.view addSubview:movieView];
        self.imageView.hidden = YES;
    }
}
#pragma mark 选择相机或者照片库
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == actionSheet.cancelButtonIndex) {
        return;
    }
    switch (buttonIndex) {
        case 0: {
            [self pickMediaFromSource:UIImagePickerControllerSourceTypePhotoLibrary];
            break;
        }
        case 1: {
            [self pickMediaFromSource:UIImagePickerControllerSourceTypeCamera];
            break;
        }
    }
}

#pragma mark -  按钮

- (void) myImageAction:(id)sender
{
        UIActionSheet *chooseIt = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"New Attachment", nil)
                                                              delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"Cancel", nil)
                                                destructiveButtonTitle:nil
                                                     otherButtonTitles:NSLocalizedString(@"Image from Library", nil), NSLocalizedString(@"Image from Camera", nil), nil];
        [chooseIt showInView:self.view];
}

- (void) myCoolAction: (id) sender
{
    PaintViewControlly *paint = [[PaintViewControlly alloc]init];
    //设置第二个窗口中的delegate为第一个窗口的self
    paint.delegate = self;
    [self.navigationController pushViewController:paint animated:YES];
}
#pragma mark 相机
- (void)pickMediaFromSource:(UIImagePickerControllerSourceType)sourceType
{
    NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
    if ([UIImagePickerController isSourceTypeAvailable:sourceType] && [mediaTypes count] > 0)
    {
        NSArray *mediaTypes = [UIImagePickerController availableMediaTypesForSourceType:sourceType];
        UIImagePickerController *picker = [[UIImagePickerController alloc] init];
        picker.mediaTypes = mediaTypes;
        picker.delegate = self;
        picker.allowsEditing = YES;
        picker.sourceType = sourceType;
        //[self presentViewController:picker animated:YES completion:NULL];
        //改写相机支持ipad ios8
        if([[[UIDevice currentDevice] systemVersion] floatValue]>=8.0)
        {
            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
                
                [self presentViewController:picker animated:YES completion:nil];
            }];
        }
        else{
            [self presentViewController:picker animated:YES completion:NULL];
        }
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
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    self.lastChosenMediaType = info[UIImagePickerControllerMediaType];
    if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeImage])
    {
        UIImage *chosenImage = info[UIImagePickerControllerEditedImage];
        self.image = [self shrinkImage:chosenImage toSize:self.imageView.bounds.size];
    }
    else if ([self.lastChosenMediaType isEqual:(NSString *)kUTTypeMovie])
    {
        self.movieURL = info[UIImagePickerControllerMediaURL];
    }
    [picker dismissViewControllerAnimated:YES completion:NULL];
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:NULL];
}
@end
