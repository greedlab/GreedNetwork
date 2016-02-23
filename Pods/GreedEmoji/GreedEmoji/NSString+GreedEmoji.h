//
//  NSString+GreedEmoji.h
//  Pods
//
//  Created by Bell on 16/2/23.
//  Copyright © 2016年 GreedLab. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (GreedEmoji)

/**
 *  aliased string to apple emoji
 */
- (NSString *)emojizedString;
+ (NSString *)emojizedStringWithString:(NSString *)text;

/**
 *  apple emoji to aliased string
 *
 */
- (NSString *)aliasedString;
+ (NSString *)aliasedStringWithString:(NSString *)text;

@end
