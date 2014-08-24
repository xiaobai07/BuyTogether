//
//  ViewController.m
//  BuyTogether
//
//  Created by xiao bai on 8/22/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    if (![Venmo isVenmoAppInstalled]) {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAPI];
        self.segmentControl.selectedSegmentIndex = 1;
    }
    else {
        [[Venmo sharedInstance] setDefaultTransactionMethod:VENTransactionMethodAppSwitch];
        self.segmentControl.selectedSegmentIndex = 0;
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    [alertView dismissWithClickedButtonIndex:buttonIndex animated:YES];
}

- (IBAction)sendAction:(id)sender {
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
            [query getObjectInBackgroundWithId:self.feedId block:^(PFObject *dealObject, NSError *error) {
                
                // Now let's update it with some new data. In this case, only cheatMode and score
                // will get sent to the cloud. playerName hasn't changed.
                if (dealObject[@"currentprice"]==[NSNull null]) {
                    dealObject[@"currentprice"]= [NSNumber numberWithFloat:[self.priceTextField.text floatValue]];
                }else{
                    float currentprice = [dealObject[@"currentprice"] floatValue];
                    dealObject[@"currentprice"]= [NSNumber numberWithFloat:[self.priceTextField.text floatValue]+currentprice];
                }
                if (dealObject[@"contributor"]==[NSNull null]) {
                    NSArray *namearray = @[[[PFUser currentUser] objectForKey:@"profile"][@"name"]];
                    dealObject[@"contributor"]=namearray;
                }else{
                    NSMutableArray *mutablearray = [[NSMutableArray alloc]init];
                    [mutablearray addObjectsFromArray:dealObject[@"contributor"]];
                    [mutablearray addObject:[[PFUser currentUser] objectForKey:@"profile"][@"name"]];
                }
                [dealObject saveInBackground];
                [[NSNotificationCenter defaultCenter]postNotificationName:@"refresh" object:nil];
                
            }];
        }
    };
    // Payment
    if (self.segmentControl.selectedSegmentIndex == 0) {
        [[Venmo sharedInstance] sendPaymentTo:self.AccountTextFiedl.text
                                       amount:self.priceTextField.text.floatValue*100
                                         note:self.noteTextField.text
                            completionHandler:handler];
    }
    // Request
    else {
        [[Venmo sharedInstance] sendPaymentTo:self.AccountTextFiedl.text
                                       amount:self.priceTextField.text.floatValue*100
                                         note:self.noteTextField.text
                            completionHandler:handler];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    return YES;
}
@end
