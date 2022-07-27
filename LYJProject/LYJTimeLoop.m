//
//  LYJTimeLoop.m
//  MocirePatient
//
//  Created by LYJ on 2021/11/11.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import "LYJTimeLoop.h"

/**
//1、创建一个信号量，初始为1
dispatch_semaphore_t semaphore = dispatch_semaphore_create(1);
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);
dispatch_semaphore_signal(semaphore);


//1、创建一个信号量，初始为0
dispatch_semaphore_t semaphore = dispatch_semaphore_create(0);
dispatch_semaphore_signal(semaphore);
dispatch_semaphore_wait(semaphore, DISPATCH_TIME_FOREVER);


dispatch_semaphore_create：创建一个信号量（semaphore）
dispatch_semaphore_signal：信号通知，即让信号量+1
dispatch_semaphore_wait：等待，直到信号量大于0时，即可操作，同时将信号量-1

*/



static NSMutableDictionary *timers_;
dispatch_semaphore_t semaphore_;

@implementation LYJTimeLoop


+ (void)initialize {
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        timers_ = [NSMutableDictionary dictionary];
        semaphore_ = dispatch_semaphore_create(1);
    });
}

+ (NSString *)timeLoopTodoSomething:(void (^)(void))todoBlock delayTime:(NSTimeInterval)delayTime stepTime:(NSTimeInterval)stepTime repeat:(BOOL)repeat mainThread:(BOOL)mainThread {

    // 当需要重复执行时，重复间隔时间必须 > 0
    if (!todoBlock || delayTime < 0 || (stepTime <=0 && repeat)) return nil;
    
    dispatch_queue_t queue = mainThread ? dispatch_get_main_queue() : dispatch_get_global_queue(0, 0);

    dispatch_source_t timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
    
    // 定时器的唯一标识
    NSString *timerName = [NSString stringWithFormat:@"%zd", timers_.count];
    if (![self safeTimerName:timerName]) [self safeSetTimerValue:timer key:timerName];
    
    dispatch_source_set_timer(timer, dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delayTime * NSEC_PER_SEC)), (int64_t)(stepTime * NSEC_PER_SEC), 0);
    
    dispatch_source_set_event_handler(timer, ^{
        todoBlock();
        // 不重复 - 只执行一次
        if (!repeat) [self cancelTimeLoop:timerName];
    });

    dispatch_resume(timer);
    
    return timerName;
}

+ (void)cancelTimeLoop:(NSString *)timerName {
    if (!timerName || timerName.length <= 0) return;
    dispatch_source_t timer = [self safeTimerName:timerName];
    if (timer) {
        dispatch_source_cancel(timer);
        [timers_ removeObjectForKey:timerName];
    }
}


//!MARK: - 线程安全 - 存取值
+ (id)safeTimerName:(NSString *)key {
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    NSString *value = timers_[key];
    dispatch_semaphore_signal(semaphore_);
    return value;
}

+ (void)safeSetTimerValue:(id)value key:(NSString *)key {
    dispatch_semaphore_wait(semaphore_, DISPATCH_TIME_FOREVER);
    timers_[key] = value;
    dispatch_semaphore_signal(semaphore_);
}
@end
