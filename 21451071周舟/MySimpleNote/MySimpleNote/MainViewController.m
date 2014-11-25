//
//  MainViewController.m
//  MySimpleNote
//
//  Created by 周舟 on 20/11/14.
//  Copyright (c) 2014 zzking. All rights reserved.
//

#import "MainViewController.h"
#import "NewNoteViewController.h"
#import "Entity.h"
#import "DetailViewController.h"

@interface MainViewController ()<CLLocationManagerDelegate>

@property (nonatomic, strong) NSMutableArray *notesArray;
@property (nonatomic) CLLocationManager *locationManager;
@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    if (_notesArray == nil) {
        _notesArray = [NSMutableArray array];
    }
    
    [self loadData];
    
}


- (void)loadData
{
    [[self locationManager] startUpdatingLocation];
    
    /*
     Fetch existing events.
     Create a fetch request, add a sort descriptor, then execute the fetch.
     */
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Entity" inManagedObjectContext:self.managedObjectContext];
    [request setEntity:entity];
    
    // Order the events by creation date, most recent first.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"date" ascending:NO];
    [request setSortDescriptors:@[sortDescriptor]];
    
    // Execute the fetch -- create a mutable copy of the result.
    NSError *error = nil;
    NSMutableArray *mutableFetchResults = [[self.managedObjectContext executeFetchRequest:request error:&error] mutableCopy];
    if (mutableFetchResults == nil) {
        // Handle the error.
    }
    
    // Set self's events array to the mutable array, then clean up.
    self.notesArray = [mutableFetchResults mutableCopy];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self loadData];
    [self.tableView reloadData];
}


- (CLLocationManager *)locationManager
{
    if (_locationManager != nil) {
        return _locationManager;
    }
    
    _locationManager = [[CLLocationManager alloc] init];
    [_locationManager setDesiredAccuracy:kCLLocationAccuracyNearestTenMeters];
    [_locationManager setDelegate:self];
    
    return _locationManager;
}



#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {

    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return self.notesArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIdentifier = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellIdentifier forIndexPath:indexPath];
    
    Entity* entity = self.notesArray[indexPath.row];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat: @"yyyy-MM-dd HH:mm:ss"];
    
    cell.textLabel.text = [dateFormatter stringFromDate: entity.date];
    return cell;
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"detail"])
    {
        NSLog(@"detail");
        DetailViewController *deVC = (DetailViewController *)segue.destinationViewController;
        NSIndexPath *index = [self.tableView indexPathForCell:sender];
        Entity *entity = self.notesArray[index.row];
        deVC.contentStr = entity.content;
        deVC.imagePath =  entity.imagepath;
    }
    else
    {
        NewNoteViewController *VC = (NewNoteViewController *)segue.destinationViewController;
        VC.manageedObjectContext = self.managedObjectContext;
    }
}

@end
