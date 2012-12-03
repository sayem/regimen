//
//  RegimenCell.h
//  Regimen
//
//  Created by Sayem Islam on 11/19/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RegimenCell : UITableViewCell 

@property (nonatomic, retain) UILabel *label;

- (void) formatCell: (NSInteger)section;

@end
