//
//  AddGoalViewController.h
//  Regimen
//
//  Created by Sayem Islam on 11/10/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AddGoalViewController;
@class RegimenGoal;
@protocol AddGoalViewControllerDelegate <NSObject>

- (void)addGoalViewControllerDidCancel:(AddGoalViewController *)controller;

- (void)addGoalViewController:(AddGoalViewController *)controller didFinishAddingItem:(RegimenGoal *)item;

- (void)addGoalViewController:(AddGoalViewController *)controller didFinishEditingItem:(RegimenGoal *)item;

@end


@interface AddGoalViewController : UITableViewController <UITextFieldDelegate>
@property (strong, nonatomic) IBOutlet UITextField *textField;
@property (strong, nonatomic) IBOutlet UIBarButtonItem *doneBarButton;
@property (nonatomic, weak) id <AddGoalViewControllerDelegate> delegate;
@property (nonatomic, strong) RegimenGoal *itemToEdit;


- (IBAction)cancel;
- (IBAction)done;

@end
