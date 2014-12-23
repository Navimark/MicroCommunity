//
//  NSString+Addition.h
//  AnyCheckMobile
//
//  Created by IOS－001 on 14-4-25.
//  Copyright (c) 2014年 e-techco Group. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (Addition)

+ (BOOL)isNullOrNilOrEmpty:(NSString *)string;

+ (NSString *)realForString:(NSString *)value;

- (BOOL)isContainSubString:(NSString *)subString;

- (BOOL)isMobilePhoneNumber;

- (BOOL)isE_Mail;

- (BOOL)isIdentityCardNumber;

- (NSString *)trimBlankAndNewLine;

- (BOOL)isValidPassword;

/**
 *  在忽略大小写时，检查当前串是否与aString相等
 *
 *  @param aString 待比较的串
 *
 *  @return 返回值
 */
- (BOOL)isCaseInsensitiveEqualToString:(NSString *)aString;

/**
 *  在忽略大小写时，检查当前串是否有aString的前缀
 *
 *  @param aString 待比较的串
 *
 *  @return 返回值
 */
- (BOOL)hasPrefixCaseInsensitiveToString:(NSString *)aString;

- (NSString *)stringValue;

@end
