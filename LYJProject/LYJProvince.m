//
//  LYJProvince.m
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import "LYJProvince.h"

@implementation LYJProvince

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)provinceWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
