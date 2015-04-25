#import <UIKit/UIKit.h>
#import "MaterialInfoDAL.h"
#import "MaterialInfoArchive.h"
#import "MaterialDetailCell.h"

@interface MaterialDetailViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MaterialInfoDelegate>
{
    MaterialInfoDAL *materialDetailDAL;
    NSMutableArray *materialDetailList;
    
    IBOutlet UITableView *tvmaterialDetail;
}

@property (nonatomic,retain) MaterialInfoModel *currDetail;

@property (nonatomic,retain) IBOutlet UIButton *btnReturn;


@end
