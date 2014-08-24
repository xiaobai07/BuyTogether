//
//  FeedTableViewController.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedTableViewController.h"
#import "FeedTableViewCell.h"
#import "UserDetailsViewController.h"
#import "FeedDetailTableViewController.h"
#import "NewEventViewController.h"
#import "FeedCreateTableViewController.h"
#import "UIImageView+AFNetworking.h"
#define FeedTableViewNibFileName @"FeedTableViewCell"
#define FeedTableViewCellIdentifier @"FeedTableViewCellIdentifier"

@interface FeedTableViewController ()
@property(nonatomic, strong)NSMutableArray *feedArray;
@end

@implementation FeedTableViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [[NSNotificationCenter defaultCenter]addObserver:self selector:@selector(refresh:) name:@"refresh" object:nil];
    self.feedArray = [[NSMutableArray alloc]init];
    // Register tableviewcell classes
    UINib *feedTableViewCellNib = [UINib nibWithNibName:FeedTableViewNibFileName bundle:nil];
    [self.tableView registerNib:feedTableViewCellNib forCellReuseIdentifier:FeedTableViewCellIdentifier];
    
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        PFQuery *query = [PFQuery queryWithClassName:@"dealObject"];
        NSArray* array = [query findObjects];
        [self.feedArray removeAllObjects];
        [self.feedArray addObjectsFromArray:array];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [self.tableView reloadData];
        });
    });
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}


- (void)refresh:(NSNotification *)notification
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        PFQuery *query = [PFQuery queryWithClassName:@"dealObject"];
        NSArray* array = [query findObjects];
        [self.feedArray removeAllObjects];
        [self.feedArray addObjectsFromArray:array];        
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [self.tableView reloadData];
        });
    });
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Add buttons to Navigation controller
    UIBarButtonItem *addBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addNewEvent)];
    self.navigationItem.rightBarButtonItem = addBarButton;
    
    UIBarButtonItem *profileBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Profile" style:UIBarButtonItemStyleBordered target:self action:@selector(viewProfile)];
    self.navigationItem.leftBarButtonItem = profileBarButton;
    
    self.navigationItem.title = @"Feeds";

}

// 'Profile' button clicked to show user profile info
- (void)viewProfile
{
   // [self dismissViewControllerAnimated:YES completion:nil];
    UserDetailsViewController *userDetailViewControlelr = [[UserDetailsViewController alloc] initWithStyle:UITableViewStyleGrouped];
    //UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:userDetailViewControlelr];

    [self.navigationController pushViewController:userDetailViewControlelr animated:YES];
}

// '+' button clicked to create a new event
- (void)addNewEvent
{
    FeedCreateTableViewController *newEventVC = [[FeedCreateTableViewController alloc] init];
    UINavigationController *nav = [[UINavigationController alloc]initWithRootViewController:newEventVC];
    [self presentViewController:nav animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.feedArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    FeedTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:FeedTableViewCellIdentifier forIndexPath:indexPath];
    PFObject *oneFeed = [self.feedArray objectAtIndex:indexPath.row];
    // Set profile
    NSString *creatorid = oneFeed[@"creatorid"];
    PFQuery *userQuery = [PFUser query];
    [userQuery whereKey:@"objectId" equalTo:creatorid];
    NSArray* userArray = [userQuery findObjects];
    PFObject *user = userArray[0];
    NSString *usrstring = user[@"profile"][@"pictureURL"];
    [cell.oragnizerProfile setImageWithURL:[NSURL URLWithString:usrstring]];
    cell.eventName.text = oneFeed[kFeedObjectFeedNameKey];
    
    // Add description
    cell.eventDescription.text = oneFeed[kFeedObjectDescriptionKey];
    
    // Add Contributor
    NSArray *contributors = oneFeed[kFeedObjectContributorsKey];
    if ([contributors count] == 0)
    {
        cell.contributorOneProfile.hidden = YES;
        cell.contributorTwoProfile.hidden = YES;
        cell.contributorThreeProfile.hidden = YES;
    }
    else if ([contributors count] == 1)
    {
        cell.contributorTwoProfile.hidden = YES;
        cell.contributorThreeProfile.hidden = YES;
    }
    else if ([contributors count] == 2)
    {
        cell.contributorThreeProfile.hidden = YES;
    }
    else
    {
        
    }

    
    // Add deal status
    NSString *totalContributionNeeded;
    if (oneFeed[kFeedObjectGoalAmount])
    {
        totalContributionNeeded = [NSString stringWithString:oneFeed[kFeedObjectGoalAmount]];
    }
    else {
        totalContributionNeeded = @"0";
    }

    NSString *contributedAmountString;
    if (oneFeed[kFeedObjectContributedAmmount])
    {
        contributedAmountString = [NSString stringWithFormat:@"%@", oneFeed[kFeedObjectContributedAmmount]];
    }
    else {
        contributedAmountString = @"0";
    }
    NSString *status = [NSString stringWithFormat:@"$%@/$%@", contributedAmountString, totalContributionNeeded];
    cell.eventStatus.text = status;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    FeedDetailTableViewController *feedDetailVC = [[FeedDetailTableViewController alloc] init];
    feedDetailVC.feedObject = [self.feedArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:feedDetailVC animated:YES];
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
