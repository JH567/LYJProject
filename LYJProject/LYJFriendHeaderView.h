//
//  LYJFriendHeaderView.h
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@class LYJGroup, LYJFriendHeaderView;

@protocol LYJFriendHeaderViewDelegate <NSObject>
@optional
- (void)friendHeaderViewClickButton:(LYJFriendHeaderView *)headerView;
@end

@interface LYJFriendHeaderView : UITableViewHeaderFooterView

@property (nonatomic, strong) LYJGroup *groupModel;

@property (nonatomic, weak) id <LYJFriendHeaderViewDelegate> delegate;

+ (instancetype)friendHeaderViewWithTableView:(UITableView *)tableView;

@end

NS_ASSUME_NONNULL_END
