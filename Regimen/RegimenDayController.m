//
//  RegimenFirstViewController.m
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
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegimenGoal"];
    
    
    /*
     
     _tableView.backgroundColor = [UIColor colorWithRed: 220.0 / 255 green: 220.0 / 255 blue: 220.0 / 255 alpha:1.0];
     
     UILabel *label;
     CGRect tableRect;
     CGRect labelRect;
     CGFloat x, y, w, h, labelMargin;
     
     tableRect = [tableView rectForRowAtIndexPath:indexPath];
     
     // Set whatever margin around the label you prefer.
     labelMargin = 10;
     
     // Determine rect values for the label.
     x = tableRect.origin.x + labelMargin;
     
     // Calculate width of label
     w = tableRect.size.width - (labelMargin * 2);
     
     // Calculate height of table based on font set earlier.
     h = cell.bounds.size.height;
     
     // Calculate y position for the label text baseline to center
     // vertically within the cell.
     y = (tableRect.origin.y / 2) - (h / 4);
     
     //    labelRect = CGRectMake(x, y, w, h);
     
     const float LABEL_LEFT_MARGIN = 15.0f;
     
     labelRect = CGRectMake(0, 0, 310,48);
     
     label = [[UILabel alloc] initWithFrame:labelRect];
     
     label.text = goal.text;
     [cell.contentView addSubview:label];
     
     */

    RegimenGoal *goal = [_goals objectAtIndex:indexPath.row];
    [self configureTextForCell:cell withRegimenGoal:goal];
    
    return cell;
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    int lastRow = [_goals count] - 1;
    NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:lastRow inSection:0];
    [tableView moveRowAtIndexPath:indexPath toIndexPath:lastRowIndex];

    
/*
    [_goals removeObjectAtIndex:indexPath.row];
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [tableView deleteRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
*/


}




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




/*

-(UIColor*)colorForIndex:(NSInteger) index {
    NSUInteger goalCount = _goals.count - 1;
    float val = ((float)index / (float)goalCount) * 0.6;
    return [UIColor colorWithRed: 1.0 green:val blue: 0.0 alpha:1.0];
}
 
#pragma mark - UITableViewDataDelegate protocol methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 50.0f;
}

 */



-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    cell.backgroundColor = [UIColor colorWithRed: 238.0 / 255 green:238.0 / 255 blue: 238.0 / 255 alpha:1.0];
    
    [cell.layer setBorderWidth: 2.0];
    [cell.layer setMasksToBounds:YES];
    [cell.layer setBorderColor:[[UIColor whiteColor] CGColor]];
}


@end
