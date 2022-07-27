//
//  LYJProxy.h
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

/// 消息转发 - 可避免 NSTimer或者CADisplayLink中 循环引用
@interface LYJProxy : NSProxy
- (instancetype)initWithTarget:(id)target;
+ (instancetype)proxyWithTarget:(id)target;
@end

NS_ASSUME_NONNULL_END
