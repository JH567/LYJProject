//
//  NSString+LYJExtension.m
//  LYJProject
//
//  Created by LYJ on 2022/1/25.
//

#import "NSString+LYJExtension.h"

@implementation NSString (LYJExtension)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    NSDictionary *attributes = @{NSFontAttributeName: font};
    return [self boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attributes context:nil].size;
}
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font {
    return [text sizeOfTextWithMaxSize:maxSize font:font];
}


- (BOOL)isEmptyString {
    if ([self isKindOfClass:[NSString class]] && [self stringByTrimmingCharactersInSet:[NSCharacterSet whitespaceCharacterSet]].length > 0) {
        return NO;
    } else {
        return YES;
    }
}
+ (BOOL)isEmptyString:(NSString *)str {
    return [str isEmptyString];
}

@end
