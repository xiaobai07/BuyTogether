//
//  FeedCreateTableViewController.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedCreateTableViewController.h"
#import "FeedFormDescriptionTableViewCell.h"
//#import "FeedFormEventProfileTableViewCell.h"
#import "FeedFormGeneralItemTableViewCell.h"

#define FeedFormDescriptionTableViewCellIdentifier @"FeedFormDescriptionTableViewCell"
//#define FeedFormEventProfileTableViewCellIdentifier @"FeedFormEventProfileTableViewCell"
#define FeedFormGeneralItemTableViewCellIdentifier @"FeedFormGeneralItemTableViewCell"


@interface FeedCreateTableViewController ()

@property (nonatomic, strong) FeedFormGeneralItemTableViewCell *eventNameCell;
@property (nonatomic, strong) FeedFormGeneralItemTableViewCell *descriptionCell;
@property (nonatomic, strong) FeedFormGeneralItemTableViewCell *linkCell;
@property (nonatomic, strong) FeedFormGeneralItemTableViewCell *goalCell;
@property (nonatomic, strong) FeedFormGeneralItemTableViewCell *minimalContributionCell;
@property (nonatomic, strong) FeedFormGeneralItemTableViewCell *venmoCell;

@end

@implementation FeedCreateTableViewController

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
    
    // register general form item
    UINib *generalCellNib = [UINib nibWithNibName:FeedFormGeneralItemTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:generalCellNib forCellReuseIdentifier:FeedFormGeneralItemTableViewCellIdentifier];
    
//    // register profile form item
//    UINib *eventProfileNib = [UINib nibWithNibName:FeedFormEventProfileTableViewCellIdentifier bundle:nil];
//    [self.tableView registerNib:eventProfileNib forCellReuseIdentifier:FeedFormEventProfileTableViewCellIdentifier];
//    
    // register description form item
    UINib *descriptionNib = [UINib nibWithNibName:FeedFormDescriptionTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:descriptionNib forCellReuseIdentifier:FeedFormDescriptionTableViewCellIdentifier];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(postEvent)];
    self.navigationItem.rightBarButtonItem = doneButton;
    
    UIBarButtonItem *cancelButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancelEvent)];
    self.navigationItem.leftBarButtonItem = cancelButton;
    
    self.navigationItem.title = @"New Post";

}

- (void)postEvent
{
    self.eventName = [NSString stringWithString:self.eventNameCell.itemDataInput.text];
    self.description = [NSString stringWithString:self.descriptionCell.itemDataInput.text];
    self.productLink = [NSString stringWithString:self.linkCell.itemDataInput.text];
    self.fundingGoal = self.goalCell.itemDataInput.text;
    self.minimalContribution = self.minimalContributionCell.itemDataInput.text;
    self.venmoAcount = [NSString stringWithString:self.venmoCell.itemDataInput.text];

    PFObject *dealObject = [PFObject objectWithClassName:kFeedObjectName];
    dealObject[kFeedObjectFeedNameKey] = self.eventName;
    dealObject[kFeedObjectDescriptionKey] = self.description;
    dealObject[kFeedObjectLinkKey] = self.productLink;
    dealObject[kFeedObjectMinimalContribution] = self.minimalContribution;
    dealObject[kFeedObjectVenmoAccoutKey] = self.venmoAcount;
    dealObject[kFeedObjectGoalAmount] = self.fundingGoal;
    NSString *objectid = [PFUser currentUser].objectId;
    dealObject[@"creatorid"] = objectid;

    [dealObject saveInBackground];
    [self dismissViewControllerAnimated:YES completion:^{
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
    }];
}

- (void)cancelEvent
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
//    //1 - Image (Profile)
    //1 - Name (General)
    //2 - Description (Description)
    //3 - Link (General)
    //4 - Goal (General)
    //5 - Minimal contribution (General)
    //6 - Venmo Account (General)
    
    // Return the number of rows in the section.
    return 6;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if ([indexPath row] == 1) {
//        FeedFormEventProfileTableViewCell *eventProfileCell = [tableView dequeueReusableCellWithIdentifier:FeedFormEventProfileTableViewCellIdentifier forIndexPath:indexPath];
//        return eventProfileCell;
//    }
    if ([indexPath row] == 0) {
        self.eventNameCell = [tableView dequeueReusableCellWithIdentifier:FeedFormGeneralItemTableViewCellIdentifier forIndexPath:indexPath];
        self.eventNameCell.itemNameLabel.text = @"Name *";
        self.eventNameCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.eventNameCell;
    }
    else if ([indexPath row] == 1) {
        self.descriptionCell = [tableView dequeueReusableCellWithIdentifier:FeedFormGeneralItemTableViewCellIdentifier forIndexPath:indexPath];
        self.descriptionCell.itemNameLabel.text = @"Description *";

        return self.descriptionCell;
    }
    else if ([indexPath row] == 2) {
        self.linkCell = [tableView dequeueReusableCellWithIdentifier:FeedFormGeneralItemTableViewCellIdentifier forIndexPath:indexPath];
        self.linkCell.itemNameLabel.text = @"Link";
        self.linkCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.linkCell;
    }
    else if ([indexPath row] == 3) {
        self.goalCell = [tableView dequeueReusableCellWithIdentifier:FeedFormGeneralItemTableViewCellIdentifier forIndexPath:indexPath];
        self.goalCell.itemNameLabel.text = @"Funding Goal *";
        self.goalCell.itemDataInput.keyboardType = UIKeyboardTypeDecimalPad;
        self.goalCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.goalCell;
    }
    else if ([indexPath row] == 4) {
        self.minimalContributionCell = [tableView dequeueReusableCellWithIdentifier:FeedFormGeneralItemTableViewCellIdentifier forIndexPath:indexPath];
        self.minimalContributionCell.itemNameLabel.text = @"Minimal Contribution *";
        self.minimalContributionCell.itemDataInput.keyboardType = UIKeyboardTypeDecimalPad;
        self.minimalContributionCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.minimalContributionCell;
    }
    else {
        self.venmoCell = [tableView dequeueReusableCellWithIdentifier:FeedFormGeneralItemTableViewCellIdentifier forIndexPath:indexPath];
        self.venmoCell.itemNameLabel.text = @"Venmo *";
        self.venmoCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.venmoCell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    //1 - Image (Profile)
    //1 - Name (General)
    //2 - Description (Description)
    //3 - Link (General)
    //4 - Goal (General)
    //5 - Minimal contribution (General)
    //6 - Venmo Account (General)
    
    return 80;
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
