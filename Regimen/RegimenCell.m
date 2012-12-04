//
//  RegimenCell.m
//  Regimen
//
//  Created by Sayem Islam on 11/19/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenCell.h"
#import "RegimenGoal.h"
#import <QuartzCore/QuartzCore.h>

@implementation RegimenCell
@synthesize label;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier])
    {
        label = [[UILabel alloc] initWithFrame:CGRectMake(9, 0, 290, 50)];
        label.numberOfLines = 2;
        label.textColor = [UIColor colorWithRed: 102.0 / 255 green:102.0 / 255 blue: 102.0 / 255 alpha:1.0];
        label.font = [UIFont fontWithName:@"Helvetica" size:15.0];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.contentView addSubview:label];
    }
    return self;
}

- (void)formatCell:(NSInteger)section {
    switch (section) {
        case 0: {
            self.contentView.backgroundColor = [UIColor colorWithRed: 233.0 / 255 green:233.0 / 255 blue: 233.0 / 255 alpha:1.0];
            self.label.backgroundColor = [UIColor colorWithRed: 233.0 / 255 green:233.0 / 255 blue: 233.0 / 255 alpha:1.0];
            
            [self.layer setBorderWidth: 2.0];
            [self.layer setMasksToBounds:YES];
            [self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            break;
        }
        case 1: {
            self.contentView.backgroundColor = [UIColor colorWithRed: 247.0 / 255 green:247.0 / 255 blue: 247.0 / 255 alpha:1.0];
            self.label.backgroundColor = [UIColor colorWithRed: 247.0 / 255 green:247.0 / 255 blue: 247.0 / 255 alpha:1.0];
            
            CGFloat x = 7.0;
            CGFloat w = [self.label.text sizeWithFont:[UIFont systemFontOfSize:15.0f]].width;
            CGFloat y = (self.label.frame.size.height / 2);
            
            if (w > 290) {
                UIView *crossoutTop = [[UIView alloc] init];
                crossoutTop.frame = CGRectMake(x, 15, 292, 2);
                crossoutTop.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
                crossoutTop.tag = 1;
                [self.contentView addSubview:crossoutTop];
                
                UIView *crossoutBottom = [[UIView alloc] init];
                CGFloat w2 = (w > 580) ? 292 : w - 265;
                crossoutBottom.frame = CGRectMake(x, 35, w2, 2);
                crossoutBottom.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
                crossoutBottom.tag = 1;
                [self.contentView addSubview:crossoutBottom];
            }
            else {
                UIView *crossout = [[UIView alloc] init];
                crossout.frame = CGRectMake(x, y, w + 5, 2);
                crossout.backgroundColor = [UIColor colorWithRed: 0.0 / 255 green:175.0 / 255 blue: 30.0 / 255 alpha:1.0];
                crossout.tag = 1;
                [self.contentView addSubview:crossout];
            }
            
            [self.layer setBorderWidth: 2.0];
            [self.layer setMasksToBounds:YES];
            [self.layer setBorderColor:[[UIColor whiteColor] CGColor]];
            break;
        }
        default:
            break;
    }
}

@end
