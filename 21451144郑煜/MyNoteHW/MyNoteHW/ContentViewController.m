//
//  ContentViewController.m
//  TODOListHW
//
//  Created by StarJade on 14-11-23.
//  Copyright (c) 2014年 StarJade. All rights reserved.
//

#import "ContentViewController.h"
#import "FastTextView.h"
#import "Task.h"
#import "TaskStore.h"
#import "NSAttributedString+TextUtil.h"
#import "UIImage-Extensions.h"
#import "SlideAttachmentCell.h"
#import <AssetsLibrary/AssetsLibrary.h>

@interface ContentViewController() <UITextViewDelegate, UIImagePickerControllerDelegate,UINavigationControllerDelegate>

- (IBAction)takePhoto:(id)sender;

- (IBAction)finishBtn:(id)sender;
- (IBAction)cancel:(id)sender;

@property (weak, nonatomic) IBOutlet FastTextView *fastView;
@property (weak, nonatomic) IBOutlet UITextField *textTitle;

@end

@implementation ContentViewController

@synthesize fastView;
@synthesize textTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
	TaskStore *taskStore = [TaskStore sharedStore];
	int indexState = [taskStore indexState];

	fastView.backgroundColor = [UIColor whiteColor];
	if(indexState == -1){
		
		fastView.placeHolder=@"这是一个新的开始……";
	}else{
		Task *task = [taskStore.allTasks objectAtIndex:indexState];

		textTitle.text = task.taskName;

		fastView.attributedString = task.string;
		
	}

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)takePhoto:(id)sender {

	UIImagePickerControllerSourceType sourceType = UIImagePickerControllerSourceTypeCamera;
	//判断是否有摄像头
	if(![UIImagePickerController isSourceTypeAvailable:sourceType])
	{
		sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	}
	
	UIImagePickerController *imagePickerController = [[UIImagePickerController alloc] init];
	imagePickerController.delegate = self;   // 设置委托
	imagePickerController.sourceType = sourceType;
	imagePickerController.allowsEditing = YES;
	[self presentViewController:imagePickerController animated:YES completion:nil];  //需要以模态的形式展示

}

- (IBAction)finishBtn:(id)sender {
	
	TaskStore *taskStore = [TaskStore sharedStore];
	int indexState = [taskStore indexState];
	NSString *title = [textTitle text];
	if(indexState == -1){
		//	把新的数据保存到TaskStore
		Task *task = [taskStore createTask];
		if (![title isEqualToString:@""]) {
			
			task.taskName = title;
			task.string = [fastView.attributedString mutableCopy];
			
		}
	}else{
		//	修改 indexState 位置的 cell 数据
		NSMutableArray *allTasks = taskStore.allTasks;
		Task *task = [allTasks objectAtIndex:indexState];
		task.taskName = title;
		task.string = [fastView.attributedString mutableCopy];
		[allTasks replaceObjectAtIndex:indexState withObject:task];
	}
	

	
	
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (IBAction)cancel:(id)sender {
	 [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma -
#pragma UIImagePickerControllerDelegate
// 参考链接http://my.oschina.net/CarlHuang/blog/139997
//完成拍照
-(void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	
	UIImage *image = [info objectForKey:UIImagePickerControllerEditedImage];
	if (image == nil)
		image = [info objectForKey:UIImagePickerControllerOriginalImage];
	[self performSelector:@selector(savePhoto:) withObject:image];

	[picker dismissViewControllerAnimated:YES completion:^{}];

	
}
//用户取消拍照
-(void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	[picker dismissViewControllerAnimated:YES completion:nil];
}

-(void)savePhoto:(UIImage *)image{
	[self imageIntofastView:image];
}
//将照片保存到文本中
-(void)saveImage:(ALAsset *)asset
{
 ALAssetRepresentation *rep = [asset defaultRepresentation];
		NSMutableData *data = [NSMutableData dataWithLength:(int)[rep size]];/*图片转为数据*/
	
		NSError *error = nil;
		if ([rep getBytes:[data mutableBytes] fromOffset:0 length:[rep size] error:&error] == 0) {
			NSLog(@"error getting asset data %@", [error debugDescription]);
		} else {
			//        NSFileWrapper *wrapper = [[NSFileWrapper alloc] initRegularFileWithContents:data];
			//        wrapper.filename = [[rep url] lastPathComponent];
			
			// 把文件写入文件名为 attributedString 的文件
			UIImage *img=[UIImage imageWithData:data];
			[self imageIntofastView:img];
		}
}


//把涂鸦添加到文本
- (void)viewWillAppear:(BOOL)animated{
	TaskStore *taskStore = [TaskStore sharedStore];
	if (taskStore.isDoop){
		taskStore.isDoop = NO;
		[self imageIntofastView:taskStore.doop];
		
	}
}


- (void)imageIntofastView:(UIImage*)img{
	
	NSString *newfilename=[NSAttributedString scanAttachmentsForNewFileName:fastView.attributedString];
	
	
	NSArray *_paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString * _documentDirectory = [[NSString alloc] initWithString:[_paths objectAtIndex:0]];
	
	
	UIImage *thumbimg=[img imageByScalingProportionallyToSize:CGSizeMake(1024,6000)];
	
	NSString *pngPath=[_documentDirectory stringByAppendingPathComponent:newfilename];/*追加路径*/
	
	//[[AppDelegate documentDirectory] stringByAppendingPathComponent:@"tmp.jpg"];
	
	
	[UIImageJPEGRepresentation(thumbimg,0.7)writeToFile:pngPath atomically:YES];
	
	
	/*确定光标所在位置*/
	UITextRange *selectedTextRange = [fastView selectedTextRange];
	if (!selectedTextRange) {
		UITextPosition *endOfDocument = [fastView endOfDocument];
		selectedTextRange = [fastView textRangeFromPosition:endOfDocument toPosition:endOfDocument];
	}
	UITextPosition *startPosition = [selectedTextRange start] ; // hold onto this since the edit will drop
	
	unichar attachmentCharacter = FastTextAttachmentCharacter;
	[fastView replaceRange:selectedTextRange withText:[NSString stringWithFormat:@"\n%@\n",[NSString stringWithCharacters:&attachmentCharacter length:1]]];
	
	startPosition=[fastView positionFromPosition:startPosition inDirection:UITextLayoutDirectionRight offset:1];
	UITextPosition *endPosition = [fastView positionFromPosition:startPosition offset:1];
	selectedTextRange = [fastView textRangeFromPosition:startPosition toPosition:endPosition];
	
	
	
	NSUInteger st = ((FastIndexedPosition *)(selectedTextRange.start)).index;
	NSUInteger en = ((FastIndexedPosition *)(selectedTextRange.end)).index;
	
	if (en < st) {
		return;
	}
	NSUInteger contentLength = [[fastView.attributedString string] length];
	if (en > contentLength) {
		en = contentLength; // but let's not crash
	}
	if (st > en)
		st = en;
	NSRange cr = [[fastView.attributedString string] rangeOfComposedCharacterSequencesForRange:(NSRange){ st, en - st }];
	if (cr.location + cr.length > contentLength) {
		cr.length = ( contentLength - cr.location ); // but let's not crash
	}
	
	
	
	/*将其插入文本*/
	NSMutableAttributedString *mutableAttributedString=[fastView.attributedString mutableCopy];
	
	FileWrapperObject *fileWp = [[FileWrapperObject alloc] init];
	[fileWp setFileName:newfilename];
	[fileWp setFilePath:pngPath];
	
	
	
	SlideAttachmentCell *cell = [[SlideAttachmentCell alloc] initWithFileWrapperObject:fileWp] ;
	//ImageAttachmentCell *cell = [[ImageAttachmentCell alloc] init];
	cell.isNeedThumb=TRUE;
	cell.thumbImageWidth=200.0f;
	cell.thumbImageHeight=200.0f;
	
	NSDate *date = [NSDate date];
	NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
	[formatter setDateFormat:@"MMdd"];
	cell.txtdesc=[formatter stringFromDate:date];
	
	[mutableAttributedString addAttribute: FastTextAttachmentAttributeName value:cell  range:cr];
	
	//[mutableAttributedString addAttribute:fastTextAttachmentAttributeName value:cell  range:selectedTextRange];
	
	
	
	/*把富文本放入view*/
	if (mutableAttributedString) {
		fastView.attributedString = mutableAttributedString;
	}
	
	//[_editor setValue:attachment forAttribute:OAAttachmentAttributeName inRange:selectedTextRange];
	
	

}

@end

