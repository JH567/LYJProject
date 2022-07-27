//
//  LYJFriendCell.h
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LYJFriend;
@interface LYJFriendCell : UITableViewCell

@property (nonatomic, strong) LYJFriend *friendModel;

+ (instancetype)friendCellWithTableView:(UITableView *)tableView;

@end


NS_ASSUME_NONNULL_END
