#import <Foundation/Foundation.h>

@protocol MTCameraimage
/**
 *  获取照片后的操作
 *
 *  @param image 获取的照片
 */
- (void)useImage:(UIImage*)image;
@end


@interface MTCamera : UIImagePickerController
<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (strong,nonatomic) UIImage* theImage;
@property (strong,nonatomic) NSURL* mediaURL;
@property (nonatomic, weak) id<MTCameraimage> dele;
@property (assign, nonatomic) BOOL editing; //是否允许编辑


+ (instancetype)sharedManager;

/**
 *  拍照
 *
 *  @param currentView 当前正在调用相机的控制器
 */
- (void)takePhoto:(UIViewController*)currentView;
/**
 *  录像
 *
 *  @param currentView 当前正在调用相机的控制器
 */
- (void)takeVideo:(UIViewController*)currentView;
/**
 *  获取相册图片
 *
 *  @param currentView 当前正在调用相机的控制器
 */
- (void)loadPhoto:(UIViewController*)currentView;


@end
