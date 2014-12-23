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

- (UIColor *)RGBStringToColor
{
    if (self.length != 16 || ![[self substringToIndex:1] isEqualToString:@"#"]) {
        return [UIColor blackColor];
    }    
    //根据'#0.6120.4350.278'得到RGB颜色
//    #0.612 0.435 0.278
    CGFloat r = [[self substringWithRange:NSMakeRange(1, 5)] floatValue];
    CGFloat g = [[self substringWithRange:NSMakeRange(6, 5)] floatValue];
    CGFloat b = [[self substringWithRange:NSMakeRange(11, 5)] floatValue];
    
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

@end
