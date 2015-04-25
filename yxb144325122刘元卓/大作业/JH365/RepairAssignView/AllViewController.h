#import <UIKit/UIKit.h>
#import "RepairInfoDAL.h"
#import "RepairInfoArchive.h"
#import "TaskDetailCell.h"

@interface AllViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RepairInfoDelegate>
{
    RepairInfoDAL *repairInfoDAL;
    NSMutableArray *repairInfoList;
    
    IBOutlet UITableView *tvrepairInfo;
}

@property (nonatomic,retain) IBOutlet UIButton *btnReturn;

@end

