//
//  RegimenDayController.m
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenDayController.h"
#import <QuartzCore/QuartzCore.h>


@implementation RegimenDayController {
    
    NSMutableArray* _completedGoals;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error;
    
	if (![[self fetchedResultsController] performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);
	}
    
    
    /*
     _goals = [[NSMutableArray alloc] initWithCapacity:20];
    
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];
    [_goals addObject:[RegimenGoal goalWithText:@"Finish Regimen app"]];
     */
    
//        NSManagedObjectContext *context = [self managedObjectContext];


    
/*

    RegimenTime *dayTime = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenTime" inManagedObjectContext:context];
    
    dayTime.duration = @"Day";
    
    RegimenTime *weekTime = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenTime" inManagedObjectContext:context];
    
    weekTime.duration = @"Week";
    
    NSFetchRequest *dayRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *dayEntity = [NSEntityDescription entityForName:@"RegimenTime" inManagedObjectContext:context];
    [dayRequest setEntity:dayEntity];
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"duration == %@", @"Day"];
    [dayRequest setPredicate:dayPredicate];
    
    NSArray *fetchedObjects = [context executeFetchRequest:dayRequest error:&error];
    RegimenTime *timeDay = [fetchedObjects objectAtIndex:0];



    RegimenGoal *daygoal1 = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenGoal" inManagedObjectContext:context];
    
    daygoal1.text = @"yo man";
    daygoal1.dateCreated = [NSDate date];
    daygoal1.completed = [NSNumber numberWithBool:YES];
    daygoal1.time = timeDay;

    RegimenGoal *daygoal2 = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenGoal" inManagedObjectContext:context];
    
    daygoal2.text = @"testing out 2";
    daygoal2.dateCreated = [NSDate date];
    daygoal2.completed = [NSNumber numberWithBool:YES];
    daygoal2.time = timeDay;
 
    [context save:&error];
*/

    
/*

    NSFetchRequest *dayRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *dayEntity = [NSEntityDescription entityForName:@"RegimenGoal" inManagedObjectContext:context];
    [dayRequest setEntity:dayEntity];
    
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"time.duration == %@", @"Day"];
    [dayRequest setPredicate:dayPredicate];
    
    NSSortDescriptor *sort = [[NSSortDescriptor alloc] initWithKey:@"dateCreated" ascending:YES];
    [dayRequest setSortDescriptors:[NSArray arrayWithObject:sort]];
    
    NSArray *fetchedObjects = [context executeFetchRequest:dayRequest error:&error];

*/
    
    
//    RegimenTime *timeDay = [fetchedObjects objectAtIndex:0];

    
//    _goals = [timeDay.goals allObjects];

 
    
//    NSLog(@"%i", [_goals count]);

    
    // completed goals
    
    
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_tableView addGestureRecognizer:leftRecognizer];

    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [_tableView addGestureRecognizer:rightRecognizer];

    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"calendar.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0,0, 29, 29);
    [button addTarget:self action:@selector(locationButtonTapped:) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithCustomView:button];

    UINavigationItem *nav = [self navigationItem];
    nav.leftBarButtonItem = btnDone;
    
    [self setNavTitle];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    self.fetchedResultsController = nil;
}

- (void)setNavTitle
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d"];
    NSString *date = [formatter stringFromDate:now];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];

    /*
    
    if ([_goals count] + [_completedGoals count] > 0) {
        NSInteger progress = ((float)[_completedGoals count] / (float)([_goals count] + [_completedGoals count]))*100;

        NSString *navTitle = [NSString stringWithFormat:@"%@  (%i%%)", date, progress];
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:navTitle];
        
        NSInteger progressStart = date.length + 2;
        NSInteger progressEnd = navTitle.length - progressStart;
        float colorVal = ((float) progress / 100.0);
    
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, progressStart)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, progressStart)];
        
        if (progress < 50) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 1.0 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
        }
        else {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 0.5 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
        }
        
        label.attributedText = str;
    }
    else {
        NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:date];
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, date.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, date.length)];
        label.attributedText = str;
    }
     
     
    */
    
    self.navigationItem.titleView = label;
    [label sizeToFit];
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
    return [[_fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = nil;
    sectionInfo = [[_fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(RegimenCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RegimenGoal *goal = [_fetchedResultsController objectAtIndexPath:indexPath];
    cell.label.text = goal.text;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *CellIdentifier = [NSString stringWithFormat:@"%d-%d", indexPath.row, indexPath.section];
    RegimenCell *cell = (RegimenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RegimenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
    [cell formatCell:indexPath.section];
    return cell;
}

- (void)goalViewControllerDidCancel:(GoalViewController *)controller
{
    [_tableView reloadData];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)goalViewController:(GoalViewController *)controller didFinishAddingGoal:(NSString *)goal
{
    NSError *error;
    
    NSFetchRequest *dayRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *dayEntity = [NSEntityDescription entityForName:@"RegimenTime" inManagedObjectContext:_managedObjectContext];
    [dayRequest setEntity:dayEntity];
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"duration == %@", @"Day"];
    [dayRequest setPredicate:dayPredicate];
    
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:dayRequest error:&error];
    RegimenTime *timeDay = [fetchedObjects objectAtIndex:0];
    
    RegimenGoal *addGoal = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenGoal" inManagedObjectContext:_managedObjectContext];
    addGoal.text = goal;
    addGoal.dateCreated = [NSDate date];
    addGoal.time = timeDay;

    [addGoal.managedObjectContext save:&error];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setNavTitle];
}

- (void)goalViewController:(GoalViewController *)controller didFinishEditingGoal:(RegimenGoal *)goal
{
    
/*
    
    int index = [_fetch indexOfObject:goal];
    
    
    RegimenGoal *goal = [_fetchedResultsController objectAtIndexPath:indexPath];

    
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    RegimenCell *cell = (RegimenCell *)[_tableView cellForRowAtIndexPath:indexPath];

    
    
    cell.label.text = goal.text;

    
    
    NSArray *indexPaths = [NSArray arrayWithObject:indexPath];
    [_tableView reloadRowsAtIndexPaths:indexPaths withRowAnimation:UITableViewRowAnimationAutomatic];
 
*/
 
    
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
        RegimenCell *cell = (RegimenCell *)[_tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed: 210.0 / 255 green:210.0 / 255 blue: 210.0 / 255 alpha:1.0];
        cell.label.backgroundColor = [UIColor colorWithRed: 210.0 / 255 green:210.0 / 255 blue: 210.0 / 255 alpha:1.0];
        
        RegimenGoal *goal = [_fetchedResultsController objectAtIndexPath:indexPath];
        [self performSegueWithIdentifier:@"EditGoal" sender:goal];
    }
}

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:_tableView];
    NSIndexPath *swipedIndexPath = [_tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:swipedIndexPath];
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
        
        /*
        
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
         
        */
        
        [self setNavTitle];
    }
    else {
        if (swipedIndexPath.section == 0) {
            RegimenGoal *goal = [_fetchedResultsController objectAtIndexPath:swipedIndexPath];
            
//            [_completedGoals addObject:goal];
            
            int newRowIndex = [_completedGoals count] - 1;
            NSIndexPath *newIndex = [NSIndexPath indexPathForRow:newRowIndex inSection:1];
            NSMutableArray *newIndexPaths = [NSMutableArray arrayWithObject:newIndex];
            [_tableView insertRowsAtIndexPaths:newIndexPaths withRowAnimation:UITableViewRowAnimationFade];

//            [_goals removeObjectAtIndex:swipedIndexPath.row];
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

- (NSFetchedResultsController *)fetchedResultsController {
    
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *dayRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *dayEntity = [NSEntityDescription entityForName:@"RegimenGoal" inManagedObjectContext:_managedObjectContext];
    [dayRequest setEntity:dayEntity];
 
    NSPredicate *dayPredicate = [NSPredicate predicateWithFormat:@"time.duration == %@", @"Day"];
    [dayRequest setPredicate:dayPredicate];
 
    NSSortDescriptor *daySort = [[NSSortDescriptor alloc] initWithKey:@"dateCreated" ascending:YES];
    [dayRequest setSortDescriptors:[NSArray arrayWithObject:daySort]];

    [dayRequest setFetchBatchSize:20];
 
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:dayRequest
                                        managedObjectContext:_managedObjectContext sectionNameKeyPath:@"completed"
                                                   cacheName:@"Root"];
    
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller is about to start sending change notifications, so prepare the table view for updates.
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
    
    UITableView *tableView = self.tableView;
    
    switch(type) {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:(RegimenCell *)[_tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray
                                               arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray
                                               arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id)sectionInfo atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
    NSIndexSet *set = [NSIndexSet indexSetWithIndex:sectionIndex];
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:set withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:set withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // The fetch controller has sent all current change notifications, so tell the table view to process all updates.
    [self.tableView endUpdates];
}


@end
