//
//  LYJTouchEventViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/2/16.
//

#import "LYJTouchEventViewController.h"
#import "LYJTouchView.h"

@interface LYJTouchEventViewController ()
@property (nonatomic, strong) LYJTouchView *tView;
@property (nonatomic, strong) LYJTouchSparkView *sparkView;
@property (nonatomic, strong) LYJGestureNodeView *gestureNodeView;
@end

@implementation LYJTouchEventViewController

- (LYJTouchView *)tView {
    if (!_tView) {
        _tView = [[LYJTouchView alloc] initWithFrame: self.view.bounds];
    }
    return _tView;
}

- (LYJTouchSparkView *)sparkView {
    if (!_sparkView) {
        _sparkView = [[LYJTouchSparkView alloc] initWithFrame: self.view.bounds];
        _sparkView.backgroundColor = UIColor.blackColor;
    }
    return _sparkView;
}

- (LYJGestureNodeView *)gestureNodeView {
    if (!_gestureNodeView) {
        _gestureNodeView = [[LYJGestureNodeView alloc] initWithFrame: self.view.bounds];
        _gestureNodeView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"Home_refresh_bg"]];
    }
    return _gestureNodeView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //[self test_one];
    
    [self test_two];
}

- (void)test_one {
    self.view.backgroundColor = UIColor.whiteColor;
    
    //self.view = self.tView;
    self.view = self.sparkView;
}

- (void)test_two {
    self.view = self.gestureNodeView;
    NSString *passworld = @"048";
    self.gestureNodeView.passworldBlock = ^BOOL(NSString * _Nonnull pwd) {
        if ([passworld isEqualToString: pwd]) return YES;
        return NO;
    };
}

@end
