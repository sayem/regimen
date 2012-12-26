//
//  RegimenLongTermController.h
//  Regimen
//
//  Created by Sayem Islam on 10/4/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalViewController.h"
#import "RegimenInfoController.h"
#import "RegimenCell.h"
#import "RegimenGoal.h"
#import "RegimenTime.h"

@interface RegimenLongTermController : UIViewController <UITableViewDelegate, UITableViewDataSource, GoalViewControllerDelegate, NSFetchedResultsControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet RegimenCell *regimenCell;

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

@end
