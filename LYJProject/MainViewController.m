//
//  MainViewController.m
//  LYJProject
//
//  Created by LYJ on 2021/11/12.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)dealloc {
    NSLog(@"----------->>> %s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self.view addSubview:({
        UIButton *btn = [[UIButton alloc] init];
        btn.frame = CGRectMake(0, 0, 200, 100);
        btn.center = self.view.center;
        btn.backgroundColor = UIColor.redColor;
        [btn setTitle:@"MainViewController" forState:UIControlStateNormal];
        [btn addTarget:self action:@selector(gotoNextPage:) forControlEvents:UIControlEventTouchUpInside];
        btn;
    })];
}

- (IBAction)gotoNextPage:(UIButton *)sender {
    /**
     
     <__NSArrayI 0x60000292f2d0>(
     <ViewController: 0x7fcaea70f670>,
     <HomeViewController: 0x7fcaeb309950>,
     <NewsViewController: 0x7fcaea73f960>,
     <MainViewController: 0x7fcaeb108110>
     )
     
     */
    
    [self popToViewControllerWithStackCount: 3];
}

- (void)popToViewControllerWithStackCount:(NSInteger)count {
    if (count == 0) return;
    if (self.navigationController.viewControllers.count > count) {
        NSInteger index = [self.navigationController.viewControllers indexOfObject:self];
        [self.navigationController popToViewController:[self.navigationController.viewControllers objectAtIndex:index - count] animated:YES];
    }
}

@end
