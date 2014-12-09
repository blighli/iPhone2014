#import "UserViewController.h"

@implementation UserViewController
@synthesize btnReturn,curruser;

- (void)viewDidLoad
{
    [super viewDidLoad];
    userDAL = [[CustomDAL alloc] initWithDelegate:self];
    [userDAL getCustomListWithPageOutCount:15 :1];
    tvuser.dataSource = self;
    tvuser.delegate = self;
    tvuser.backgroundColor = [UIColor clearColor];
    tvuser.rowHeight = 480;
    tvuser.separatorStyle = UITableViewCellSeparatorStyleNone;
    userList = [[CustomUserArchive getListuser] retain];
    [tvuser reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [userDAL release],userDAL = nil;
    [userList release],userList = nil;
    self.btnReturn = nil;
}

- (void)dealloc
{
    [userDAL release],userDAL = nil;
    [userList release],userList = nil;
    self.btnReturn = nil;
    [super dealloc];
}
-(void)getCustomListWithPageOutCount:(NSMutableArray *)list
                      andRecordCount:(int)recordCount
                        andPageCount:(int)pageCount
                         andPageSize:(int)pageSize
                        andPageIndex:(int)pageIndex;
{
    [userList release];
    userList = [list retain];
    
    //归档数据
    if(userList.count > 0)
        [CustomUserArchive saveListuser:userList];
    [tvuser reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return userList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 480;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UserCell *cell = (UserCell *)[tableView dequeueReusableCellWithIdentifier:@"UserCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"UserCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    CustomUserModel *item = [userList objectAtIndex:indexPath.row];
    cell.lblcompanyCode.text = item.companyCode;
    cell.lblregionID.text = [NSString stringWithFormat:@"%i",item.regionID];
    cell.lblregionName.text = item.regionName;
    cell.lblcustomCode.text = item.customCode;
    cell.lblcustomName.text = item.customName;
    cell.lblhomeAddress.text = item.homeAddress;
    cell.lblhomePhone.text = item.homePhone;
    cell.lblworkPhone.text = item.workPhone;
    cell.lblfaxNumber.text = item.faxNumber;
    cell.lblmobilePhone.text = item.mobilePhone;
    cell.lblinsuranceTypeName.text = item.insuranceTypeName;
    cell.lblinsuranceNumber.text = item.insuranceNumber;
    cell.lblbeginTime.text = item.beginTime;
    cell.lblkeepTime.text = item.keepTime;
    cell.lblendTime.text = item.endTime;
    return cell;
}

-(IBAction)btnReturnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
