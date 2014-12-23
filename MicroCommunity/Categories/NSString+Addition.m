//
//  NSString+Addition.m
//  AnyCheckMobile
//
//  Created by IOS－001 on 14-4-25.
//  Copyright (c) 2014年 e-techco Group. All rights reserved.
//

#import "NSString+Addition.h"

@implementation NSString (Addition)

+ (BOOL)isNullOrNilOrEmpty:(NSString *)string
{
    if (!string) {
        return YES;
    } else if ([string isKindOfClass:[NSNull class]]) {
        return YES;
    } else if ([string isKindOfClass:[NSString class]] && [string length] == 0) {
        return YES;
    } else {
        return NO;
    }
}

+ (NSString *)realForString:(NSString *)value
{
    if (!value || [value isKindOfClass:[NSNull class]]) {
        return @"";
    } else if ([value isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%@",value];
    } else {
        return value;
    }
}

- (BOOL)isContainSubString:(NSString *)subString
{
    return ([self rangeOfString:subString].location != NSNotFound);
}

- (BOOL)isMobilePhoneNumber
{
//    ^1[3,4,5,8]\\d{9}$
    NSPredicate *mobilePredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", @"^((13[0-9])|(15[^4,\\D])|(14[57])|(17[0])|(18[0,0-9]))\\d{8}$"];
    BOOL result = [mobilePredicate evaluateWithObject:self];
    return result;
}

- (BOOL)isE_Mail
{
    NSString *emailRegex = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    return [emailTest evaluateWithObject:self];
}

- (BOOL)isIdentityCardNumber
{
    if (self.length <= 0) {
        return NO;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [identityCardPredicate evaluateWithObject:self];
}

- (NSString *)trimBlankAndNewLine
{
    NSString *nnewString = [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceAndNewlineCharacterSet]];
    return nnewString;
}

- (BOOL)isValidPassword
{
    NSString *passWordRegex = @"^[a-zA-Z0-9]{6,20}+$";
    NSPredicate *passWordPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",passWordRegex];
    return [passWordPredicate evaluateWithObject:self];
}

- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString
{
    if (![aString isKindOfClass:[NSString class]]) {
        return NO;
    }
    if ([self compare:aString options:NSCaseInsensitiveSearch] == NSOrderedSame) {
        return YES;
    } else {
        return NO;
    }
}

- (BOOL)hasPrefixCaseInsensitiveToString:(NSString *)aString
{
    if (![aString isKindOfClass:[NSString class]] || self.length < aString.length) {
        return NO;
    }
    BOOL result = NO;
    @autoreleasepool {
        NSString *targetSubString = [self substringToIndex:aString.length];
        result = [targetSubString isCaseInsensitiveEqualToString:aString];
    }
    return result;
}

- (NSString *)stringValue
{
    return self;
}

@end
