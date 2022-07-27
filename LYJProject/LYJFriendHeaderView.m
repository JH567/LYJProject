//
//  LYJFriendHeaderView.m
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import "LYJFriendHeaderView.h"
#import "LYJGroup.h"

@interface LYJFriendHeaderView ()
@property (nonatomic, weak) UIButton *btnName;
@property (nonatomic, weak) UILabel *lbTitile;
@end

@implementation LYJFriendHeaderView

+ (instancetype)friendHeaderViewWithTableView:(UITableView *)tableView {
    static NSString *HearFooterId = @"LYJFriendHeaderView";
    LYJFriendHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:HearFooterId];
    if (!headerView) {
        headerView = [[LYJFriendHeaderView alloc] initWithReuseIdentifier:HearFooterId];
    }
    return headerView;
}

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithReuseIdentifier:reuseIdentifier]) {
        
        UIButton *btnName = [UIButton buttonWithType:UIButtonTypeCustom];
        [btnName setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg"] forState:UIControlStateNormal];
        [btnName setBackgroundImage:[UIImage imageNamed:@"buddy_header_bg_highlighted"] forState:UIControlStateHighlighted];
        
        [btnName setImage:[UIImage imageNamed:@"buddy_header_arrow"] forState:UIControlStateNormal];
        
        [btnName setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
        
        btnName.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
        //这里是弃用的属性
        btnName.contentEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
        btnName.titleEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
#pragma clang diagnostic pop
        
        btnName.imageView.contentMode = UIViewContentModeCenter; //内容不变，定位调整
        btnName.imageView.clipsToBounds = NO; // 不裁剪
       
        [btnName addTarget:self action:@selector(clickBtnName:) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:btnName];
        _btnName = btnName;
        
        
        
        
        UILabel *lbTitle = [[UILabel alloc] init];
        lbTitle.textColor = UIColor.blackColor;
        [self.contentView addSubview:lbTitle];
        _lbTitile = lbTitle;
        
    }
    return self;
}

- (void)clickBtnName:(UIButton *)sender {
    
    /**
     给模型扩展一个可折叠属性 fold
     */
    _groupModel.fold = !_groupModel.isFold;
    
    if ([self.delegate respondsToSelector:@selector(friendHeaderViewClickButton:)]) {
        [self.delegate friendHeaderViewClickButton:self];
    }
    
}

- (void)setGroupModel:(LYJGroup *)groupModel {
    _groupModel = groupModel;
    [_btnName setTitle:groupModel.name forState:UIControlStateNormal];
    _lbTitile.text = [NSString stringWithFormat:@"%ld / %ld", groupModel.online, groupModel.friends.count];
    
    if (_groupModel.isFold) {
        _btnName.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
    } else {
        _btnName.imageView.transform = CGAffineTransformIdentity; //CGAffineTransformMakeRotation(0);
    }
    
}

//- (void)didMoveToSuperview {
//    if (_groupModel.isFold) {
//        _btnName.imageView.transform = CGAffineTransformMakeRotation(M_PI_2);
//    } else {
//        _btnName.imageView.transform = CGAffineTransformIdentity;
//    }
//}

- (void)layoutSubviews {
    [super layoutSubviews];
    
    CGRect HeaderFrame = self.bounds;
    _btnName.frame = CGRectMake(0, 0, HeaderFrame.size.width, HeaderFrame.size.height);
    
    CGFloat lbTitleW = 80;
    _lbTitile.frame = CGRectMake(HeaderFrame.size.width - lbTitleW, 0, lbTitleW, HeaderFrame.size.height);
}

@end
