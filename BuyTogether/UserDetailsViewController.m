//
//  Copyright (c) 2013 Parse. All rights reserved.

#import "UserDetailsViewController.h"
#import <QuartzCore/QuartzCore.h>
#import "UserInfoTableViewCell.h"

#define UserInfoTableViewCellIdentifier @"UserInfoTableViewCell"

@implementation UserDetailsViewController


#pragma mark - UIViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    
    self.title = @"Profile";
    self.tableView.backgroundColor = [UIColor whiteColor];
    
    // Add logout navigation bar button
    UIBarButtonItem *logoutButton = [[UIBarButtonItem alloc] initWithTitle:@"Log Out" style:UIBarButtonItemStyleBordered target:self action:@selector(logoutButtonTouchHandler:)];
    self.navigationItem.rightBarButtonItem = logoutButton;
    
    // Load table header view from nib
    [[NSBundle mainBundle] loadNibNamed:@"TableHeaderView" owner:self options:nil];
    self.tableView.tableHeaderView = self.headerView;
    
    // Register cell class
    UINib *itemNib = [UINib nibWithNibName:UserInfoTableViewCellIdentifier bundle:nil];
    [self.tableView registerNib:itemNib forCellReuseIdentifier:UserInfoTableViewCellIdentifier];
    
    // Create array for table row titles
    self.rowTitleArray = @[@"Location", @"Gender", @"Date of Birth", @"Relationship"];
    
    // Set default values for the table row data
    self.rowDataArray = [@[@"Not Available", @"Not Available", @"Not Available", @"Not Available"] mutableCopy];
    
    // If the user is already logged in, display any previously cached values before we get the latest from Facebook.
    if ([PFUser currentUser]) {
        [self updateProfile];
    }
    
    // Send request to Facebook
    FBRequest *request = [FBRequest requestForMe];
    [request startWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
        // handle response
        if (!error) {
            // Parse the data received
            NSLog(@"%@",result);
            NSDictionary *userData = (NSDictionary *)result;
            
            NSString *facebookID = userData[@"id"];
            
            NSURL *pictureURL = [NSURL URLWithString:[NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", facebookID]];
            
            
            NSMutableDictionary *userProfile = [NSMutableDictionary dictionaryWithCapacity:7];
            
            if (facebookID) {
                userProfile[@"facebookId"] = facebookID;
            }
            
            if (userData[@"name"]) {
                userProfile[@"name"] = userData[@"name"];
            }
            
            if (userData[@"location"][@"name"]) {
                userProfile[@"location"] = userData[@"location"][@"name"];
            }
            
            if (userData[@"gender"]) {
                userProfile[@"gender"] = userData[@"gender"];
            }
            
            if (userData[@"birthday"]) {
                userProfile[@"birthday"] = userData[@"birthday"];
            }
            
            if (userData[@"relationship_status"]) {
                userProfile[@"relationship"] = userData[@"relationship_status"];
            }
            
            if ([pictureURL absoluteString]) {
                userProfile[@"pictureURL"] = [pictureURL absoluteString];
            }
            
            [[PFUser currentUser] setObject:userProfile forKey:@"profile"];
            [[PFUser currentUser] saveInBackground];
            
            [self updateProfile];
        } else if ([[[[error userInfo] objectForKey:@"error"] objectForKey:@"type"]
                    isEqualToString: @"OAuthException"]) { // Since the request failed, we can check if it was due to an invalid session
            NSLog(@"The facebook session was invalidated");
            [self logoutButtonTouchHandler:nil];
        } else {
            NSLog(@"Some other error: %@", error);
        }
    }];
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    
    self.navigationController.navigationBar.hidden = NO;
}

#pragma mark - NSURLConnectionDataDelegate

/* Callback delegate methods used for downloading the user's profile picture */

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    // As chuncks of the image are received, we build our data file
    [self.imageData appendData:data];
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
    // All data has been downloaded, now we can set the image in the header image view
    self.headerImageView.image = [UIImage imageWithData:self.imageData];
    
    // Add a nice corner radius to the image
    self.headerImageView.layer.cornerRadius = 8.0f;
    self.headerImageView.layer.masksToBounds = YES;
}


#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.rowTitleArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UserInfoTableViewCell *cell = [self.tableView dequeueReusableCellWithIdentifier:UserInfoTableViewCellIdentifier forIndexPath:indexPath];
    
    // Cannot select these cells
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    // Display the data in the table
    cell.itemName.text = [self.rowTitleArray objectAtIndex:indexPath.row];
    cell.itemContent.text = [self.rowDataArray objectAtIndex:indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}


#pragma mark - ()

- (void)logoutButtonTouchHandler:(id)sender {
    // Logout user, this automatically clears the cache
    NSLog(@"%@ %@ %@ %@",self.presentingViewController, self.presentedViewController, self.navigationController, self.navigationController.childViewControllers);
    [PFUser logOut];
    
    // Return to login view controller
    [self.navigationController dismissViewControllerAnimated:YES completion:nil];
}

// Set received values if they are not nil and reload the table
- (void)updateProfile {
    if ([[PFUser currentUser] objectForKey:@"profile"][@"location"]) {
        [self.rowDataArray replaceObjectAtIndex:0 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"location"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"gender"]) {
        [self.rowDataArray replaceObjectAtIndex:1 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"gender"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"birthday"]) {
        [self.rowDataArray replaceObjectAtIndex:2 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"birthday"]];
    }
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"relationship"]) {
        NSLog(@"%@",[[PFUser currentUser] objectForKey:@"profile"][@"relationship"]);
        [self.rowDataArray replaceObjectAtIndex:3 withObject:[[PFUser currentUser] objectForKey:@"profile"][@"relationship"]];
    }
    
    [self.tableView reloadData];
    
    // Set the name in the header view label
    if ([[PFUser currentUser] objectForKey:@"profile"][@"name"]) {
        self.headerNameLabel.text = [[PFUser currentUser] objectForKey:@"profile"][@"name"];
    }
    
    // Download the user's facebook profile picture
    self.imageData = [[NSMutableData alloc] init]; // the data will be loaded in here
    
    if ([[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]) {
        NSURL *pictureURL = [NSURL URLWithString:[[PFUser currentUser] objectForKey:@"profile"][@"pictureURL"]];
        
        NSMutableURLRequest *urlRequest = [NSMutableURLRequest requestWithURL:pictureURL
                                                                  cachePolicy:NSURLRequestUseProtocolCachePolicy
                                                              timeoutInterval:2.0f];
        // Run network request asynchronously
        NSURLConnection *urlConnection = [[NSURLConnection alloc] initWithRequest:urlRequest delegate:self];
        if (!urlConnection) {
            NSLog(@"Failed to download picture");
        }
    }
}

@end
