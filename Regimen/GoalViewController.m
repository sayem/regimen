//
//  GoalViewController.m
//  Regimen
//
//  Created by Sayem Islam on 11/10/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "GoalViewController.h"
#import "RegimenGoal.h"

@implementation GoalViewController

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if (self.goalToEdit != nil) {
        self.title = @"Edit Goal";
        self.textField.text = self.goalToEdit.text;
        self.doneBarButton.enabled = YES;
	}
}

- (void)viewDidUnload
{
	[self setTextField:nil];
	[self setDoneBarButton:nil];
    [super viewDidUnload];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.textField becomeFirstResponder];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)cancel
{
    [self.delegate goalViewControllerDidCancel:self];
}

- (IBAction)done
{
    if (self.goalToEdit == nil) {
        NSString *goal = self.textField.text;
        [self.delegate goalViewController:self didFinishAddingGoal:goal];
    } else {
        self.goalToEdit.text = self.textField.text;
        [self.delegate goalViewController:self didFinishEditingGoal:self.goalToEdit];
    }
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    return nil;
}

- (BOOL)textField:(UITextField *)theTextField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    NSString *newText = [theTextField.text stringByReplacingCharactersInRange:
                         range withString:string];
    self.doneBarButton.enabled = ([newText length] > 0);
    return YES;
}

@end
