//
//  GoalViewController.h
//  Regimen
//
//  Created by Sayem Khan on 11/10/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class GoalViewController;
@class RegimenGoal;

@protocol GoalViewControllerDelegate <NSObject>

- (void)goalViewControllerDidCancel:(GoalViewController *)controller;

- (void)goalViewController:(GoalViewController *)controller didFinishAddingGoal:(NSString *)goal;

- (void)goalViewController:(GoalViewController *)controller didFinishEditingGoal:(RegimenGoal *)goal;

@end

@interface GoalViewController : UITableViewController <UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <GoalViewControllerDelegate> delegate;
@property (nonatomic, strong) RegimenGoal *goalToEdit;

- (IBAction)cancel;
- (IBAction)done;

@end
