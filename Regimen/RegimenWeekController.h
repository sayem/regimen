//
//  RegimenSecondViewController.h
//  Regimen
//
//  Created by Sayem Islam on 10/3/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "GoalViewController.h"

@interface RegimenWeekController : UIViewController <UITableViewDelegate, UITableViewDataSource, GoalViewControllerDelegate>

@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
