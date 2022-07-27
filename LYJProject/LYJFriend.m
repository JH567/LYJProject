//
//  LYJFriend.m
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import "LYJFriend.h"

@implementation LYJFriend

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)friendWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
