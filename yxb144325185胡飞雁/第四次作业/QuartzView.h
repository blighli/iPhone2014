
#import <UIKit/UIKit.h>
#import "Constants.h"


@interface QuartzView : UIView
@property (strong,nonatomic) NSMutableArray *shapeArray;
@property (nonatomic) CGPoint firstTouch;
@property (nonatomic) CGPoint lastTouch;
@property (strong, nonatomic) UIColor *currentColor;
@property (nonatomic) ShapeType shapeType;
@property (nonatomic, strong) UIImage *drawImage;
@property (nonatomic) BOOL useRandomColor;
@property (readonly) CGRect currentRect;
@property CGRect redrawrRect;
@end
