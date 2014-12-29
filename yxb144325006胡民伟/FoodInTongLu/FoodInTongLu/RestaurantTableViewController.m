//
//  RestaurantTableViewController.m
//  FoodInTongLu
//
//  Created by Cocoa on 14/12/2.
//  Copyright (c) 2014年 Cocoa. All rights reserved.
//

#import "RestaurantTableViewController.h"
#import "CustomTableViewCell.h"
#import "Restaurant.h"
#import "DetailViewController.h"
#import "PageViewController.h"
#import "AppDelegate.h"

@interface RestaurantTableViewController ()

@property(nonatomic, retain) UITableView *tableView;
@property (strong, nonatomic) NSMutableArray *restaurantNames;
@property (strong, nonatomic) NSMutableArray *restaurantImages;
@property (strong, nonatomic) NSMutableArray *restaurantLocations;
@property (strong, nonatomic) NSMutableArray *restaurantTypes;
@property (strong, nonatomic) NSMutableArray *restaurantIsVisited;
@property (strong, nonatomic) NSMutableArray *restaurants;
@property (strong, nonatomic) NSMutableArray *searchResults;
@property (strong, nonatomic) UISearchController *searchController;
@property (strong, nonatomic) NSFetchedResultsController *fetchResultController;
@end

@implementation RestaurantTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.restaurantNames = [[NSMutableArray alloc] initWithObjects:@"Cafe Deadend", @"Homei", @"Teakha", @"Cafe Loisl", @"Petite Oyster", @"For Kee Restaurant", @"Po's Atelier", @"Bourke Street Bakery", @"Haigh's Chocolate", @"Palomino Espresso", @"Upstate", @"Traif", @"Graham Avenue Meats", @"Waffle & Wolf", @"Five Leaves", @"Cafe Lore", @"Confessional", @"Barrafina", @"Donostia",@"Royal Oak",@"Thai Cafe",nil];
    
    self.restaurantImages = [[NSMutableArray alloc] initWithObjects:@"cafedeadend.jpg", @"homei.jpg", @"teakha.jpg", @"cafeloisl.jpg",@"petiteoyster.jpg", @"forkeerestaurant.jpg", @"posatelier.jpg", @"bourkestreetbakery.jpg",@"haighschocolate.jpg", @"palominoespresso.jpg", @"upstate.jpg", @"traif.jpg",@"grahamavenuemeats.jpg", @"wafflewolf.jpg", @"fiveleaves.jpg", @"cafelore.jpg",@"confessional.jpg", @"barrafina.jpg", @"donostia.jpg",@"royaloak.jpg",@"thaicafe.jpg",nil];
    
    self.restaurantLocations = [[NSMutableArray alloc] initWithObjects:@"G/F, 72 Po Hing Fong, Sheung Wan, Hong Kong", @"Shop B, G/F, 22-24A Tai Ping San Street SOHO, Sheung Wan, Hong Kong", @"Shop B, 18 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong",@"Shop B, 20 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong", @"24 Tai Ping Shan Road SOHO, Sheung Wan, Hong Kong",@"Shop J-K., 200 Hollywood Road, SOHO, Sheung Wan, Hong Kong", @"G/F, 62 Po Hing Fong,Sheung Wan, Hong Kong", @"633 Bourke St Sydney New South Wales 2010 Surry Hills", @"412-414 George St Sydney New South Wales", @"Shop 1 61 York St Sydney New South Wales", @"95 1st Ave New York, NY 10003", @"229 S 4th St Brooklyn, NY 11211", @"445 Graham Ave Brooklyn, NY 11211", @"413 Graham Ave Brooklyn, NY 11211", @"18 Bedford Ave Brooklyn, NY 11222", @"Sunset Park 4601 4th Ave Brooklyn, NY 11220", @"308 E 6th St New York, NY 10003", @"54 Frith Street London W1D 4SL United Kingdom", @"10 Seymour Place London W1H 7ND United Kingdom", @"2 Regency Street London SW1P 4BZ United Kingdom", @"22 Charlwood Street London SW1V 2DY Pimlico", nil];
    
    self.restaurantTypes = [[NSMutableArray alloc] initWithObjects:@"Coffee & Tea Shop",@"Cafe", @"Tea House", @"Austrian / Causual Drink",@"French", @"Bakery", @"Bakery", @"Chocolate", @"Cafe",@"American / Seafood", @"American", @"American", @"Breakfast & Brunch", @"Coffee & Tea", @"Coffee & Tea", @"Latin American", @"Spanish", @"Spanish", @"Spanish", @"British", @"Thai",nil];
    
    self.restaurantIsVisited = [[NSMutableArray alloc] initWithObjects:@"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false", @"false",nil];
    
//    NSNumber *test = [NSNumber numberWithInt:0];
//    
    self.restaurants = [[NSMutableArray alloc]initWithObjects:nil];
//    for (int i = 0; i < self.restaurantNames.count; i++) {
//        NSData *imageData = UIImagePNGRepresentation([UIImage imageNamed:self.restaurantImages[i]]);
////        Restaurant *tmpRestaurant = [[Restaurant alloc]initWithName:self.restaurantNames[i]
////                                                            andType:self.restaurantTypes[i]
////                                                        andLocation:self.restaurantLocations[i]
////                                                           andImage:imageData
////                                                       andIsVisited:test];
////        [self.restaurants addObject:tmpRestaurant];
//        Restaurant *restaurant = [[Restaurant alloc]init];
//        restaurant.name = self.restaurantNames[i];
//        restaurant.type = self.restaurantTypes[i];
//        restaurant.location = self.restaurantLocations[i];
//        restaurant.image = imageData;
//        restaurant.isVisited = [NSNumber numberWithInt:0];
//        [self saveRecordToCoreData:restaurant];
//    }
    
    // Launch walkthrough screens
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    BOOL hasViewedWalkthrough = [defaults boolForKey:@"hasViewedWalkthrough"];
    
    if (hasViewedWalkthrough == false) {
        PageViewController *pageViewController = [self.storyboard instantiateViewControllerWithIdentifier:@"PageViewController"];
        if (pageViewController) {
            [self presentViewController:pageViewController animated:true completion:nil];
        }
    }
    
    // Empty back button title
    self.navigationItem.backBarButtonItem = [[UIBarButtonItem alloc]initWithTitle:@"" style:UIBarButtonItemStylePlain target:nil action:nil];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    
    [self readRecordFromCoreData];
    
    // Create the search controller, but we'll make sure that this SearchShowResultsInSourceViewController
    // performs the results updating.
    self.searchController = [[UISearchController alloc]initWithSearchResultsController:nil];
    self.searchController.searchBar.barTintColor = [[UIColor alloc]initWithRed:234.0/255.0 green:118.0/255.0 blue:83.0/255.0 alpha:0.1];
    self.searchController.searchBar.placeholder = @"Search your restaurant";
    //searchController.searchBar.prompt = @"Quick Search";
    
    self.searchController.searchResultsUpdater = self;
    self.searchController.dimsBackgroundDuringPresentation = false;
    
    // Make sure the that the search bar is visible within the navigation bar.
    [self.searchController.searchBar sizeToFit];
    
    // Include the search controller's search bar within the table's header view.
    self.tableView.tableHeaderView = self.searchController.searchBar;
    
    self.definesPresentationContext = true;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    self.navigationController.hidesBarsOnSwipe = true;
}
#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if ([self.searchController isActive]) {
        return self.searchResults.count;
    }else{
        return self.restaurants.count;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    CustomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
    Restaurant *restaurant = nil;
    if ([self.searchController isActive]) {
        restaurant = self.searchResults[indexPath.row];
    }else{
        restaurant = self.restaurants[indexPath.row];
    }
    cell.nameLabel.text = restaurant.name;
    cell.thumbnailImageView.image = [UIImage imageWithData:restaurant.image];
//    cell.thumbnailImageView.layer.cornerRadius = cell.thumbnailImageView.frame.size.width / 2;
//    cell.thumbnailImageView.clipsToBounds = true;
    cell.locationLabel.text = restaurant.location;
    cell.typeLabel.text = restaurant.type;
    
    if (restaurant.isVisited.boolValue == true) {
//        cell.accessoryType = UITableViewCellAccessoryCheckmark;
        cell.iconImageView.hidden = false;
    }else{
//        cell.accessoryType = UITableViewCellAccessoryNone;
        cell.iconImageView.hidden = true;
    }
        
    return cell;
}

//-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
//    
//    UIAlertController *optionMenu = [UIAlertController alertControllerWithTitle:nil message:@"what do you want to do?" preferredStyle:UIAlertControllerStyleActionSheet];
//    
//    [optionMenu addAction:[UIAlertAction actionWithTitle:@"Cancel"
//                                                   style:UIAlertActionStyleCancel
//                                                 handler:nil]];
//    
//    [optionMenu addAction:[UIAlertAction actionWithTitle:[NSString stringWithFormat:@"Call 123-000-%ld", (long)(indexPath.row)]
//                                                   style:UIAlertActionStyleDefault
//                                                 handler:^(UIAlertAction *callActionHandler) {
//                                                     UIAlertController *alertMessage = [UIAlertController alertControllerWithTitle:@"Service Unavailabl" message:@"Sorry, the call feature is not available yet. Please retry later." preferredStyle:UIAlertControllerStyleAlert];
//                                                     [alertMessage addAction:[UIAlertAction actionWithTitle:@"OK"
//                                                                                                      style:UIAlertActionStyleDefault
//                                                                                                    handler:nil]];
//                                                     [self presentViewController:alertMessage animated:YES completion:nil];
//                                                 }]];
//    
//    [optionMenu addAction:[UIAlertAction actionWithTitle:@"I've been here"
//                                                   style:UIAlertActionStyleDefault
//                                                 handler:^(UIAlertAction *actionHandler) {
//                                                     CustomTableViewCell *cell = (CustomTableViewCell*) [tableView cellForRowAtIndexPath:indexPath];
//                                                     //cell.accessoryType = UITableViewCellAccessoryCheckmark;
//                                                     cell.iconImageView.hidden = false;
//                                                     Restaurant *restaurant = self.restaurants[indexPath.row];
//                                                     restaurant.isVisited = @"true";
//                                                 }]];
//    
//    [self presentViewController:optionMenu animated:YES completion:nil];
//    [tableView deselectRowAtIndexPath:indexPath animated:false];
//}

// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    if ([self.searchController isActive]) {
        return false;
    }else{
        return true;
    }
}

// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
//    if (editingStyle == UITableViewCellEditingStyleDelete) {
//        // Delete the row from the data source
//        
//        [self.restaurants removeObjectAtIndex:indexPath.row];
//        
//        [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
//        //[self.tableView reloadData];
//    }
    //else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    //}
}

- (NSArray*)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewRowAction *shareAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                           title:@"Share"
                                                                         handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                             UIAlertController *shareMenu = [UIAlertController alertControllerWithTitle:nil
                                                                                                                                                message:@"Share using"
                                                                                                                                         preferredStyle:UIAlertControllerStyleActionSheet];
                                                                             UIAlertAction *weiboAction = [UIAlertAction actionWithTitle:@"WeiBo"
                                                                                                                             style:UIAlertActionStyleDefault
                                                                                                                           handler:nil];
                                                                             UIAlertAction *wechatAction = [UIAlertAction actionWithTitle:@"WeChat"
                                                                                                                             style:UIAlertActionStyleDefault
                                                                                                                           handler:nil];
                                                                             UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel"
                                                                                                                             style:UIAlertActionStyleCancel
                                                                                                                                  handler:^(UIAlertAction *action){
                                                                                                                                      [tableView deselectRowAtIndexPath:indexPath animated:false];                                        }];
                                                                             
                                                                             [shareMenu addAction:weiboAction];
                                                                             [shareMenu addAction:wechatAction];
                                                                             [shareMenu addAction:cancelAction];
                                                                             
                                                                             [self presentViewController:shareMenu animated:YES completion:nil];
                                                                         }];
    
    UITableViewRowAction *deleteAction = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleDefault
                                                                            title:@"Delete"
                                                                          handler:^(UITableViewRowAction *action, NSIndexPath *indexPath) {
                                                                            
//                                                                              [self.restaurants removeObjectAtIndex:indexPath.row];
//                                                                              [self.tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
                                                                              [self deleteRecordFromCoreData:indexPath];
                                                                              
                                                                          }];
    shareAction.backgroundColor = [UIColor colorWithRed:255.0/255.0 green:166.0/255.0 blue:51.0/255.0 alpha:1.0];
    deleteAction.backgroundColor = [UIColor colorWithRed:51.0/255.0 green:51.0/255.0 blue:51.0/255.0 alpha:1.0];
    
    NSArray *returnValue = [[NSArray alloc]initWithObjects:deleteAction, shareAction, nil];
    return returnValue;
}

#pragma mark - CoreData
- (void)readRecordFromCoreData{
    NSFetchRequest *fetchRequest = [NSFetchRequest fetchRequestWithEntityName:@"Restaurant"];
    NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:true];
    fetchRequest.sortDescriptors = @[sortDescriptor];
    
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    if (managedObjectContext) {
        
        self.fetchResultController = [[NSFetchedResultsController alloc]initWithFetchRequest:fetchRequest
                                                                        managedObjectContext:managedObjectContext
                                                                          sectionNameKeyPath:nil
                                                                                   cacheName:nil];
        self.fetchResultController.delegate = self;
        
        NSError *error = nil;
        
        BOOL result = [self.fetchResultController performFetch:&error];
        
        self.restaurants = [NSMutableArray arrayWithArray:[self.fetchResultController fetchedObjects]];
        
        if (result != true) {
            NSLog(@"Select error: %@",[error localizedDescription]);
        }
    }
}

- (void)saveRecordToCoreData{
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    if (managedObjectContext) {
        Restaurant *restaurant = (Restaurant*)[NSEntityDescription insertNewObjectForEntityForName:@"Restaurant" inManagedObjectContext:managedObjectContext];

        NSError *error = nil;
        if ([managedObjectContext save:&error] != true) {
            NSLog(@"Insert error: %@",[error localizedDescription]);
            return;
        }
    }
}

- (void)deleteRecordFromCoreData:(NSIndexPath*)indexPath{
    // Delete the row from the data source
    AppDelegate *appDelegate = (AppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *managedObjectContext = appDelegate.managedObjectContext;
    if (managedObjectContext) {
        Restaurant* restaurantToDelete = (Restaurant*)[self.fetchResultController objectAtIndexPath:indexPath];
        [managedObjectContext deleteObject:restaurantToDelete];
        
        NSError *error = nil;
        if ([managedObjectContext save:&error] != true) {
            NSLog(@"Delete error: %@",[error localizedDescription]);
            return;
        }
    }
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath{
    switch (type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        case NSFetchedResultsChangeUpdate:
            [self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
        default:
            [self.tableView reloadData];
    }
    self.restaurants = [NSMutableArray arrayWithArray:[controller fetchedObjects]];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller{
    [self.tableView endUpdates];
}

#pragma mark - SearchController
- (void)filterContentForSearchText:(NSString *) searchText{
    
    NSPredicate *searchPredicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
    self.searchResults = (NSMutableArray*)[self.restaurants filteredArrayUsingPredicate:searchPredicate];
    
}

- (void)updateSearchResultsForSearchController:(UISearchController *)searchController{
    
    NSString *searchText = [[NSString alloc]initWithString:searchController.searchBar.text];
    [self filterContentForSearchText:searchText];
    [self.tableView reloadData];
}

#pragma mark - Segue
- (IBAction)unwindToHomeScreen:(UIStoryboardSegue *) segue{
    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"showRestaurantDetail"]){
        NSIndexPath *indexPath = [self.tableView indexPathForSelectedRow];
        if (indexPath){
            DetailViewController *destinationController = segue.destinationViewController;
            if ([self.searchController isActive]) {
                destinationController.restaurant = self.searchResults[indexPath.row];
            }else{
                destinationController.restaurant = self.restaurants[indexPath.row];
            }
        }
    }
}

@end
