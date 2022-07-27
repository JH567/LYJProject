//
//  LYJGroup.m
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import "LYJGroup.h"
#import "LYJFriend.h"

@implementation LYJGroup

- (instancetype)initWithDict:(NSDictionary *)dict {
    if (self = [super init]) {
        [self setValuesForKeysWithDictionary:dict];
        
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict_fried in self.friends) {
            LYJFriend *model = [LYJFriend friendWithDict:dict_fried];
            [arrM addObject:model];
        }
        self.friends = arrM;
    }
    return self;
}

+ (instancetype)groupWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

@end
