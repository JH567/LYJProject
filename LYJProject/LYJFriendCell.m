//
//  LYJFriendCell.m
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import "LYJFriendCell.h"
#import "LYJFriend.h"

@implementation LYJFriendCell

+ (instancetype)friendCellWithTableView:(UITableView *)tableView {
    static NSString *CellId = @"LYJFriendCell";
    LYJFriendCell *cell = [tableView dequeueReusableCellWithIdentifier:CellId];
    if (!cell) {
        cell = [[LYJFriendCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellId];
    }
    return cell;
}

- (void)setFriendModel:(LYJFriend *)friendModel {
    _friendModel = friendModel;
    
    self.imageView.image = [UIImage imageNamed: friendModel.icon];
    self.textLabel.text = friendModel.name;
    self.detailTextLabel.text = friendModel.intro;
    
    if (friendModel.isVip) {
        self.textLabel.textColor = UIColor.redColor;
    } else {
        self.textLabel.textColor = UIColor.blackColor;
    }
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
