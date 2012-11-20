//
//  RegimenCell.m
//  Regimen
//
//  Created by Sayem Islam on 11/19/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import <QuartzCore/QuartzCore.h>
#import "RegimenCell.h"

@implementation RegimenCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
