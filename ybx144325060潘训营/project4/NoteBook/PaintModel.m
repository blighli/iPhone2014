#import "PaintModel.h"

@implementation PaintModel

+ (id)modelWithColor:(UIColor *)color Path:(UIBezierPath *)path Width:(CGFloat)width
{
    PaintModel *myViewModel = [[PaintModel alloc] init];
   
    myViewModel.color = color;
    myViewModel.path = path;
    myViewModel.width = width;
    
    return myViewModel;
}
@end
