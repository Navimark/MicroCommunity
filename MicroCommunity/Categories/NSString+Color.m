//
//  NSString+Color.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/10/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "NSString+Color.h"
#import "UIColor+Addition.h"

@implementation NSString (Color)

- (UIColor *)toColor
{
    return [UIColor colorWithHexText:self];
}

@end
