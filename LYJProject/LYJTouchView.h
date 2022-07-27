//
//  LYJTouchView.h
//  LYJProject
//
//  Created by LYJ on 2022/2/16.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYJTouchView : UIView
@end


@interface LYJTouchSparkView : UIView
@end


@interface LYJGestureNodeView : UIView
@property (nonatomic, copy) BOOL(^passworldBlock)(NSString *);
@end


NS_ASSUME_NONNULL_END
