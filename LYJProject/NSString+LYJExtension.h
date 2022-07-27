//
//  NSString+LYJExtension.h
//  LYJProject
//
//  Created by LYJ on 2022/1/25.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSString (LYJExtension)

- (CGSize)sizeOfTextWithMaxSize:(CGSize)maxSize font:(UIFont *)font;
+ (CGSize)sizeWithText:(NSString *)text maxSize:(CGSize)maxSize font:(UIFont *)font;


- (BOOL)isEmptyString;
+ (BOOL)isEmptyString:(NSString *)str;



@end

NS_ASSUME_NONNULL_END
