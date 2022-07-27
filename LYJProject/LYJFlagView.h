//
//  LYJFlagView.h
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@class LYJFlag;
@interface LYJFlagView : UIView

@property (nonatomic, strong) LYJFlag *flag;

+ (instancetype)flagView;

+ (CGFloat)rowHeight;

@end

NS_ASSUME_NONNULL_END
