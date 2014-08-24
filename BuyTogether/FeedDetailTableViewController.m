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

#define UITableViewCellIdentifier @"UITableViewCell"
#define FeedDescriptionTableViewIdentifier @"FeedDescriptionTableViewCell"
#define FeedProfileTableViewCellIdentifier @"FeedProfileTableViewCell"

@interface FeedDetailTableViewController ()

@end

@implementation FeedDetailTableViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // TableViewCell for feed name
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:UITableViewCellIdentifier];
    
    // TableViewCell for feed profile
    UINib *profileNib = [UINib nibWithNibName:FeedProfileTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:profileNib forCellReuseIdentifier:FeedProfileTableViewCellIdentifier];
    
    // TableViewCell for feed description
    UINib *descriptionNib = [UINib nibWithNibName:FeedDescriptionTableViewIdentifier bundle:nil];
    [self.tableView registerNib:descriptionNib forCellReuseIdentifier:FeedDescriptionTableViewIdentifier];

    self.navigationItem.title = @"Feed Detail";
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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
    // 4 - Status
    // 5 - Contribute
    
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return 1;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        FeedProfileTableViewCell *cellProfile = [tableView dequeueReusableCellWithIdentifier:FeedProfileTableViewCellIdentifier forIndexPath:indexPath];
        return cellProfile;
    }
    else {
        FeedDescriptionTableViewCell *cellDescription = [tableView dequeueReusableCellWithIdentifier:FeedDescriptionTableViewIdentifier forIndexPath:indexPath];
        return cellDescription;

    }
//    else if ([indexPath section] == 3) {
//        
//    }
//    else if ([indexPath section] == 4) {
//        
//    }
//    else if ([indexPath section] == 5) {
//        
//    }
    
    // Configure the cell...
}

- (float)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if ([indexPath section] == 0) {
        return 140;
    }
    else if ([indexPath section] == 1) {
        return 100;
    }
    return 44;
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
