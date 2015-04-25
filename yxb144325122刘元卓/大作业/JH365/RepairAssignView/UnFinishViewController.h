#import <UIKit/UIKit.h>
#import "UnFinishRepairInfoDAL.h"
#import "RepairInfoArchive.h"
#import "TaskDetailCell.h"
#import "RepairInfoModel.h"

@interface UnFinishViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RepairInfoDelegate>
{
    UnFinishRepairInfoDAL *ufrepairInfoDAL;
    NSMutableArray *ufrepairInfoList;
    
    IBOutlet UITableView *uftvrepairInfo;
    
}

@property (nonatomic,retain) IBOutlet UIButton *btnReturn;

@property (nonatomic,retain) RepairInfoModel *curruf;

@end
