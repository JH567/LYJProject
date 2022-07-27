//
//  LYJTimerViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/25.
//

#import "LYJTimerViewController.h"
#import "LYJTimeLoop.h"

@interface LYJTimerViewController ()
@property (nonatomic, copy) NSString *timerName;
@property (nonatomic, copy) NSString *timerName1;
@property (nonatomic, copy) NSString *timerName2;

@property (nonatomic, weak) UILabel *labTime;
@property (nonatomic, weak) UILabel *labTime1;
@property (nonatomic, weak) UILabel *labTime2;
@end

@implementation LYJTimerViewController

- (void)dealloc {
    NSLog(@"----------->>> %s", __func__);
    [LYJTimeLoop cancelTimeLoop:_timerName];
    [LYJTimeLoop cancelTimeLoop:_timerName1];
    [LYJTimeLoop cancelTimeLoop:_timerName2];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
    
    [self startTimeLoop];
}

- (void)setupUI {
    [self.view addSubview:({
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, 100, 200, 40)];
        labTime.backgroundColor = [UIColor orangeColor];
        _labTime = labTime;
        labTime;
    })];
    
    [self.view addSubview:({
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labTime.frame) + 10, 200, 40)];
        labTime.backgroundColor = [UIColor orangeColor];
        _labTime1 = labTime;
        labTime;
    })];
    
    [self.view addSubview:({
        UILabel *labTime = [[UILabel alloc] initWithFrame:CGRectMake(0, CGRectGetMaxY(_labTime1.frame) + 10, 200, 40)];
        labTime.backgroundColor = [UIColor orangeColor];
        _labTime2 = labTime;
        labTime;
    })];
}


- (void)startTimeLoop {
    
    int num = 73624;
    //    int ww = num / 10000;
    //    int qq = num % 10000 / 1000;
    //    int bb = num % 10000 % 1000 / 100;
    //    int ss = num % 10000 % 1000 % 100 / 10;
    //    int gg = num % 10000 % 1000 % 100 % 10;
    
    int ww = num / 10000 % 10;
    int qq = num / 1000 % 10;
    int bb = num / 100 % 10;
    int ss = num / 10 % 10;
    int gg = num % 10;
    
    NSLog(@"%d万 - %d千 - %d百 - %d十 - %d个 \n\n\n", ww, qq, bb, ss, gg);
    
    
    __weak __typeof(self) weakSelf = self;
    
    
    __block int time = 1637662030;
    _timerName = [LYJTimeLoop timeLoopTodoSomething:^{
        int hours = time / (60*60) % 24;
        int minutes = time % (60*60) / 60;
        int seconds = time % (60*60) % 60;

        //   int hours = time / 60 / 60 % 24;
        //   int minutes = time / 60 % 60;
        //   int seconds = time % 60;
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.labTime.text = [NSString stringWithFormat:@"Time %02d:%02d:%02d", hours, minutes, seconds];
        NSLog(@">>0>>已就诊 - %02d:%02d:%02d, --线程 --> %@", hours, minutes, seconds, [NSThread currentThread]);

        time --;
    } delayTime:0 stepTime:1 repeat:YES mainThread:YES];

    
    __block int time1 = 1637662030;
    _timerName1 = [LYJTimeLoop timeLoopTodoSomething:^{
        int hours = time1 / (60*60) % 24;
        int minutes = time1 % (60*60) / 60;
        int seconds = time1 % (60*60) % 60;
        dispatch_async(dispatch_get_main_queue(), ^{
            __strong __typeof(weakSelf) strongSelf = weakSelf;
            strongSelf.labTime1.text = [NSString stringWithFormat:@"Time %02d:%02d:%02d", hours, minutes, seconds];
        });
        NSLog(@">>1>>已就诊 - %02d:%02d:%02d, --线程 --> %@", hours, minutes, seconds, [NSThread currentThread]);
        time1 --;
    } delayTime:10 stepTime:1 repeat:YES mainThread:NO];
    
    
    __block int time2 = 1637662030;
    _timerName2 = [LYJTimeLoop timeLoopTodoSomething:^{
        int hours = time2 / (60*60) % 24;
        int minutes = time2 % (60*60) / 60;
        int seconds = time2 % (60*60) % 60;
        __strong __typeof(weakSelf) strongSelf = weakSelf;
        strongSelf.labTime2.text = [NSString stringWithFormat:@"Time %02d:%02d:%02d", hours, minutes, seconds];
        NSLog(@">>2>>已就诊 - %02d:%02d:%02d, --线程 --> %@", hours, minutes, seconds, [NSThread currentThread]);
        time2 --;
    } delayTime:5 stepTime:1 repeat:NO mainThread:YES];
}

@end
