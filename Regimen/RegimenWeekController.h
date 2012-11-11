//
//  RegimenSecondViewController.h
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AddGoalViewController.h"

@class RegimenWeek;

@interface RegimenWeekController : UIViewController <UITableViewDelegate, UITableViewDataSource, AddGoalViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) RegimenWeek *weeklygoal;

- (IBAction)addItem;

@end
