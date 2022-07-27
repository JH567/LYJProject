//
//  LYJDrawViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/28.
//

#import "LYJDrawViewController.h"
#import "LYJDrawView.h"

@interface LYJDrawViewController ()
@property (nonatomic, strong) LYJDrawView *drawView;
@end

@implementation LYJDrawViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    [self.view addSubview:self.drawView];
    
    //[self drawImageAsPattern];
    
    
}

- (void)drawImageAsPattern {
    self.drawView.frame = self.view.bounds;
    self.view = self.drawView;
}


#pragma mark -------------懒加载-------------
- (LYJDrawView *)drawView {
    if (!_drawView) {
        _drawView = [[LYJDrawView alloc] init];
        _drawView.backgroundColor = UIColor.cyanColor;
        _drawView.center = self.view.center;
        _drawView.bounds = CGRectMake(0, 0, kScreenWidth - 20, kScreenWidth -20);
    }
    return _drawView;
}

@end
