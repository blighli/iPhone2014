#import "MTCamera.h"
#import <MobileCoreServices/MobileCoreServices.h>
#import <AssetsLibrary/AssetsLibrary.h>
#import <ImageIO/ImageIO.h>

@implementation MTCamera
UIImagePickerController* picker;

+ (instancetype)sharedManager {
    static MTCamera *_sharedManager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _sharedManager = [[self alloc] init];
    });
    return _sharedManager;
}

- (void)viewDidLoad
{
	[super viewDidLoad];
	self.delegate = self;
}

- (void)takePhoto:(UIViewController*)currentView
{
	// 如果拍摄的摄像头可用
	if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
	{
		// 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
		self.sourceType = UIImagePickerControllerSourceTypeCamera;
		// 设置拍摄照片
		self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModePhoto;
		// 设置使用手机的后置摄像头（默认使用后置摄像头）
		self.cameraDevice = UIImagePickerControllerCameraDeviceRear;
		// 设置使用手机的前置摄像头。
        //		picker.cameraDevice = UIImagePickerControllerCameraDeviceFront;
		// 设置拍摄的照片是否允许编辑
		self.allowsEditing = _editing;
	}
	else
	{
		NSLog(@"模拟器无法打开摄像头");
	}
	// 显示picker视图控制器
    [currentView presentViewController:self animated: YES completion:nil];
}
- (void)takeVideo:(UIViewController*)currentView
{
	if ([UIImagePickerController isSourceTypeAvailable:
         UIImagePickerControllerSourceTypeCamera])
	{
		// 将sourceType设为UIImagePickerControllerSourceTypeCamera代表拍照或拍视频
		self.sourceType = UIImagePickerControllerSourceTypeCamera;
		// 将mediaTypes设为所有支持的多媒体类型
		self.mediaTypes = [UIImagePickerController
                             availableMediaTypesForSourceType:
                             UIImagePickerControllerSourceTypeCamera];
		// 设置拍摄视频
		self.cameraCaptureMode = UIImagePickerControllerCameraCaptureModeVideo;
		// 设置拍摄高质量的视频
		self.videoQuality = UIImagePickerControllerQualityTypeHigh;
	}
	else
	{
		NSLog(@"模拟器无法打开摄像头");
	}
	[currentView presentViewController:self animated: YES completion:nil];
}
- (void)loadPhoto:(UIViewController*)currentView
{
	// 设置选择载相册的图片或视频
	self.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
	self.allowsEditing = _editing;
	[currentView presentViewController:self animated: YES completion:nil];
}
// 当得到照片或者视频后，调用该方法
-(void)imagePickerController:(UIImagePickerController *)picker
didFinishPickingMediaWithInfo:(NSDictionary *)info
{
	// 获取用户拍摄的是照片还是视频
	NSString *mediaType = [info objectForKey:UIImagePickerControllerMediaType];
	// 判断获取类型：图片，并且是刚拍摄的照片
	if ([mediaType isEqualToString:(NSString *)kUTTypeImage])
	{
		_theImage = nil;
		// 判断，图片是否允许修改
		if ([picker allowsEditing])
		{
			// 获取用户编辑之后的图像
			_theImage = [info objectForKey:UIImagePickerControllerEditedImage];
		}
		else
		{
			// 获取原始的照片
			_theImage = [info objectForKey:UIImagePickerControllerOriginalImage];
		}
        
        
		// 如果是拍摄的那么保存图片到相册中
        if (picker.sourceType == UIImagePickerControllerSourceTypeCamera) {
            UIImageWriteToSavedPhotosAlbum(_theImage, self,nil, nil);
        }
	}
	// 判断获取类型：视频，并且是刚拍摄的视频
//	else if ([mediaType isEqualToString:(NSString *)kUTTypeMovie])
//	{
//		//获取视频文件的url
//		_mediaURL = [info objectForKey:UIImagePickerControllerMediaURL];
//		
//		//创建ALAssetsLibrary对象并将视频保存到媒体库
//		ALAssetsLibrary *assetsLibrary = [[ALAssetsLibrary alloc] init];
//		// 将视频保存到相册中
//		[assetsLibrary writeVideoAtPathToSavedPhotosAlbum:_mediaURL
//                                          completionBlock:^(NSURL *assetURL, NSError *error)
//         {
//             // 如果没有错误，显示保存成功。
//             if (!error)
//             {
//                 NSLog(@"视频保存成功！");
//             }
//             else
//             {
//                 NSLog(@"保存视频出现错误：%@", error);
//             }
//         }];
//	}
        
	// 隐藏UIImagePickerController
	[self dismissViewControllerAnimated:YES completion:^(){
        [self.dele useImage:_theImage];
    }];

}
// 当用户取消时，调用该方法
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
	// 隐藏UIImagePickerController
	[picker dismissViewControllerAnimated:YES completion:nil];
}
@end
