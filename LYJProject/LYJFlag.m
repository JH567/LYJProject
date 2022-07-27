//
//  LYJFlag.m
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import "LYJFlag.h"

@implementation LYJFlag
- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}
+ (instancetype)flagWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}
@end
