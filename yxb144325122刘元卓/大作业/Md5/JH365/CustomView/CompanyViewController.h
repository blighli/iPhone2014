#import <UIKit/UIKit.h>
#import "CustomDAL.h"
#import "CustomCompanyArchive.h"
#import "CompanyCell.h"
#import "CustomCompanyModel.h"

@interface CompanyViewController : UIViewController<UITableViewDataSource,UITableViewDelegate,CustomDelegate>
{
    CustomDAL *companyDAL;
    NSMutableArray *companyList;
    IBOutlet UITableView *tvcompany;
}

@property (nonatomic,retain) IBOutlet UIButton *btnReturn;

@end
