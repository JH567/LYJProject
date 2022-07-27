//
//  LYJGroup.h
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYJGroup : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, assign) NSInteger online;

@property (nonatomic, strong) NSArray *friends;

@property (nonatomic, assign, getter=isFold) BOOL fold;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)groupWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
