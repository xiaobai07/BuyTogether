//
//  NewEventViewController.h
//  BuyTogether
//
//  Created by xiao bai on 8/23/14.
//  Copyright (c) 2014 yuebai. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface NewEventViewController : UIViewController
@property (strong, nonatomic) IBOutlet UITextField *nameTextField;
@property (strong, nonatomic) IBOutlet UITextField *linkTextField;
@property (strong, nonatomic) IBOutlet UITextField *priceTextField;
@property (strong, nonatomic) IBOutlet UITextField *venmoTextField;
@property (strong, nonatomic) IBOutlet UITextView *descriptionTextView;

@end
