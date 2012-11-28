//
//  RegimenDayController.m
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenDayController.h"
#import "RegimenGoal.h"
#import <QuartzCore/QuartzCore.h>

@implementation RegimenDayController {
    NSMutableArray* _goals;
    NSMutableArray* _completedGoals;

    UIBarButtonItem *settingsButton;
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
    
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM dd"];
    
    UINavigationItem *nav = [self navigationItem];
    [nav setTitle:[formatter stringFromDate:now]];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"calendar.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0,0, 29, 29);
    [button addTarget:self action:@selector(locationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithCustomView:button];
    nav.leftBarButtonItem = btnDone;
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
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RegimenGoal"];
    UILabel *label = (UILabel *)[cell viewWithTag:1000];
    
    switch (indexPath.section) {
        case 0: {
            RegimenGoal *goal = [_goals objectAtIndex:indexPath.row];
            label.text = goal.text;
            break;
        }
        case 1: {
            RegimenGoal *completedGoal = [_completedGoals objectAtIndex:indexPath.row];
            label.text = completedGoal.text;
            break;
        }
        default:
            break;

    }
    
    return cell;
}

-(void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {

    switch (indexPath.section) {
        case 0: {
            cell.backgroundColor = [UIColor colorWithRed: 233.0 / 255 green:233.0 / 255 blue: 233.0 / 255 alpha:1.0];
            [cell.layer setBorderWidth: 2.0];
            [cell.layer setMasksToBounds:YES];
            [cell.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            break;
        }
        case 1: {
            cell.backgroundColor = [UIColor colorWithRed: 247.0 / 255 green:247.0 / 255 blue: 247.0 / 255 alpha:1.0];
            
            RegimenGoal *goal = [_completedGoals objectAtIndex:indexPath.row];
            //            goal.completed = YES;

            CGFloat x = 7.0;
            CGFloat w = [goal.text sizeWithFont:[UIFont systemFontOfSize:15.0f]].width;
            CGFloat y = (cell.contentView.frame.size.height / 2);
            
            if (w > 290) {
                UIView *crossoutTop = [[UIView alloc] init];
                crossoutTop.frame = CGRectMake(x, 15, 292, 2);
                crossoutTop.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
                crossoutTop.tag = 1;
                [cell addSubview:crossoutTop];
                
                UIView *crossoutBottom = [[UIView alloc] init];
                CGFloat w2 = (w > 580) ? 292 : w - 280;
                crossoutBottom.frame = CGRectMake(x, 35, w2, 2);
                crossoutBottom.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
                crossoutBottom.tag = 1;
                [cell addSubview:crossoutBottom];
            }
            else {
                UIView *crossout = [[UIView alloc] init];
                crossout.frame = CGRectMake(x, y, w + 5, 2);
                crossout.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
                crossout.tag = 1;
                [cell addSubview:crossout];
            }
            
            [cell.layer setBorderWidth: 2.0];
            [cell.layer setMasksToBounds:YES];
            [cell.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            break;
        }
        default:
            break;
    }
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
    }
    else {
        if (swipedIndexPath.section == 0) {
            RegimenGoal *goal = [_goals objectAtIndex:swipedIndexPath.row];
            [_completedGoals addObject:goal];
            
            int newRowIndex = [_completedGoals count] - 1;
            NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRowIndex inSection:1];
            NSMutableArray *newIndexPaths = [NSMutableArray arrayWithObject:newIndex];
            [_tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationFade];
            
//           [self dismissViewControllerAnimated:YES completion:nil];
            

            [_goals removeObjectAtIndex:swipedIndexPath.row];
            NSArray *removeindexPaths = [NSArray arrayWithObject:swipedIndexPath];
            [_tableView deleteRowsAtIndexPaths:removeindexPaths withRowAnimation:UITableViewRowAnimationFade];
            
            for(UIView *subview in [cell subviews]) {
                if(subview.tag == 1) {
                    [subview removeFromSuperview];
                }
            }


 
/*
        NSIndexPath *lastRowIndex = [NSIndexPath indexPathForRow:lastRow inSection:1];

      [_tableView moveRowAtIndexPath:swipedIndexPath toIndexPath:lastRowIndex];
 
        cell.backgroundColor = [UIColor colorWithRed: 247.0 / 255 green:247.0 / 255 blue: 247.0 / 255 alpha:1.0];
        
//        RegimenGoal *goal = [_goals objectAtIndex:swipedIndexPath.row];
        goal.completed = YES;
        CGFloat x = 7.0;
        CGFloat w = [goal.text sizeWithFont:[UIFont systemFontOfSize:15.0f]].width;
        CGFloat y = (cell.contentView.frame.size.height / 2);
        
        if (w > 290) {
            UIView *crossoutTop = [[UIView alloc] init];
            crossoutTop.frame = CGRectMake(x, 15, 292, 2);
            crossoutTop.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
            crossoutTop.tag = 1;
            [cell addSubview:crossoutTop];
            
            UIView *crossoutBottom = [[UIView alloc] init];
            CGFloat w2 = (w > 580) ? 292 : w - 280;
            crossoutBottom.frame = CGRectMake(x, 35, w2, 2);
            crossoutBottom.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
            crossoutBottom.tag = 1;
            [cell addSubview:crossoutBottom];
        }
        else {
            UIView *crossout = [[UIView alloc] init];
            crossout.frame = CGRectMake(x, y, w + 5, 2);
            crossout.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
            crossout.tag = 1;
            [cell addSubview:crossout];
        }
*/
 
        
        
            
        }
    }
}


@end
