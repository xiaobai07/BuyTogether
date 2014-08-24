//
//  FeedWebViewController.m
//  BuyTogether
//
//  Created by Zeng Wang on 8/24/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "FeedWebViewController.h"

@interface FeedWebViewController ()
@property (strong, nonatomic) UIActivityIndicatorView *activityIndicator;
@end

@implementation FeedWebViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
            }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NSURL *url = [NSURL URLWithString:self.link];
    NSURLRequest *request = [NSURLRequest requestWithURL:url];
    [self.webView loadRequest:request];
    
    // right bar button
    UIBarButtonItem *rightBarButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(doneReviewLink)];
    self.navigationItem.rightBarButtonItem = rightBarButton;
    
    self.navigationItem.title = @"Page Review";
    
    // Add activity indicator to imageView
    self.activityIndicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    [self.webView addSubview:self.activityIndicator];
    self.activityIndicator.alpha = 1.0;
    self.activityIndicator.center = self.webView.center;
    [self.view bringSubviewToFront:self.activityIndicator];
    self.activityIndicator.hidesWhenStopped = YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    self.activityIndicator.hidden = NO;
    [self.activityIndicator startAnimating];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self.activityIndicator stopAnimating];
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Error log web page" delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Retry", nil];
    [alertView show];
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        NSURL *url = [NSURL URLWithString:self.link];
        NSURLRequest *request = [NSURLRequest requestWithURL:url];
        [self.webView loadRequest:request];
    }
    else {
        [self dismissViewControllerAnimated:YES completion:nil];
    }
}


- (void)doneReviewLink
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
