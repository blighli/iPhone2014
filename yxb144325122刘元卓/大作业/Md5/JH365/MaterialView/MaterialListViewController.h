#import <UIKit/UIKit.h>
#import "MaterialInfoDAL.h"
#import "MaterialInfoArchive.h"
#import "MaterialCell.h"
#import "MaterialDetailViewController.h"

@class MaterialDetailViewController;

@interface MaterialListViewController : UIViewController
<UITableViewDataSource,UITableViewDelegate,MaterialInfoDelegate>
{
    MaterialInfoDAL *materialInfoDAL;
    NSMutableArray *materialList;
    
    IBOutlet UITableView *tvmaterial;
    
    MaterialDetailViewController *materialDetailViewController;
}

@end

