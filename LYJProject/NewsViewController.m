//
//  NewsViewController.m
//  LYJProject
//
//  Created by LYJ on 2021/11/12.
//

#import "NewsViewController.h"

@interface NewsViewController ()
@end

@implementation NewsViewController

- (void)dealloc {
    NSLog(@"----------->>> %s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
    
}

- (void)setupUI {
    [self.view addSubview:({
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, 200, 100);
        btn.center = self.view.center;
        btn.backgroundColor = UIColor.redColor;
        [btn setTitle:@"NewsViewController" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoNextPage:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
}

- (IBAction)gotoNextPage:(UIButton *)sender {
    NSLog(@"------>>>>>>%@\n", self.navigationController.viewControllers);
    [self.navigationController pushViewController:[[NSClassFromString(@"MainViewController") alloc] init] animated:YES];
}

@end
