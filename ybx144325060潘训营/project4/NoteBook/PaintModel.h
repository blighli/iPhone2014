#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@interface PaintModel : NSObject

+ (id)modelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width;

@property (strong, nonatomic) UIColor *color;

@property (strong, nonatomic) UIBezierPath *path;

@property (assign, nonatomic) CGFloat width;

@end
