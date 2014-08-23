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
