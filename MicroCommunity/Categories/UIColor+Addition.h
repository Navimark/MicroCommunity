//
//  UIColor+Addition.h
//  AnyCheckMobile
//
//  Created by IOS－001 on 14-6-6.
//  Copyright (c) 2014年 e-techco Group. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface UIColor (Addition)

+ (UIColor *)flatRandomColor;

+ (UIColor *)brightRandomColor;

+ (UIColor *)colorWithHexString:(NSString *)stringToConvert;

+ (UIColor *)colorWithHexText: (NSString *) hexString;

+ (UIColor *)colorWithRGBHex:(UInt32)hex;

- (UIColor *)darkerColor;

- (UIColor *)lighterColor;

+ (NSString *)flatRandomColorRGBString;

@end
