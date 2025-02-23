//
//  FeedDetailTableViewController.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//
#import "UIImageView+AFNetworking.h"
#import "FeedDetailTableViewController.h"
#import "FeedProfileTableViewCell.h"
#import "FeedDescriptionTableViewCell.h"
#import "FeedContributeTableViewCell.h"
#import "FeedContributionStatusTableViewCell.h"
#import "FeedContributorTableViewCell.h"
#import "FeedWebViewTableViewCell.h"
#import "ViewController.h"
#import "FeedLinkTableViewCell.h"
#import "FeedWebViewController.h"

#define FeedProfileTableViewCellIdentifier @"FeedProfileTableViewCell"
#define FeedDescriptionTableViewIdentifier @"FeedDescriptionTableViewCell"
#define FeedContributorTableViewCellIdentifier @"FeedContributorTableViewCell"
#define FeedContributionStatusTableViewCellIdentifier @"FeedContributionStatusTableViewCell"
#define FeedContributeButtonTableViewCellIdenfier @"FeedContributeTableViewCell"
#define FeedLinkTableViewCellIdentifier @"FeedLinkTableViewCell"

@interface FeedDetailTableViewController ()
@property (nonatomic,strong)FeedContributionStatusTableViewCell *priceCell;
@property (nonatomic, strong)UIRefreshControl *refreshControl;
@end

@implementation FeedDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.refreshControl = [[UIRefreshControl alloc] initWithFrame:CGRectMake(0, 0, 30, 30)];
    self.refreshControl.tintColor = [UIColor grayColor];
    [self.refreshControl addTarget:self action:@selector(refresh) forControlEvents:UIControlEventValueChanged];
    [self.tableView addSubview:self.refreshControl];
    //NSLog(@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"name"]);
    // TableViewCell for feed profile
    UINib *profileNib = [UINib nibWithNibName:FeedProfileTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:profileNib forCellReuseIdentifier:FeedProfileTableViewCellIdentifier];
    
    // TableViewCell for feed description
    UINib *descriptionNib = [UINib nibWithNibName:FeedDescriptionTableViewIdentifier bundle:nil];
    [self.tableView registerNib:descriptionNib forCellReuseIdentifier:FeedDescriptionTableViewIdentifier];
    
    // TableViewCell for feed contributors
    UINib *contributorNib = [UINib nibWithNibName:FeedContributorTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:contributorNib forCellReuseIdentifier:FeedContributorTableViewCellIdentifier];
    
    
    // TableViewCell for feed contribution status
    UINib *contributionStatusNib = [UINib nibWithNibName:FeedContributionStatusTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:contributionStatusNib forCellReuseIdentifier:FeedContributionStatusTableViewCellIdentifier];
    
    // TableViewCell for feed contribute button
    UINib *contributeButtonNib = [UINib nibWithNibName:FeedContributeButtonTableViewCellIdenfier bundle:nil];
    [self.tableView registerNib:contributeButtonNib forCellReuseIdentifier:FeedContributeButtonTableViewCellIdenfier];
    
    // TableViewCell for feed contribute button
    UINib *linkNib = [UINib nibWithNibName:FeedLinkTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:linkNib forCellReuseIdentifier:FeedLinkTableViewCellIdentifier];
    

    self.navigationItem.title = @"Feed Details";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    //[self refresh];
}

- (void)refresh
{
    PFQuery *query = [PFQuery queryWithClassName:@"dealObject"];
    // Retrieve the object by id
    [query getObjectInBackgroundWithId:self.feedObject.objectId block:^(PFObject *dealObject, NSError *error) {
        
        self.feedObject = dealObject;
        [self.tableView reloadData];
         [self.refreshControl endRefreshing];
        
    }];
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // 1 - Name, FeedProfile, TimeLeft
    // 2 - Description
    // 3 - Link
    // 4 - Contributors
    // 5 - Contribution status
    // 6 - Contribute button
    
    // Return the number of sections.
    return 6;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 - Name, FeedProfile, TimeLeft
    // 2 - Description
    // 3 - Link
    // 4 - Contributors
    // 5 - Contribution status
    // 6 - Contribute button
//    PFObject *dealObject = [PFObject objectWithClassName:@"dealObject"];
//    dealObject[@"name"] = self.eventName;
//    dealObject[@"link"] = self.productLink;
//    dealObject[@"minprice"] = self.minimalContribution;
//    dealObject[@"description"] = self.description;
//    dealObject[@"venmo"] = self.venmoAcount;
    if ([indexPath section] == 0){
        FeedProfileTableViewCell *cellProfile = [tableView dequeueReusableCellWithIdentifier:FeedProfileTableViewCellIdentifier forIndexPath:indexPath];
        cellProfile.selectionStyle = UITableViewCellSelectionStyleNone;
        cellProfile.feedNameLabel.text = self.feedObject[@"name"];
        NSString *creatorid = self.feedObject[@"creatorid"];
        PFQuery *userQuery = [PFUser query];
        [userQuery whereKey:@"objectId" equalTo:creatorid];
        [userQuery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
            PFObject *user = array[0];
            NSString *usrstring = user[@"profile"][@"pictureURL"];
            [cellProfile.organizerProfile setImageWithURL:[NSURL URLWithString:usrstring]];
        }];
        return cellProfile;
    }
    else if ([indexPath section] == 1){
        FeedDescriptionTableViewCell *cellDescription = [tableView dequeueReusableCellWithIdentifier:FeedDescriptionTableViewIdentifier forIndexPath:indexPath];
                cellDescription.selectionStyle = UITableViewCellSelectionStyleNone;
        cellDescription.descriptionTextView.text = self.feedObject[kFeedObjectDescriptionKey];
        return cellDescription;
    }
    else if([indexPath section] == 2){
        FeedLinkTableViewCell *linkCell = [tableView dequeueReusableCellWithIdentifier:FeedLinkTableViewCellIdentifier forIndexPath:indexPath];
        linkCell.linkLabel.text = self.feedObject[kFeedObjectLinkKey];
        return linkCell;
    }
    
    else if ([indexPath section] == 3) {
        FeedContributorTableViewCell *contributorCell = [tableView dequeueReusableCellWithIdentifier:FeedContributorTableViewCellIdentifier forIndexPath:indexPath];
        contributorCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSArray *contributorarray = self.feedObject[kFeedObjectContributorsKey];
        for (int i=0; i<contributorarray.count; i++) {
            if (i==0) {
                NSDictionary *dictionary = contributorarray[i];
                NSString *usrstring = dictionary[@"url"];
                [contributorCell.contributorOneProfile setImageWithURL:[NSURL URLWithString:usrstring] placeholderImage:[UIImage imageNamed:@"empty_profile"]];
            }else if(i == 1){
                NSDictionary *dictionary = contributorarray[i];
                NSString *usrstring = dictionary[@"url"];
                [contributorCell.contributorTwoProfile setImageWithURL:[NSURL URLWithString:usrstring] placeholderImage:[UIImage imageNamed:@"empty_profile"]];
            }
            else if(i == 2){
                NSDictionary *dictionary = contributorarray[i];
                NSString *usrstring = dictionary[@"url"];
                [contributorCell.contributorThreeProfile setImageWithURL:[NSURL URLWithString:usrstring]placeholderImage:[UIImage imageNamed:@"empty_profile"]];
            }
        }
        if (contributorarray.count>0) {
            contributorCell.label.hidden = YES;
        } else {
            contributorCell.label.hidden = NO;
        }
//        if ([contributorarray count] == 0)
//        {
//            contributorCell.contributorOneProfile.hidden = YES;
//            contributorCell.contributorTwoProfile.hidden = YES;
//            contributorCell.contributorThreeProfile.hidden = YES;
//        }
//        else if ([contributorarray count] == 1)
//        {
//            contributorCell.contributorTwoProfile.hidden = YES;
//            contributorCell.contributorThreeProfile.hidden = YES;
//            contributorCell.label.hidden = YES;
//        }
//        else if ([contributorarray count] == 2)
//        {
//            contributorCell.contributorThreeProfile.hidden = YES;
//            contributorCell.label.hidden = YES;
//        }
//        else
//        {
//            contributorCell.label.hidden = YES;
//        }
        return contributorCell;
    }
    else if ([indexPath section] == 4) {
        self.priceCell = [tableView dequeueReusableCellWithIdentifier:FeedContributionStatusTableViewCellIdentifier forIndexPath:indexPath];
        self.priceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        NSString *creatorid = self.feedObject[@"creatorid"];
        if ([creatorid isEqualToString:[PFUser currentUser].objectId]) {
            self.priceCell.dollarLabel.alpha = 0;
            self.priceCell.roleContributionLabel.text = @"Paticipant Contribution";
            self.priceCell.contribution.alpha = 0;
        } else {
            NSArray *contributorarray = self.feedObject[kFeedObjectContributorsKey];
            for (NSDictionary *eachperson in contributorarray) {
                NSString *cid = eachperson[@"id"];
                if ([cid isEqualToString:[PFUser currentUser].objectId]) {
                    self.priceCell.roleContributionLabel.text = @"Contributed";
                    self.priceCell.minimalContribution.alpha = 0;
                }
            }
            
        }
        // Collected amount
        NSString *contributedAmountString;
        if (self.feedObject[kFeedObjectContributedAmmount])
        {
            contributedAmountString = [NSString stringWithFormat:@"$%@", self.feedObject[kFeedObjectContributedAmmount]];
        }
        else {
            contributedAmountString = @"$0";
        }
        
        self.priceCell.contributedAmount.text = contributedAmountString;
        // Total amount
        NSString *goalAmountString;
        if (self.feedObject[kFeedObjectGoalAmount]) {
            goalAmountString = [NSString stringWithFormat:@"of $%@", self.feedObject[kFeedObjectGoalAmount]];
        }
        else {
            goalAmountString = @"of $0";
        }
        self.priceCell.totalContribution.text = goalAmountString;
        
        // Minimal required contribution string
        NSString *minimalAmountString = [NSString stringWithFormat:@"$%@ minimal", self.feedObject[kFeedObjectMinimalContribution]];
        self.priceCell.minimalContribution.text = minimalAmountString;
        self.priceCell.contribution.text = self.feedObject[kFeedObjectMinimalContribution];

        return self.priceCell;
        
    }
    else {
        FeedContributeTableViewCell *contributionButtonCell = [tableView dequeueReusableCellWithIdentifier:FeedContributeButtonTableViewCellIdenfier forIndexPath:indexPath];
        NSString *creatorid = self.feedObject[@"creatorid"];
        if ([creatorid isEqualToString:[PFUser currentUser].objectId]) {
            contributionButtonCell.buttonlabel.text = @"Invite more friends";
            contributionButtonCell.selectionStyle = UITableViewCellSelectionStyleNone;
            return contributionButtonCell;
        }
        NSArray *contributorarray = self.feedObject[kFeedObjectContributorsKey];
        for (NSDictionary *eachperson in contributorarray) {
            NSString *cid = eachperson[@"id"];
            if ([cid isEqualToString:[PFUser currentUser].objectId]) {
                contributionButtonCell.buttonlabel.text = @"Share it";
            }
        }
        contributionButtonCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return contributionButtonCell;
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1 - Name, FeedProfile, TimeLeft
    // 2 - Description
    // 3 - Link
    // 4 - Contributors
    // 5 - Contribution status
    // 6 - Contribute button
    
    if ([indexPath section] == 0) {
        return 80;
    }
    else if ([indexPath section] == 1) {
        return 100;
    }
    else if ([indexPath section] == 2) {
        return 50;
    }
    else if ([indexPath section] == 3) {
        return 90;
    }
    else if ([indexPath section] == 4) {
        return 110;
    }
    else if ([indexPath section] == 5) {
        return 70;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 2) {
        FeedWebViewController *webViewController = [[FeedWebViewController alloc] init];
        if (webViewController) {
            FeedLinkTableViewCell *linkCell = (FeedLinkTableViewCell *)[self.tableView cellForRowAtIndexPath:indexPath];
            
            webViewController.link = linkCell.linkLabel.text;
        }
        
        UINavigationController *webNavVC = [[UINavigationController alloc] initWithRootViewController:webViewController];
        [self presentViewController:webNavVC animated:YES completion:nil];
    }
    if ([indexPath section] == 5) {
        NSArray *contributorarray = self.feedObject[kFeedObjectContributorsKey];
        BOOL found=NO;
        for (NSDictionary *eachperson in contributorarray) {
            NSString *cid = eachperson[@"id"];
            if ([cid isEqualToString:[PFUser currentUser].objectId]) {
                found = YES;
            }
        }
        if (!found) {
            NSString *creatorid = self.feedObject[@"creatorid"];
            if (![creatorid isEqualToString:[PFUser currentUser].objectId]){
                [self send];
            }
        }
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)send
{
    void(^handler)(VENTransaction *, BOOL, NSError *) =
    ^(VENTransaction *transaction, BOOL success, NSError *error) {
        if (error) {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:error.localizedDescription
                                                                message:error.localizedRecoverySuggestion
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];
        }
        else {
            UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@""
                                                                message:@"transaction success"
                                                               delegate:self
                                                      cancelButtonTitle:nil
                                                      otherButtonTitles:@"OK", nil];
            [alertView show];
            PFQuery *query = [PFQuery queryWithClassName:@"dealObject"];
            
            // Retrieve the object by id
            [query getObjectInBackgroundWithId:self.feedObject.objectId block:^(PFObject *dealObject, NSError *error) {
                
                // Now let's update it with some new data. In this case, only cheatMode and score
                // will get sent to the cloud. playerName hasn't changed.
                if (dealObject[@"currentprice"]==[NSNull null]) {
                    dealObject[@"currentprice"]= [NSNumber numberWithFloat:[self.priceCell.contribution.text floatValue]];
                }else{
                    float currentprice = [dealObject[@"currentprice"] floatValue];
                    dealObject[@"currentprice"]= [NSNumber numberWithFloat:[self.priceCell.contribution.text floatValue]+currentprice];
                }
                if (dealObject[@"contributor"]==[NSNull null]) {
                    NSString *userurl = [NSString stringWithFormat:@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
                    NSString *price = self.priceCell.contribution.text;
                    NSDictionary *dictionary = @{@"url": userurl,
                                                 @"price":price};
                    NSArray *namearray = @[dictionary];
                    dealObject[@"contributor"]=namearray;
                }else{
                    NSMutableArray *mutablearray = [[NSMutableArray alloc]init];
                    NSArray *existarray = [NSArray arrayWithArray:dealObject[@"contributor"]];
                    [mutablearray addObjectsFromArray:existarray];
                    NSString *userurl = [NSString stringWithFormat:@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
                    NSString *price = self.priceCell.contribution.text;
                    NSString *contributorid = [PFUser currentUser].objectId;
                    NSDictionary *dictionary = @{@"url": userurl,
                                                 @"price":price,
                                                 @"id":contributorid};
                    [mutablearray addObject:dictionary];
                    dealObject[@"contributor"]= mutablearray;
                }
                [dealObject saveInBackground];
                [self performSelector:@selector(refresh) withObject:nil afterDelay:2];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
                
            }];
        }
    };
    // Payment
    [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
    [[Venmo sharedInstance] sendPaymentTo:self.feedObject[@"venmo"]
                                   amount:self.priceCell.contribution.text.floatValue*100
                                     note:self.feedObject[@"description"]
                        completionHandler:handler];


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
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
    <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
