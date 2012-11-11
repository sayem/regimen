//
//  AddGoalViewController.m
//  Regimen
//
//  Created by Sayem Islam on 11/10/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "AddGoalViewController.h"
#import "RegimenGoal.h"


@interface AddGoalViewController ()

@end

@implementation AddGoalViewController

@synthesize textField;
@synthesize doneBarButton;
@synthesize delegate;

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

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
	[self setTextField:nil];
	[self setDoneBarButton:nil];
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    // Dispose of any resources that can be recreated.
}

- (IBAction)cancel
{
    [self.delegate addGoalViewControllerDidCancel:self];
}

- (IBAction)done
{
    RegimenGoal *item = [[RegimenGoal alloc] init];
    item.text = self.textField.text;
    [self.delegate addGoalViewController:self didFinishAddingItem:item];
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
