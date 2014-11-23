#import <UIKit/UIKit.h>

@interface MQuartzView : UIView

- (void)addPA:(CGPoint)nPoint;
- (void)addLA;
- (void)clear;
-(void)setLineColor:(NSInteger)color;
-(void)setlineWidth:(NSInteger)width;

@end
