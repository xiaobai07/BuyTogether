//
//  FeedDetailTableViewController.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedDetailTableViewController.h"
#import "FeedProfileTableViewCell.h"
#import "FeedDescriptionTableViewCell.h"
#import "FeedContributeTableViewCell.h"
#import "FeedContributionStatusTableViewCell.h"
#import "FeedContributorTableViewCell.h"
#import "FeedWebViewTableViewCell.h"
#import "ViewController.h"
#define FeedProfileTableViewCellIdentifier @"FeedProfileTableViewCell"
#define FeedDescriptionTableViewIdentifier @"FeedDescriptionTableViewCell"
#define FeedContributorTableViewCellIdentifier @"FeedContributorTableViewCell"
#define FeedContributionStatusTableViewCellIdentifier @"FeedContributionStatusTableViewCell"
#define FeedContributeButtonTableViewCellIdenfier @"FeedContributeTableViewCell"

@interface FeedDetailTableViewController ()
@property (nonatomic,strong)FeedContributionStatusTableViewCell *priceCell;
@end

@implementation FeedDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSLog(@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"name"]);
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
    
    self.navigationItem.title = @"Feed Details";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)refresh
{
    dispatch_async( dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        // Add code here to do background processing
        //
        [self.feedObject refresh];
        dispatch_async( dispatch_get_main_queue(), ^{
            // Add code here to update the UI/send notifications based on the
            // results of the background processing
            [self.tableView reloadData];
        });
    });
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
    // 3 - Contributors
    // 4 - Contribution status
    // 5 - Contribute button
    
    // Return the number of sections.
    return 5;
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
    // 3 - Contributors
    // 4 - Contribution status
    // 5 - Contribute button
    if ([indexPath section] == 0){
        FeedProfileTableViewCell *cellProfile = [tableView dequeueReusableCellWithIdentifier:FeedProfileTableViewCellIdentifier forIndexPath:indexPath];
        cellProfile.selectionStyle = UITableViewCellSelectionStyleNone;
        cellProfile.feedNameLabel.text = self.feedObject[@"name"];
        return cellProfile;
    }
    else if ([indexPath section] == 1){
        FeedDescriptionTableViewCell *cellDescription = [tableView dequeueReusableCellWithIdentifier:FeedDescriptionTableViewIdentifier forIndexPath:indexPath];
        NSURL *url = [NSURL URLWithString:@"https://www.google.com"];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [cellDescription.webView loadRequest:request];
        cellDescription.selectionStyle = UITableViewCellSelectionStyleNone;
        return cellDescription;
        
    }
    else if ([indexPath section] == 2) {
        FeedContributorTableViewCell *contributorCell = [tableView dequeueReusableCellWithIdentifier:FeedContributorTableViewCellIdentifier forIndexPath:indexPath];
        contributorCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return contributorCell;
    }
    else if ([indexPath section] == 3) {
        self.priceCell = [tableView dequeueReusableCellWithIdentifier:FeedContributionStatusTableViewCellIdentifier forIndexPath:indexPath];
        self.priceCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.priceCell;
    }

    else {
        FeedContributeTableViewCell *contributionButtonCell = [tableView dequeueReusableCellWithIdentifier:FeedContributeButtonTableViewCellIdenfier forIndexPath:indexPath];
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
    // 3 - Contributors
    // 4 - Contribution status
    // 5 - Contribute button
    
    if ([indexPath section] == 0) {
        return 80;
    }
    else if ([indexPath section] == 1) {
        return 175;
    }
    else if ([indexPath section] == 2) {
        return 75;
    }
    else if ([indexPath section] == 3) {
        return 100;
    }
    else if ([indexPath section] == 4) {
        return 70;
    }
    return 44;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 4) {
        [self send];
        
    }
    [tableView cellForRowAtIndexPath:indexPath].selected = NO;
}

- (void)send
{
    void(^handler)(VENTransaction *, BOOL, NSError *) = ^(VENTransaction *transaction, BOOL success, NSError *error) {
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
                    NSString *user = [NSString stringWithFormat:@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"name"]];
                    NSArray *namearray = @[user];
                    dealObject[@"contributor"]=namearray;
                }else{
                    NSMutableArray *mutablearray = [[NSMutableArray alloc]init];
                    NSArray *existarray = [NSArray arrayWithArray:dealObject[@"contributor"]];
                    [mutablearray addObjectsFromArray:existarray];
                    NSString *user = [NSString stringWithFormat:@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"name"]];
                    [mutablearray addObject:user];
                    dealObject[@"contributor"]= mutablearray;
                }
                [dealObject saveInBackground];
                [self refresh];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
                
            }];
        }
    };
    // Payment
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
