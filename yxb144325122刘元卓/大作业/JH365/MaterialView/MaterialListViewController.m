#import "MaterialListViewController.h"
#import "MacroDefine.h"

@implementation MaterialListViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    materialInfoDAL = [[MaterialInfoDAL alloc] initWithDelegate:self];
    [materialInfoDAL getList];
    tvmaterial.dataSource = self;
    tvmaterial.delegate = self;
    tvmaterial.backgroundColor = [UIColor clearColor];
    tvmaterial.rowHeight = 60;
    tvmaterial.separatorStyle = UITableViewCellSeparatorStyleNone;
    materialList = [[MaterialInfoArchive getList] retain];
    [tvmaterial reloadData];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    [materialInfoDAL release],materialInfoDAL = nil;
    [materialList release],materialList = nil;
    [materialDetailViewController release],materialDetailViewController = nil;
}

- (void)dealloc
{
    [materialInfoDAL release],materialInfoDAL = nil;
    [materialList release],materialList = nil;
    [materialDetailViewController release],materialDetailViewController = nil;
    [super dealloc];
}

-(void)getMaterialInfoListCallBack:(NSMutableArray *)list
{
    [materialList release];
    materialList = [list retain];
    //归档数据
    if(materialList.count > 0)
        [MaterialInfoArchive saveList:materialList];
    [tvmaterial reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return materialList.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialCell *cell = (MaterialCell *)[tableView dequeueReusableCellWithIdentifier:@"MaterialCell"];
    if (cell == nil)
    {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"MaterialCell" owner:self options:nil];
        cell = [nib objectAtIndex:0];
    }
    MaterialInfoModel *item = [materialList objectAtIndex:indexPath.row];
    cell.lblMName.text = item.materialName;
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    MaterialInfoModel *item = [materialList objectAtIndex:indexPath.row];
    if (item !=nil)
    {
        [materialDetailViewController release];
        materialDetailViewController = [[MaterialDetailViewController alloc] initWithNibName:(iPhone5?@"MaterialDetailView-5":@"MaterialDetailView") bundle:nil];
        materialDetailViewController.currDetail = item;
        [self.navigationController pushViewController:materialDetailViewController animated:YES];
    }
}

@end
