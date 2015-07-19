
#import <UIKit/UIKit.h>

@interface PhotoViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@property (weak, nonatomic) IBOutlet UIButton * takePictureButton;

- (IBAction)shootPictureOrVideo:(id)sender;

- (IBAction)selectExistingPictureOrVideo:(id)sender;

@end
