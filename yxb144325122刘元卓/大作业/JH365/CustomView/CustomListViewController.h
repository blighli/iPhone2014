#import <UIKit/UIKit.h>
#import "UserViewController.h"
#import "CompanyViewController.h"


@interface CustomListViewController : UIViewController

@property (nonatomic,strong) UserViewController *userView;

@property (nonatomic,strong) CompanyViewController *companyView;

-(IBAction)btnUserClicked:(id)sender;

-(IBAction)btnCompanyClicked:(id)sender;

@end
