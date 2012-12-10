//
//  RegimenTable.m
//  Regimen
//
//  Created by Sayem Islam on 12/5/12.
//  Copyright (c) 2012 HatTrick Labs, LLC. All rights reserved.
//

#import "RegimenTable.h"

@implementation RegimenTable

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (UILabel *)setNav:(NSMutableArray *)goals andCompletedGoals:(NSMutableArray *)completedGoals
{
    NSDate *now = [NSDate date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MMM d"];
    NSInteger progress = ((float)[completedGoals count] / (float)([goals count] + [completedGoals count]))*100;
    
    NSString *date = [formatter stringFromDate:now];
    NSString *navTitle = [NSString stringWithFormat:@"%@  (%i%%)", date, progress];
    
    NSInteger progressStart = date.length + 2;
    NSInteger progressEnd = navTitle.length - progressStart;
    
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:navTitle];
    
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:NSMakeRange(0, progressStart)];
    [str addAttribute:NSFontAttributeName value:[UIFont boldSystemFontOfSize:18] range:NSMakeRange(0, progressStart)];
    
    float colorVal = ((float) progress / 100.0);
    
    if (progress < 50) {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 1.0 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
    }
    else {
        [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithRed: 0.5 green:colorVal blue: 0.0 alpha:1.0] range:NSMakeRange(progressStart, progressEnd)];
    }
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectZero];
    label.backgroundColor = [UIColor clearColor];
    label.attributedText = str;
    return label;
}

@end
