//
//  RegimenTable.h
//  Regimen
//
//  Created by Sayem Islam on 12/5/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegimenTable : UITableView

- (UILabel *) setNav:(NSMutableArray *)goals andCompletedGoals:(NSMutableArray *)completedGoals;

@end
