//
//  NewEventViewController.m
//  BuyTogether
//
//  Created by xiao bai on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import "NewEventViewController.h"

@interface NewEventViewController ()

@end

@implementation NewEventViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    UIBarButtonItem *profileBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Post" style:UIBarButtonItemStyleBordered target:self action:@selector(post)];
    self.navigationItem.rightBarButtonItem = profileBarButton;
    UIBarButtonItem *leftBarButton = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStyleBordered target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = leftBarButton;
    self.navigationItem.title = @"New Post";
    // Do any additional setup after loading the view from its nib.
}

- (void)post
{
    PFObject *dealObject = [PFObject objectWithClassName:@"dealObject"];
    dealObject[@"name"] = self.nameTextField.text;
    dealObject[@"link"] = self.linkTextField.text;
    dealObject[@"minprice"] = self.priceTextField.text;
    dealObject[@"description"] = self.descriptionTextView.text;
    dealObject[@"venmo"] = self.venmoTextField.text;
    [dealObject saveInBackground];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (void)cancel
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
