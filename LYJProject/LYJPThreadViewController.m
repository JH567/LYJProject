//
//  LYJPThreadViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/3/1.
//

#import "LYJPThreadViewController.h"
#import <pthread.h>

@interface LYJPThreadViewController ()

@end

@implementation LYJPThreadViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //[self example_one];
    [self example_two];
}

- (void)example_two {
//    {
//        //方式一
//        NSThread *thread = [[NSThread alloc] initWithTarget:self selector:@selector(createThread:) object:@{@"name": @"lyj123"}];
//        [thread start];
//    }
    
//    {
//        //方式二
//        [NSThread detachNewThreadSelector:@selector(createThread:) toTarget:self withObject:@{@"name": @"lyj111"}];
//    }
    
    //方式三
    [self performSelectorInBackground:@selector(createThread:) withObject:@{@"name": @"inBackground"}];
}
- (void)createThread:(id)obj {
    NSLog(@"----->>>> %@ ----->>>> %@", obj, [NSThread currentThread]);
}


- (void)example_one {
    
    /**
     __bridge 桥接作用
     
     与内存管理有关：告诉C或者OC，当前的内存管理不到，需要对方处理
     
     
     
     
     创建一个线程
     int pthread_create(
     pthread_t _Nullable * _Nonnull __restrict,             -线程编号地址
     const pthread_attr_t * _Nullable __restrict,           -线程属性
     void * _Nullable (* _Nonnull)(void * _Nullable),       -执行函数
     void * _Nullable __restrict                            -执行函数的参数
     );
     
     */
    
    //char *params = "lyj";
    NSDictionary *params = @{@"name": @"lyj"};
    pthread_t pthread;
    
    int result = pthread_create(&pthread, NULL, createThread, (__bridge void *)params);
    
    if (result == 0) {
        NSLog(@"创建子线程-成功");
    } else {
        NSLog(@"创建子线程-失败");
    }
}
void *createThread(void *params) {
    NSDictionary *params_ = (__bridge NSDictionary *)params;
    NSLog(@"----->>>> %@ ----->>>> %@", params_, [NSThread currentThread]);
    //NSLog(@"----->>>> %s ----->>>> %@", params, [NSThread currentThread]);
    return NULL;
}









@end
