
#import <UIKit/UIKit.h>
#import "CLLRefreshHeadController.h"

@interface ViewController : UIViewController <UITableViewDataSource,UITableViewDelegate,CLLRefreshHeadControllerDelegate>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic,strong)NSMutableArray *arr;
@end
