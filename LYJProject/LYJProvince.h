//
//  LYJProvince.h
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface LYJProvince : NSObject

@property (nonatomic, copy) NSString *name;

@property (nonatomic, strong) NSArray *cities;

- (instancetype)initWithDict:(NSDictionary *)dict;
+ (instancetype)provinceWithDict:(NSDictionary *)dict;

@end

NS_ASSUME_NONNULL_END
