#import <UIKit/UIKit.h>

@class SetViewController;
@protocol SetViewControllerDelegate
-(void)setViewControllerDidFinish:(SetViewController *)controller;
@end
@protocol JkCustomAlertDelegate <NSObject>
@optional
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex;
@end

@interface SetViewController : UIViewController
<UINavigationControllerDelegate,UIImagePickerControllerDelegate,UIAlertViewDelegate>
{
    IBOutlet UITextField *userName;
    IBOutlet UITextField *passWord;
    UIImagePickerController *imagePicker;
    id Jkdelegate;
    UIImage *backgroundImage;
    UIImage *contentImage;
    NSMutableArray *buttonArrays;
    NSString *string3;
}
@property (strong,nonatomic) IBOutlet UIImageView *imageView;
-(IBAction)ButtonClivk:(id)sender;
-(IBAction)SaveButtonClick:(id)sender;
@property (assign, nonatomic) id <SetViewControllerDelegate> delegate;
@property (readwrite, retain) UIImage *backgroundImage;
@property (readwrite, retain) UIImage *contentImage;
@property (nonatomic,assign) id Jkdelegate;
@property (strong,nonatomic) NSMutableArray *buttonArrays;
-(id)initWithImage:(UIImage *)image contentImage:(UIImage *)content;
-(void) addButtonWithUIbutton:(UIButton *)btn;

@end
