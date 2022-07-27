//
//  LYJProxy.m
//  LYJProject
//
//  Created by LYJ on 2022/2/20.
//

#import "LYJProxy.h"

@interface LYJProxy ()
@property (nonatomic, weak, readonly) id target;
@end

@implementation LYJProxy

- (instancetype)initWithTarget:(id)target {
    _target = target;
    return self;
}

+ (instancetype)proxyWithTarget:(id)target {
    return [[self alloc] initWithTarget:target];
}

//!MARK: -- 获得方法签名
- (NSMethodSignature *)methodSignatureForSelector:(SEL)sel {
    return [self.target methodSignatureForSelector:sel];
}

//!MARK: -- 改变调用对象,让消息实际上发给真正的实现这个方法的类
- (void)forwardInvocation:(NSInvocation *)invocation {
    SEL sel = [invocation selector];
    if ([self.target respondsToSelector:sel]) {
        [invocation invokeWithTarget:self.target];
    }
}



@end
