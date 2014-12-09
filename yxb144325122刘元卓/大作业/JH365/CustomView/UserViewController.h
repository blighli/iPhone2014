#import <UIKit/UIKit.h>
#import "CustomDAL.h"
#import "CustomUserArchive.h"
#import "UserCell.h"
#import "CustomCompanyModel.h"

@interface UserViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CustomDelegate>
{
    CustomDAL *userDAL;
    NSMutableArray *userList;
    IBOutlet UITableView *tvuser;
    
}

@property (nonatomic,retain) IBOutlet UIButton *btnReturn;
@property (nonatomic,retain) CustomUserModel *curruser;
@end
