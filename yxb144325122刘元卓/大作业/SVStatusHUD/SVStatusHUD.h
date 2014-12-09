#import <UIKit/UIKit.h>

@interface SVStatusHUD : UIView

+ (void)showWithImage:(UIImage *)image;
+ (void)showWithImage:(UIImage *)image status:(NSString *)string;
+ (void)showWithImage:(UIImage *)image status:(NSString *)string duration:(NSTimeInterval)duration;

+ (void)showWithStatus:(NSString *)status;
+ (void)showSuccessWithStatus:(NSString *)status;
+ (void)showErrorWithStatus:(NSString *)status;
+ (void)showWifiWithStatus:(NSString *)status;

@end
