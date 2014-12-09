#import "CompanyViewController.h"

@implementation CompanyViewController

@synthesize btnReturn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    companyDAL = [[CustomDAL alloc] initWithDelegate:self];
    [companyDAL getCompanyListWithPageOutCount:15 :1];
    tvcompany.dataSource = self;
    tvcompany.delegate = self;
    tvcompany.backgroundColor = [UIColor clearColor];
    tvcompany.rowHeight = 510;
    tvcompany.separatorStyle = UITableViewCellSeparatorStyleNone;
    companyList = [[CustomCompanyArchive getList] retain];
    [tvcompany reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [companyDAL release],companyDAL = nil;
    [companyList release],companyList = nil;
    self.btnReturn = nil;
}

- (void)dealloc
{
    [companyDAL release],companyDAL = nil;
    [companyList release],companyList = nil;
    self.btnReturn = nil;
    [super dealloc];
}
-(void)getCompanyListWithPageOutCount:(NSMutableArray *)list
                       andRecordCount:(int)recordCount
                         andPageCount:(int)pageCount
                          andPageSize:(int)pageSize
                         andPageIndex:(int)pageIndex
{
    [companyList release];
    companyList = [list retain];
    
    //归档数据
    if(companyList.count > 0)
        [CustomCompanyArchive saveList:companyList];
    [tvcompany reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return companyList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 510;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    CompanyCell *cell = (CompanyCell *)[tableView dequeueReusableCellWithIdentifier:@"CompanyCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"CompanyCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    CustomCompanyModel *item = [companyList objectAtIndex:indexPath.row];
    cell.lblcompanyCode.text = item.companyCode;
    cell.lblcompanyName.text = item.companyName;
    cell.lblpeopleCount.text = [NSString stringWithFormat:@"%i",item.peopleCount];
    cell.lblbeginTime.text = item.beginTime;
    cell.lblkeepTime.text = item.keepTime;
    cell.lblendTime.text = item.endTime;
    cell.lblinsuranceTypeCode.text = item.insuranceTypeCode;
    cell.lblinsuranceNumber.text = item.insuranceNumber;
    cell.lblcontactName.text = item.contactName;
    cell.lbladdress.text = item.address;
    cell.lblphoneNum.text = item.phoneNum;
    cell.lblemail.text = item.email;
    cell.lbldutyServer.text = item.dutyServer;
    cell.lblcreateUserID.text = [NSString stringWithFormat:@"%i",item.createUserID];
    cell.lblcreateTime.text = item.createTime;
    cell.lblifPerson.text = [NSString stringWithFormat:@"%i",item.ifPerson];
    return cell;
}

-(IBAction)btnReturnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}
@end
