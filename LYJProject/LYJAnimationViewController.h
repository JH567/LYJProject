//
//  LYJAnimationViewController.h
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
/**
 
 核心动画：
 1、是layer图层动画
 2、全部在 后台线程 中执行，不会堵塞主线程
 

 //核心动画 - 继承关系
 CAAnimation {
     //属性动画
     CAPropertyAnimation {
         //基础动画
         CABasicAnimation
         //帧动画
         CAKeyframeAnimation
     }
     //组动画
     CAAnimationGroup
     //专场动画
     CATransition
 }
 
 */
@interface LYJAnimationViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
