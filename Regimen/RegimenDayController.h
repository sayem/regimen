//
//  RegimenDayController.h
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalViewController.h"
#import "RegimenCell.h"
#import "RegimenGoal.h"
#import "RegimenTime.h"


@interface RegimenDayController : UIViewController <UITableViewDelegate, UITableViewDataSource, GoalViewControllerDelegate>

@property (strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, strong) NSArray *goals;
@property (nonatomic, strong) NSArray *completedGoals;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, retain) IBOutlet RegimenCell *regimenCell;

- (IBAction)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer;

@end
