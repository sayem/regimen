//
//  RegimenDayController.m
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenDayController.h"
#import "RegimenGoal.h"
#import "RegimenCell.h"
#import <QuartzCore/QuartzCore.h>

@implementation RegimenDayController {
    NSMutableArray* _goals;
    NSMutableArray* _completedGoals;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _goals = [[NSMutableArray alloc] initWithCapacity:20];
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];

    _completedGoals = [[NSMutableArray alloc] initWithCapacity:20];
    [_completedGoals addObject:[RegimenGoal goalWithText:@"Completed goal"]];
    [_completedGoals addObject:[RegimenGoal goalWithText:@"Completed goal"]];
    [_completedGoals addObject:[RegimenGoal goalWithText:@"Completed goal"]];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.tableView addGestureRecognizer:leftRecognizer];

    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:rightRecognizer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"calendar.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0,0, 29, 29);
    [button addTarget:self action:@selector(locationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithCustomView:button];

    UINavigationItem *nav = [self navigationItem];
    nav.leftBarButtonItem = btnDone;
    [self setNavTitle];
}

- (void)setNavTitle
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    CGFloat progress = (float)[_completedGoals count] / (float)([_goals count] + [_completedGoals count]);

    NSString *navTitle = [NSString stringWithFormat:@"%@  (%i%%)", [formatter stringFromDate:now], (int)(progress*100)];
    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:navTitle];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    switch (section) {
        case 0:
            return [_goals count];
            break;
        case 1:
            return [_completedGoals count];
            break;
        default:
            return 0;
            break;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d-%d", indexPath.row, indexPath.section];
    RegimenCell *cell = (RegimenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RegimenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    switch (indexPath.section) {
        case 0: {
            RegimenGoal *goal = [_goals objectAtIndex:indexPath.row];
            cell.label.text = goal.text;
            break;
        }
        case 1: {
            RegimenGoal *completedGoal = [_completedGoals objectAtIndex:indexPath.row];
            cell.label.text = completedGoal.text;
            break;
        }
        default:
            break;
    }
    
    [cell formatCell:indexPath.section];
    return cell;
}

- (void)goalViewControllerDidCancel:(GoalViewController *)controller
{
    [self.tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goalViewController:(GoalViewController *)controller didFinishAddingGoal:(RegimenGoal *)goal
{
    int newRowIndex = [_goals count];
    [_goals addObject:goal];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setNavTitle];
}

- (void)goalViewController:(GoalViewController *)controller didFinishEditingGoal:(RegimenGoal *)goal
{
    int index = [_goals indexOfObject:goal];
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    RegimenCell *cell = (RegimenCell *)[self.tableView cellForRowAtIndexPath:indexPath];
    cell.label.text = goal.text;

    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [self.tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddGoal"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        GoalViewController *controller = (GoalViewController *)
        navigationController.topViewController;
        controller.delegate = self;
    } else if ([segue.identifier isEqualToString:@"EditGoal"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        GoalViewController *controller = (GoalViewController *)navigationController.topViewController;
        controller.delegate = self;
        controller.goalToEdit = sender;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0) {
        RegimenCell *cell = (RegimenCell *)[self.tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed: 210.0 / 255 green:210.0 / 255 blue: 210.0 / 255 alpha:1.0];
        cell.label.backgroundColor = [UIColor colorWithRed: 210.0 / 255 green:210.0 / 255 blue: 210.0 / 255 alpha:1.0];
        
        RegimenGoal *goal = [_goals objectAtIndex:indexPath.row];
        [self performSegueWithIdentifier:@"EditGoal" sender:goal];
    }
}

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:_tableView];
    NSIndexPath *swipedIndexPath = [_tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:swipedIndexPath];
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        if (swipedIndexPath.section == 0)
            [_goals removeObjectAtIndex:swipedIndexPath.row];
        else
            [_completedGoals removeObjectAtIndex:swipedIndexPath.row];
        
        NSArray *indexPaths = [NSArray arrayWithObject:swipedIndexPath];
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
        
        for(UIView *subview in [cell subviews]) {
            if(subview.tag == 1) {
                [subview removeFromSuperview];
            }
        }
        
        [self setNavTitle];
    }
    else {
        if (swipedIndexPath.section == 0) {
            RegimenGoal *goal = [_goals objectAtIndex:swipedIndexPath.row];
            [_completedGoals addObject:goal];
            
            int newRowIndex = [_completedGoals count] - 1;
            NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRowIndex inSection:1];
            NSMutableArray *newIndexPaths = [NSMutableArray arrayWithObject:newIndex];
            [_tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationFade];

            [_goals removeObjectAtIndex:swipedIndexPath.row];
            NSArray *removeindexPaths = [NSArray arrayWithObject:swipedIndexPath];
            [_tableView deleteRowsAtIndexPaths:removeindexPaths withRowAnimation:UITableViewRowAnimationFade];
            
            for(UIView *subview in [cell subviews]) {
                if(subview.tag == 1) {
                    [subview removeFromSuperview];
                }
            }
            
            [self setNavTitle];
        }
    }
}

@end
