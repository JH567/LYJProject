//
//  LYJTimeLoop.h
//  MocirePatient
//
//  Created by LYJ on 2021/11/11.
//  Copyright © 2021 Facebook. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LYJTimeLoop : NSObject
/// 开启 - 事件时间循环
/// @param todoBlock 任务回调
/// @param delayTime 延时时间
/// @param stepTime 时间步长
/// @param repeat 是否重复调用任务
/// @param mainThread 是否在主线程
+ (NSString *)timeLoopTodoSomething:(void(^)(void))todoBlock delayTime:(NSTimeInterval)delayTime stepTime:(NSTimeInterval)stepTime repeat:(BOOL)repeat mainThread:(BOOL)mainThread;

/// 取消 - 事件时间循环
/// @param timerName 事件时间循环标识
+ (void)cancelTimeLoop:(NSString *)timerName;
@end

