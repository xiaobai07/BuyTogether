//
//  Copyright (c) 2013 Parse. All rights reserved.

#import "LoginViewController.h"
#import <Parse/Parse.h>
#import "FeedTableViewController.h"

@implementation LoginViewController


#pragma mark - UIViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //self.title = @"Facebook Profile";
    
    // Check if user is cached and linked to Facebook, if so, bypass login    
    if ([PFUser currentUser] && [PFFacebookUtils isLinkedWithUser:[PFUser currentUser]]) {
        FeedTableViewController *feedViewController = [[FeedTableViewController alloc] initWithStyle:UITableViewStylePlain];
        UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feedViewController];
        [self.navigationController presentViewController:feedNavigationController animated:YES completion:nil];
    }

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // Hidde navigation bar
    self.navigationController.navigationBar.hidden = YES;
}

#pragma mark - Login mehtods

/* Login to facebook method */
- (IBAction)loginButtonTouchHandler:(id)sender
{
    // Set permissions required from the facebook user account
    NSArray *permissionsArray = @[ @"user_about_me", @"user_relationships", @"user_birthday", @"user_location",@"user_friends"];
    
    // Login PFUser using facebook
    [PFFacebookUtils logInWithPermissions:permissionsArray block:^(PFUser *user, NSError *error) {
        [_activityIndicator stopAnimating]; // Hide loading indicator
        
        if (!user) {
            if (!error) {
                NSLog(@"Uh oh. The user cancelled the Facebook login.");
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:@"Uh oh. The user cancelled the Facebook login." delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            } else {
                NSLog(@"Uh oh. An error occurred: %@", error);
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Log In Error" message:[error description] delegate:nil cancelButtonTitle:nil otherButtonTitles:@"Dismiss", nil];
                [alert show];
            }
        } else if (user.isNew) {
            NSLog(@"User with facebook signed up and logged in!");
            FeedTableViewController *feedViewController = [[FeedTableViewController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feedViewController];
            
            [self.navigationController presentViewController:feedNavigationController animated:YES completion:nil];
            
        } else {
            NSLog(@"User with facebook logged in!");
            FeedTableViewController *feedViewController = [[FeedTableViewController alloc] initWithStyle:UITableViewStylePlain];
            UINavigationController *feedNavigationController = [[UINavigationController alloc] initWithRootViewController:feedViewController];
            
            [self.navigationController presentViewController:feedNavigationController animated:YES completion:nil];
        }
    }];
    
    [_activityIndicator startAnimating]; // Show loading indicator until login is finished
}

@end
