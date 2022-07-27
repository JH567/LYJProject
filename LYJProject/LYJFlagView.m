//
//  LYJFlagView.m
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import "LYJFlagView.h"
#import "LYJFlag.h"

@interface LYJFlagView ()
@property (weak, nonatomic) IBOutlet UILabel *lbName;
@property (weak, nonatomic) IBOutlet UIImageView *imgViewFlag;

@end

@implementation LYJFlagView

+ (instancetype)flagView {
    return [[[NSBundle mainBundle] loadNibNamed:@"LYJFlagView" owner:nil options:nil] lastObject];
}

- (void)setFlag:(LYJFlag *)flag {
    _flag = flag;
    
    self.lbName.text = flag.name;
    self.imgViewFlag.image = [UIImage imageNamed:flag.icon];
    
}

+ (CGFloat)rowHeight {
    return 83.f;
}


@end
