//
//  RegimenYearController.m
//  Regimen
//
//  Created by Sayem Khan on 10/4/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenYearController.h"
#import <QuartzCore/QuartzCore.h>

@implementation RegimenYearController {
    RegimenTime* _timeYear;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error;
    
	if (![self.fetchedResultsController performFetch:&error]) {
		NSLog(@"Unresolved error %@, %@", error, [error userInfo]);
		exit(-1);
	}
    
    
    // get timeYear object
    
    NSFetchRequest *yearRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *yearEntity = [NSEntityDescription entityForName:@"RegimenTime" inManagedObjectContext:_managedObjectContext];
    [yearRequest setEntity:yearEntity];
    NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"duration == %@", @"Year"];
    [yearRequest setPredicate:yearPredicate];
    NSArray *fetchedObjects = [_managedObjectContext executeFetchRequest:yearRequest error:&error];
    _timeYear = [fetchedObjects objectAtIndex:0];
    
    NSArray *yearGoals = self.fetchedResultsController.fetchedObjects;
    
    if ([yearGoals count] > 0) {
        
        // delete last year's goals
        
        RegimenGoal *checkGoal = [yearGoals objectAtIndex:0];
        
        NSCalendar *cal = [NSCalendar currentCalendar];
        
        NSDateComponents *components = [cal components:( NSHourCalendarUnit | NSMinuteCalendarUnit | NSSecondCalendarUnit | NSDayCalendarUnit |NSMonthCalendarUnit | NSYearCalendarUnit) fromDate:checkGoal.dateCreated];
        [components setHour:-[components hour]];
        [components setMinute:-[components minute]];
        [components setSecond:-[components second]];
        [components setDay:-([components day] - 1)];
        [components setMonth:-([components month] - 1)];
        [components setYear:+1];

        NSDate *yearEnd = [cal dateByAddingComponents:components toDate:checkGoal.dateCreated options:0];
        NSDate *checkNow = [NSDate date];
        
        if ([checkNow compare:yearEnd] == 1) {
            
            NSDateFormatter *formatDate = [[NSDateFormatter alloc] init];
            [formatDate setDateFormat:@"yyyy-MM-dd"];
            
            for (RegimenGoal *deleteGoal in yearGoals) {
                NSString *checkDate = [formatDate stringFromDate:deleteGoal.dateCreated];
                if (![checkDate isEqualToString:@"2012-12-24"]) {
                    [_managedObjectContext deleteObject:deleteGoal];
                }
            }
            
            [_managedObjectContext save:&error];
        }
    }
    else {
        
        // default reminder to add a goal if no goals present
        
        if ([self.fetchedResultsController.fetchedObjects count] == 0) {
            RegimenGoal *noGoals = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenGoal" inManagedObjectContext:_managedObjectContext];
            noGoals.text = @"Add a goal for this year";
            noGoals.dateCreated = [NSDate date];
            noGoals.time = _timeYear;
            
            [noGoals.managedObjectContext save:&error];
        }
    }
    
    
    // swipe gestures, help button, navbar
    
    UISwipeGestureRecognizer *leftRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [leftRecognizer setDirection:(UISwipeGestureRecognizerDirectionLeft)];
    [_tableView addGestureRecognizer:leftRecognizer];
    
    UISwipeGestureRecognizer *rightRecognizer = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(handleSwipeFrom:)];
    [rightRecognizer setDirection:(UISwipeGestureRecognizerDirectionRight)];
    [_tableView addGestureRecognizer:rightRecognizer];
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setBackgroundImage:[UIImage imageNamed:@"calendar.png"] forState:UIControlStateNormal];
    button.frame=CGRectMake(0,0, 29, 29);
    [button addTarget:self action:@selector(regimenInfo) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *btnDone = [[UIBarButtonItem alloc] initWithCustomView:button];
    
    UINavigationItem *nav = [self navigationItem];
    nav.leftBarButtonItem = btnDone;
    
    [self setNavTitle];
}

- (void)regimenInfo {
	RegimenInfoController *controller = [[RegimenInfoController alloc] initWithNibName:@"RegimenInfoController" bundle:nil];
	controller.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    
	[self presentViewController:controller animated:YES completion:nil];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    
    _timeYear = nil;
    self.fetchedResultsController = nil;
}

- (void)setNavTitle
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    NSString *date = [formatter stringFromDate:now];
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    
    int goalsCount; int completedCount;
    
    if (_tableView.numberOfSections > 1) {
        goalsCount = [_tableView numberOfRowsInSection:0];
        completedCount = [_tableView numberOfRowsInSection:1];
    }
    else if (_tableView.numberOfSections == 1) {
        RegimenGoal *goal = [self.fetchedResultsController.fetchedObjects objectAtIndex:0];
        
        if (goal.completed.boolValue) {
            goalsCount = 0;
            completedCount = [_tableView numberOfRowsInSection:0];
        }
        else {
            goalsCount = [_tableView numberOfRowsInSection:0];
            completedCount = 0;
        }
    }
    else {
        goalsCount = 0;
        completedCount = 0;
    }
    
    int totalGoals = goalsCount + completedCount;
    NSMutableAttributedString *str;
    
    if (totalGoals > 0) {
        NSInteger progress = ((float)completedCount / ((float)totalGoals))*100;
        NSString *navTitle = [NSString stringWithFormat:@"%@  (%i%%)", date, progress];
        str = [[NSMutableAttributedString alloc] initWithString:navTitle];
        
        NSInteger progressStart = date.length + 2;
        NSInteger progressEnd = navTitle.length - progressStart;
        float colorVal = ((float) progress / 100.0);
        
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, progressStart)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, progressStart)];
        
        if (progress < 50) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 1.0 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
        }
        else if (progress >= 50 && progress < 75) {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 0.75 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
        }
        else {
            [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 0.5 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
        }
    }
    else {
        str = [[NSMutableAttributedString alloc] initWithString:date];
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, date.length)];
        [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, date.length)];
    }
    
    label.attributedText = str;
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
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (void)configureCell:(RegimenCell *)cell atIndexPath:(NSIndexPath *)indexPath {
    RegimenGoal *goal = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.label.text = goal.text;
    [cell formatCell:goal.completed.intValue];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegimenGoal *goal = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    NSString *CellIdentifier = [NSString stringWithFormat:@"%@", goal.dateCreated];
    RegimenCell *cell = (RegimenCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (cell == nil) {
        cell = [[RegimenCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    [self configureCell:cell atIndexPath:indexPath];
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
    
    RegimenGoal *addGoal = [NSEntityDescription insertNewObjectForEntityForName:@"RegimenGoal" inManagedObjectContext:_managedObjectContext];
    addGoal.text = goal;
    addGoal.dateCreated = [NSDate date];
    addGoal.time = _timeYear;
    
    [addGoal.managedObjectContext save:&error];
    
    [self dismissViewControllerAnimated:YES completion:nil];
    [self setNavTitle];
}

- (void)goalViewController:(GoalViewController *)controller didFinishEditingGoal:(RegimenGoal *)goal
{
    NSError *error;
    [_managedObjectContext save:&error];
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UINavigationController *navigationController = segue.destinationViewController;
    GoalViewController *controller = (GoalViewController *)navigationController.topViewController;
    controller.delegate = self;
    
    if ([segue.identifier isEqualToString:@"EditGoal"]) {
        controller.goalToEdit = sender;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    RegimenGoal *goal = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    if (!goal.completed.boolValue) {
        RegimenCell *cell = (RegimenCell *)[_tableView cellForRowAtIndexPath:indexPath];
        cell.contentView.backgroundColor = [UIColor colorWithRed: 210.0 / 255 green:210.0 / 255 blue: 210.0 / 255 alpha:1.0];
        cell.label.backgroundColor = [UIColor colorWithRed: 210.0 / 255 green:210.0 / 255 blue: 210.0 / 255 alpha:1.0];
        
        [self performSegueWithIdentifier:@"EditGoal" sender:goal];
    }
}

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer {
    CGPoint location = [recognizer locationInView:_tableView];
    NSIndexPath *swipedIndexPath = [_tableView indexPathForRowAtPoint:location];
    UITableViewCell *cell = [_tableView cellForRowAtIndexPath:swipedIndexPath];
    
    NSManagedObjectContext *context = [self.fetchedResultsController managedObjectContext];
    NSError *error;
    
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft) {
		[context deleteObject:[self.fetchedResultsController objectAtIndexPath:swipedIndexPath]];
        [context save:&error];
        
        [self removeSubviews:[cell subviews]];
        [self setNavTitle];
    }
    else {
        RegimenGoal *goal = [self.fetchedResultsController objectAtIndexPath:swipedIndexPath];
        
        if (!goal.completed.boolValue) {
            goal.completed = [NSNumber numberWithBool:YES];
            
            [context save:&error];
            
            [self removeSubviews:[cell subviews]];
            [self setNavTitle];
        }
    }
}

- (void)removeSubviews:(NSArray *)subviews {
    for(UIView *subview in subviews) {
        if(subview.tag == 1) {
            [subview removeFromSuperview];
        }
    }
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController != nil) {
        return _fetchedResultsController;
    }
    
    NSFetchRequest *yearRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *yearEntity = [NSEntityDescription entityForName:@"RegimenGoal" inManagedObjectContext:_managedObjectContext];
    [yearRequest setEntity:yearEntity];
    
    NSPredicate *yearPredicate = [NSPredicate predicateWithFormat:@"time.duration == %@", @"Year"];
    [yearRequest setPredicate:yearPredicate];
    
    NSSortDescriptor *yearSort = [[NSSortDescriptor alloc] initWithKey:@"dateCreated" ascending:YES];
    
    NSSortDescriptor *completeSort = [[NSSortDescriptor alloc] initWithKey:@"completed" ascending:YES];
    
    [yearRequest setSortDescriptors:[NSArray arrayWithObjects:completeSort, yearSort, nil]];
    
    [yearRequest setFetchBatchSize:20];
    
    NSFetchedResultsController *theFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:yearRequest managedObjectContext:_managedObjectContext sectionNameKeyPath:@"completed"cacheName:@"Year"];
    
    self.fetchedResultsController = theFetchedResultsController;
    _fetchedResultsController.delegate = self;
    
    return _fetchedResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
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
    [self.tableView endUpdates];
}


@end
