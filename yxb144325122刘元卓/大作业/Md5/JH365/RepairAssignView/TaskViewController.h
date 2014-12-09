#import <UIKit/UIKit.h>
#import "UnFinishViewController.h"
#import "FinishViewController.h"
#import "AllViewController.h"

@interface TaskViewController : UIViewController

@property (strong,nonatomic) UnFinishViewController *unFinishViewController;
@property (strong,nonatomic) FinishViewController *finishViewController;
@property (strong,nonatomic) AllViewController *allViewController;

// 点击三个按钮的事件
- (IBAction)btnUnFinishClicked:(id)sender;
- (IBAction)btnFinishClicked:(id)sender;
- (IBAction)btnAllClicked:(id)sender;

@end
