#import "CustomListViewController.h"

@implementation CustomListViewController

@synthesize companyView,userView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.companyView = nil;
    self.userView = nil;
}

- (void)didReceiveMemoryWarning
{
    self.companyView = nil;
    self.userView = nil;
    [super didReceiveMemoryWarning];
}

-(IBAction)btnUserClicked:(id)sender
{
    [userView release];
    userView = [[UserViewController alloc] init];
    [self.navigationController pushViewController:userView animated:YES];
    
}

-(IBAction)btnCompanyClicked:(id)sender
{
    [companyView release];
    companyView = [[CompanyViewController alloc] init];
    [self.navigationController pushViewController:companyView animated:YES];
}


@end
