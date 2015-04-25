#import "AllViewController.h"

@implementation AllViewController

@synthesize btnReturn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    repairInfoDAL = [[RepairInfoDAL alloc] initWithDelegate:self];
    [repairInfoDAL getListWithPageOutCount:15 :1 :@"" :-1 :@""];
    tvrepairInfo.dataSource = self;
    tvrepairInfo.delegate = self;
    tvrepairInfo.backgroundColor = [UIColor clearColor];
    tvrepairInfo.rowHeight = 830;
    tvrepairInfo.separatorStyle = UITableViewCellSeparatorStyleNone;
    repairInfoList = [[RepairInfoArchive getList] retain];
    [tvrepairInfo reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [repairInfoDAL release],repairInfoDAL = nil;
    [repairInfoList release],repairInfoList = nil;
    self.btnReturn = nil;
}

- (void)dealloc
{
    [repairInfoDAL release],repairInfoDAL = nil;
    [repairInfoList release],repairInfoList = nil;
    self.btnReturn = nil;
    [super dealloc];
}

-(void)getRepairInfoPageListCallBack:(NSMutableArray *)list
                      andRecordCount:(int)recordCount
                        andPageCount:(int)pageCount
                         andPageSize:(int)pageSize
                        andPageIndex:(int)pageIndex
{
    [repairInfoList release];
    repairInfoList = [list retain];
    
    //归档数据
    if(repairInfoList.count > 0)
        [RepairInfoArchive saveList:repairInfoList];
    [tvrepairInfo reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return repairInfoList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 830;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TaskDetailCell *Dcell = (TaskDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"TaskDetailCell"];
    if (Dcell == nil)
    {
        NSArray *Dnib = [[NSBundle mainBundle] loadNibNamed:@"TaskDetailCell" owner:self options:nil];
        Dcell = [Dnib objectAtIndex:0];
    }
    RepairInfoModel *Ditem = [repairInfoList objectAtIndex:indexPath.row];
    Dcell.lblRC.text = Ditem.repairCode;
    Dcell.lblCK.text = Ditem.customKind;
    Dcell.lblcompanyN.text = Ditem.companyName;
    Dcell.lblcustomN.text = Ditem.customName;
    Dcell.lblDN.text = Ditem.deviceName;
    Dcell.lblDMTN.text = Ditem.deviceMainTypeName;
    Dcell.lblDSTN.text = Ditem.deviceSubTypeName;
    Dcell.lblRealName.text = Ditem.realName;
    Dcell.lbladdress.text = Ditem.address;
    Dcell.lblcreateTime.text = Ditem.createTime;
    Dcell.lblcreateUserName.text = Ditem.createUserName;
    Dcell.lblcallTime.text = Ditem.callTime;
    Dcell.lblproblemDesc.text = Ditem.problemDesc;
    if (Ditem.repairState == 0)
    {
        Dcell.lblrepairState.text = @"未维修";
    }
    else
    {
        Dcell.lblrepairState.text = @"已维修";
    }
    if (Ditem.ifAssigned == 0)
    {
        Dcell.lblifAssigned.text = @"未指派";
    }
    else
    {
        Dcell.lblifAssigned.text = @"已指派";
    }
    Dcell.lblassignTechCode.text = Ditem.assignTechCode;
    Dcell.lblassignTechName.text = Ditem.assignTechName;
    Dcell.lblassignTime.text = Ditem.assignTime;
    if (Ditem.ifMoneyRepair == 0)
    {
        Dcell.lblifMoneyRepair.text = @"未收费";
    }
    else
    {
        Dcell.lblifMoneyRepair.text = @"已收费";
    }
    Dcell.lblmoneyRepair.text = [NSString stringWithFormat:@"%f",Ditem.moneyRepair];
    Dcell.lblrepairBackMsg.text = Ditem.repairBackMsg;
    Dcell.lblneedMaterial.text = Ditem.needMaterial;
    if (Ditem.ifCallBack == 0)
    {
        Dcell.lblifCallBack.text = @"未回访";
    }
    else
    {
        Dcell.lblifCallBack.text = @"已回访";
    }
    Dcell.lblcustomFeelLevel.text = Ditem.customFeelLevel;
    Dcell.lblcustomBackMsg.text = Ditem.customBackMsg;
    if (Ditem.ifDelete == 0)
    {
        Dcell.lblifDelete.text = @"NO";
    }
    else
    {
        Dcell.lblifDelete.text = @"YES";
    }
    return Dcell;
}

-(IBAction)btnReturnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
