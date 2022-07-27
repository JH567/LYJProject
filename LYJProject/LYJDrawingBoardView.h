//
//  LYJDrawingBoardView.h
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYJDrawingBoardView : UIView
@property (nonatomic, assign) CGFloat lineWidth;
@property (nonatomic, strong) UIColor *lineColor;
/// 清屏
- (void)clearScreen;
/// 回退
- (void)backOff;
/// 橡皮
- (void)rubber;
@end

NS_ASSUME_NONNULL_END
