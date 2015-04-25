#import "MaterialDetailViewController.h"
#import "MacroDefine.h"

@implementation MaterialDetailViewController

@synthesize currDetail,btnReturn;

- (void)viewDidLoad
{
    [super viewDidLoad];
    materialDetailDAL = [[MaterialInfoDAL alloc] initWithDelegate:self];
    [materialDetailDAL getListWithPageOutCount:100 :1 :currDetail.materialName];
    tvmaterialDetail.dataSource = self;
    tvmaterialDetail.delegate = self;
    tvmaterialDetail.backgroundColor = [UIColor clearColor];
    tvmaterialDetail.rowHeight = 180;
    tvmaterialDetail.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    materialDetailList = [[MaterialInfoArchive getList] retain];
    [tvmaterialDetail reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [materialDetailDAL release],materialDetailDAL = nil;
    [materialDetailList release],materialDetailList = nil;
    self.currDetail = nil;
    self.btnReturn = nil;
}

- (void)dealloc
{
    [materialDetailDAL release],materialDetailDAL = nil;
    [materialDetailList release],materialDetailList = nil;
    self.currDetail = nil;
    self.btnReturn = nil;
    [super dealloc];
}

-(void)getMaterialInfoPageListCallBack:(NSMutableArray *)list
                        andRecordCount:(int)recordCount
                          andPageCount:(int)pageCount
                           andPageSize:(int)pageSize
                          andPageIndex:(int)pageIndex
{
    [materialDetailList release];
    materialDetailList = [list retain];
    
    if(materialDetailList.count > 0)
        [MaterialInfoArchive saveList:materialDetailList];
    
    [tvmaterialDetail reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1; // 组的个数
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return materialDetailList.count; // 总记录条数
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 180; // 行高
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialDetailCell *Dcell = (MaterialDetailCell *)[tableView dequeueReusableCellWithIdentifier:@"MaterialDetailCell"];
    if (Dcell == nil)
    {
        NSArray *Dnib = [[NSBundle mainBundle] loadNibNamed:@"MaterialDetailCell" owner:self options:nil];
        Dcell = [Dnib objectAtIndex:0];
    }
    MaterialInfoModel *Ditem = [materialDetailList objectAtIndex:indexPath.row];
    Dcell.lblDName.text = Ditem.materialName;
    Dcell.lblDCode.text = Ditem.materialCode;
    Dcell.lblDSize.text = Ditem.materialSize;
    Dcell.lblDUnit.text = Ditem.materialUnit;
    return Dcell;
}

-(IBAction)btnReturnClicked:(id)sender
{
    [self.navigationController popViewControllerAnimated:YES];
}

@end
