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


@interface RegimenDayController ()

@end

@implementation RegimenDayController {
    NSMutableArray* _goals;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _goals = [[NSMutableArray alloc] initWithCapacity:20];
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [self.tableView addGestureRecognizer:leftRecognizer];

    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [self.tableView addGestureRecognizer:rightRecognizer];
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    
    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:[formatter stringFromDate:now]];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_goals count];
}

- (void)configureTextForCell:(UITableViewCell *)cell withRegimenGoal:(RegimenGoal *)goal
{
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    label.text = goal.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegimenCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegimenGoal"];
    
    RegimenGoal *goal = [_goals objectAtIndex:indexPath.row];
    [self configureTextForCell:cell withRegimenGoal:goal];
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    cell.backgroundColor = [UIColor colorWithRed: 233.0 / 255 green:233.0 / 255 blue: 233.0 / 255 alpha:1.0];
    [cell.layer setBorderWidth: 2.0];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}

- (void)addGoalViewControllerDidCancel:(AddGoalViewController *)controller
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addGoalViewController:(AddGoalViewController *)controller didFinishAddingItem:(RegimenGoal *)goal
{
    int newRowIndex = [_goals count];
    [_goals addObject:goal];
    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:newRowIndex inSection:0];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    
    [self.tableView insertRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([segue.identifier isEqualToString:@"AddGoal"]) {
        UINavigationController *navigationController = segue.destinationViewController;
        AddGoalViewController *controller = (AddGoalViewController *)
        navigationController.topViewController;
        controller.delegate = self;
    }
}


/*
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int lastRow = [_goals count] - 1;
    NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [tableView moveRowAtIndexPath:indexPath toIndexPath:lastRowIndex];

    [_goals removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}
*/


/*

- (void)tableView:(UITableView *)tableView commitEditingStyle:( UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *) indexPath
{
    int lastRow = [_goals count] - 1;
    NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [tableView moveRowAtIndexPath:indexPath toIndexPath:lastRowIndex];
 
    [_goals removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
}

*/




- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:_tableView];

    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        NSIndexPath *indexPath = [_tableView indexPathForRowAtPoint:location];
        [_goals removeObjectAtIndex:indexPath.row];
        NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
        [_tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
    }
    else {
        NSIndexPath *swipedIndexPath = [_tableView indexPathForRowAtPoint:location];
        int lastRow = [_goals count] - 1;
        NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:lastRow inSection:0];

        UITableViewCell *cell = [_tableView cellForRowAtIndexPath:swipedIndexPath];
        cell.backgroundColor = [UIColor colorWithRed: 245.0 / 255 green:245.0 / 255 blue: 245.0 / 255 alpha:1.0];
    
        [_tableView moveRowAtIndexPath:swipedIndexPath toIndexPath:lastRowIndex];
    }
}


@end
