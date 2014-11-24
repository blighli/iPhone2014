
#import <UIKit/UIKit.h>

@interface PaintViewController : UIViewController
{
    NSMutableArray *array;
}
@property (weak, nonatomic) IBOutlet UISegmentedControl *colorControl;
- (IBAction)changeColor:(id)sender;
- (IBAction)changeShape:(id)sender;

@end
