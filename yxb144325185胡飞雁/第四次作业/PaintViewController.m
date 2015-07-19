
#import "PaintViewController.h"
#import "Constants.h"
#import "QuartzView.h"

@interface PaintViewController ()

@end

@implementation PaintViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    array=[[NSMutableArray alloc]initWithCapacity:10];
    [(QuartzView *)self.view setShapeArray:array];
  
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];

}


- (IBAction)changeColor:(id)sender {
    UISegmentedControl *control=sender;
    NSInteger index=[control selectedSegmentIndex];
    
    QuartzView *funView=(QuartzView *)self.view;
    switch (index) {
        case kRedColorTab:
            funView.currentColor=[UIColor redColor];
            funView.useRandomColor=NO;
            break;
        case kBlueColorTab:
            funView.currentColor=[UIColor blueColor];
            funView.useRandomColor=NO;
            break;
        case kYellowColorTab:
            funView.currentColor=[UIColor yellowColor];
            funView.useRandomColor=NO;
            break;
        case kGreenColorTab:
            funView.currentColor=[UIColor greenColor];
            funView.useRandomColor=NO;
            break;
        case kRandomColorTab:
            funView.useRandomColor=YES;
            break;
        default:
            break;
    }
}

- (IBAction)changeShape:(id)sender {
    UISegmentedControl *control=sender;
    [(QuartzView *)self.view setShapeType:[control selectedSegmentIndex]];
    if ([control selectedSegmentIndex]==kImageShape)
        _colorControl.hidden=YES;
    else
        _colorControl.hidden=NO;
        
}
@end
