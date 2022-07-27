//
//  LYJFriend.h
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYJFriend : NSObject

@property (nonatomic, strong) NSString *icon;

@property (nonatomic, copy) NSString *intro;

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign, getter=isVip) BOOL vip;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)friendWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
