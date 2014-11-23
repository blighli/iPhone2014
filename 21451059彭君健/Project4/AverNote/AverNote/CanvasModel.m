#import "CanvasModel.h"

@implementation CanvasModel

+ (id)modelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width
{
    CanvasModel *myViewModel = [[CanvasModel alloc] init];
   
    myViewModel.color = color;
    myViewModel.path = path;
    myViewModel.width = width;
    
    return myViewModel;
}
@end
