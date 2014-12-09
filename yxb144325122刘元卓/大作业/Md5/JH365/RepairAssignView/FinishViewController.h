#import <UIKit/UIKit.h>
#import "FinishRepairInfoDAL.h"
#import "RepairInfoArchive.h"
#import "TaskDetailCell.h"
#import "RepairInfoModel.h"

@interface FinishViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,RepairInfoDelegate>
{
    FinishRepairInfoDAL *frepairInfoDAL;
    NSMutableArray *frepairInfoList;
    IBOutlet UITableView* ftvrepairInfo;
}

@property (nonatomic,retain) IBOutlet UIButton *btnReturn;

@property (nonatomic,retain) RepairInfoModel *currf;

@end
