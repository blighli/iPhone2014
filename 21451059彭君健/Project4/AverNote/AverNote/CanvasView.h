#import <UIKit/UIKit.h>

@interface CanvasView : UIView

@property (assign, nonatomic) CGFloat lineWidth;
@property (strong, nonatomic) UIColor *lineColor;
- (void)clearCanvas;
- (UIImage*)getImage;
@end
