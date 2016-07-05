//
//  NSString+GreedEmoji.m
//  Pods
//
//  Created by Bell on 16/2/23.
//  Copyright © 2016年 GreedLab. All rights reserved.
//

#import "GreedEmoji.h"
#import "NSString+GreedEmoji.h"

@implementation NSString (GreedEmoji)

- (NSString *)emojizedString {
    return [NSString emojizedStringWithString:self];
}

+ (NSString *)emojizedStringWithString:(NSString *)text {
    if (text.length == 0) {
        return text;
    }
    static dispatch_once_t onceToken;
    static NSRegularExpression *regex = nil;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"(:[a-z0-9-+_]+:)" options:NSRegularExpressionCaseInsensitive error:NULL];
    });

    __block NSMutableArray *patchedArray = [[NSMutableArray alloc] init];
    __block NSString *resultText = text;
    NSRange matchingRange = NSMakeRange(0, [resultText length]);
    [regex enumerateMatchesInString:resultText options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
            NSRange range = result.range;
            if (range.location != NSNotFound) {
                NSString *code = [text substringWithRange:range];
                if ([patchedArray indexOfObject:code] == NSNotFound) {
                    [patchedArray addObject:code];
                    NSString *unicode = [NSString aliaseToEmojiDictionary][code];
                    if (unicode) {
                        resultText = [resultText stringByReplacingOccurrencesOfString:code withString:unicode];
                    }
                }
            }
        }
    }];
    return resultText;
}

- (NSString *)aliasedString {
    return [NSString aliasedStringWithString:self];
}

+ (NSString *)aliasedStringWithString:(NSString *)text {
    if (text.length == 0) {
        return text;
    }
    text = [NSString removeStatusText:text];
    NSInteger length = text.length;

    NSString *resultText = text;
    NSMutableArray *mutableArray = [[NSMutableArray alloc] init];
    for (NSInteger index = 0; index < length; index++) {
        if (index < length - 3) {
            NSString *fourString = [text substringWithRange:NSMakeRange(index, 4)];
            if ([mutableArray indexOfObject:fourString] == NSNotFound) {
                [mutableArray addObject:fourString];
                NSString *aliase = [[NSString emojiToAliaseDictionary] objectForKey:fourString];
                if (aliase) {
                    resultText = [resultText stringByReplacingOccurrencesOfString:fourString withString:aliase];
                    continue;
                }
            }
        }

        if (index < length - 1) {
            NSString *doubleString = [text substringWithRange:NSMakeRange(index, 2)];
            if ([mutableArray indexOfObject:doubleString] == NSNotFound) {
                [mutableArray addObject:doubleString];
                NSString *aliase = [[NSString emojiToAliaseDictionary] objectForKey:doubleString];
                if (aliase) {
                    resultText = [resultText stringByReplacingOccurrencesOfString:doubleString withString:aliase];
                    continue;
                }
            }
        }

        NSString *singleString = [text substringWithRange:NSMakeRange(index, 1)];
        if ([mutableArray indexOfObject:singleString] == NSNotFound) {
            [mutableArray addObject:singleString];
            NSString *aliase = [[NSString emojiToAliaseDictionary] objectForKey:singleString];
            if (aliase) {
                resultText = [resultText stringByReplacingOccurrencesOfString:singleString withString:aliase];
            }
        }
    }
    return resultText;
}

#pragma mark - private

+ (NSDictionary *)aliaseToEmojiDictionary {
    static NSDictionary *aliaseToEmojiDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        aliaseToEmojiDictionary = GREED_EMOJI_MAP;
    });
    return aliaseToEmojiDictionary;
}

+ (NSDictionary *)emojiToAliaseDictionary {
    static NSDictionary *_emojiToAliaseDictionary;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        NSArray *emojisArray = [GREED_EMOJI_MAP allValues];
        NSArray *aliasesArray = [GREED_EMOJI_MAP allKeys];
        _emojiToAliaseDictionary = [NSDictionary dictionaryWithObjects:aliasesArray forKeys:emojisArray];
    });
    return _emojiToAliaseDictionary;
}

+ (NSString *)removeStatusText:(NSString *)text {
    static dispatch_once_t onceToken;
    static NSRegularExpression *regex = nil;
    dispatch_once(&onceToken, ^{
        regex = [[NSRegularExpression alloc] initWithPattern:@"[\U0000FE00-\U0000FE0F]" options:NSRegularExpressionCaseInsensitive error:NULL];
    });
    __block NSString *resultText = text;
    NSRange matchingRange = NSMakeRange(0, [resultText length]);
    [regex enumerateMatchesInString:text options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
            NSRange range = result.range;
            if (range.location != NSNotFound) {
                NSString *code = [text substringWithRange:range];
                resultText = [resultText stringByReplacingOccurrencesOfString:code withString:@""];
            }
        }
    }];
    return resultText;
}

#pragma mark - deprecated

+ (NSString *)aaliasedStringWithString:(NSString *)text {
    static dispatch_once_t onceToken;
    static NSRegularExpression *regex = nil;
    dispatch_once(&onceToken, ^{
        // http://stackoverflow.com/questions/24672834/how-do-i-remove-emoji-from-string/29115920#29115920
        NSMutableString *pattern = [[NSMutableString alloc] init];
        [pattern appendString:@"["];
        [pattern appendString:@"[\U0000203C\U00002049\U000020E3\U00002122\U00002139\U00002194-\U00002199\U000021A9-\U000021AA\U0000231A-\U0000231B\U000023E9-\U000023EC\U000023F0\U000023F3\U000024C2\U000025AA-\U000025AB\U000025B6\U000025C0\U000025FB-\U000025FE\U00002600-\U00002601\U0000260E\U00002611\U00002614-\U00002615\U0000261D\U0000263A\U00002648-\U00002653\U00002660\U00002663\U00002665-\U00002666\U00002668\U0000267B\U0000267F\U00002693\U000026A0-\U000026A1\U000026AA-\U000026AB\U000026BD-\U000026BE\U000026C4-\U000026C5\U000026CE\U000026D4\U000026EA\U000026F2-\U000026F3\U000026F5\U000026FA\U000026FD\U00002702\U00002705\U00002708-\U0000270C\U0000270F\U00002712\U00002714\U00002716\U00002728\U00002733-\U00002734\U00002744\U00002747\U0000274C\U0000274E\U00002753-\U00002755\U00002757\U00002764\U00002795-\U00002797\U000027A1\U000027B0\U00002934-\U00002935\U00002B05-\U00002B07\U00002B1B-\U00002B1C\U00002B50\U00002B55\U00003030\U0000303D\U00003297\U00003299\U0001F004\U0001F0CF\U0001F170-\U0001F171\U0001F17E-\U0001F17F\U0001F18E\U0001F191-\U0001F19A\U0001F1E7-\U0001F1EC\U0001F1EE-\U0001F1F0\U0001F1F3\U0001F1F5\U0001F1F7-\U0001F1FA\U0001F201-\U0001F202\U0001F21A\U0001F22F\U0001F232-\U0001F23A\U0001F250-\U0001F251\U0001F300-\U0001F320\U0001F330-\U0001F335\U0001F337-\U0001F37C\U0001F380-\U0001F393\U0001F3A0-\U0001F3C4\U0001F3C6-\U0001F3CA\U0001F3E0-\U0001F3F0\U0001F400-\U0001F43E\U0001F440\U0001F442-\U0001F4F7\U0001F4F9-\U0001F4FC\U0001F500-\U0001F507\U0001F509-\U0001F53D\U0001F550-\U0001F567\U0001F5FB-\U0001F640\U0001F645-\U0001F64F\U0001F680-\U0001F68A]"];
        [pattern appendString:@"]"];
        regex = [[NSRegularExpression alloc] initWithPattern:pattern options:NSRegularExpressionCaseInsensitive error:NULL];
    });

    __block NSMutableArray *patchedArray = [[NSMutableArray alloc] init];
    __block NSString *resultText = text;
    NSRange matchingRange = NSMakeRange(0, [resultText length]);
    [regex enumerateMatchesInString:resultText options:NSMatchingReportCompletion range:matchingRange usingBlock:^(NSTextCheckingResult *result, NSMatchingFlags flags, BOOL *stop) {
        if (result && ([result resultType] == NSTextCheckingTypeRegularExpression) && !(flags & NSMatchingInternalError)) {
            NSRange range = result.range;
            if (range.location != NSNotFound) {
                NSString *code = [text substringWithRange:range];
                if ([patchedArray indexOfObject:code] == NSNotFound) {
                    [patchedArray addObject:code];
                    NSString *unicode = [NSString emojiToAliaseDictionary][code];
                    unicode = unicode ? unicode : @"\U00002753";
                    if (unicode) {
                        resultText = [resultText stringByReplacingOccurrencesOfString:code withString:unicode];
                    }
                }
            }
        }
    }];

    return resultText;
}

@end
