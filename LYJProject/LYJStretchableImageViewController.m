//
//  LYJStretchableImageViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/25.
//

#import "LYJStretchableImageViewController.h"
#import "NSString+LYJExtension.h"

#define TextFont [UIFont systemFontOfSize:16.]

@interface LYJStretchableImageViewController ()

@end

@implementation LYJStretchableImageViewController

- (void)dealloc {
    NSLog(@"----->>>> %s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    [self setupUI];
}

- (void)setupUI {
    
    UIButton *btnMessage = [UIButton buttonWithType:UIButtonTypeCustom];
    btnMessage.titleLabel.font = TextFont;
    btnMessage.titleLabel.numberOfLines = 0;
    [self.view addSubview: btnMessage];
    
    
    NSString *text = @"这个通常发生于你在effect里做数据请求并且没有设置effect依赖参数的情况。没有设置依赖，effect会在每次渲染后执行一次，然后在effect中更新了状态引起渲染并再次触发effect。无限循环的发生也可能是因为你设置的依赖总是会改变。你可以通过一个一个移除的方式排查出哪个依赖导致了问题。但是，移除你使用的依赖（或者盲目地使用[]）通常是一种错误的解决方式。你应该做的是解决问题的根源。举个例子，函数可能会导致这个问题，你可以把它们放到effect里，或者提到组件外面，或者用useCallback包一层。useMemo 可以做类似的事情以避免重复生成对象。";
    CGSize textSize = [text sizeOfTextWithMaxSize:CGSizeMake(300, MAXFLOAT) font:TextFont];
    
    UIImage *img = [UIImage imageNamed:@"chat_to_bg_normal"];
    img = [img stretchableImageWithLeftCapWidth: img.size.width / 2 topCapHeight: img.size.height / 3];
    [btnMessage setBackgroundImage:img forState:UIControlStateNormal];

    
#pragma clang diagnostic push
#pragma clang diagnostic ignored "-Wdeprecated-declarations"
    //这里是弃用的属性
    btnMessage.contentEdgeInsets = UIEdgeInsetsMake(15, 20, 15, 20);
#pragma clang diagnostic pop
    
    
    btnMessage.frame = CGRectMake(10, 200, textSize.width + 40, textSize.height + 30);
    [btnMessage setTitle:text forState:UIControlStateNormal];
    [btnMessage setTitleColor:UIColor.blackColor forState:UIControlStateNormal];
   
    
}


@end
