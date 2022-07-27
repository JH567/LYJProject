//
//  LYJPickerFlagViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import "LYJPickerFlagViewController.h"
#import "LYJFlag.h"
#import "LYJFlagView.h"

@interface LYJPickerFlagViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, strong) NSArray *flags;

@end

@implementation LYJPickerFlagViewController

- (NSArray *)flags {
    if (!_flags) {
        NSArray *dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"03flags.plist" ofType:nil]];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dataArr.count];
        for (NSDictionary *dict in dataArr) {
            LYJFlag *model = [LYJFlag flagWithDict:dict];
            [arrM addObject:model];
        }
        _flags = arrM;
    }
    return _flags;
}

- (void)dealloc {
    NSLog(@"--------->>>> %s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 300)];
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;

    //默认选中
    [self pickerView:_pickerView didSelectRow:0 inComponent:0];
    
}

//!MARK: - ---- <UIPickerViewDelegate>
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    NSLog(@"------component:%ld --- row:%ld",component, row);
}


- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {
    LYJFlagView *flagView = [LYJFlagView flagView];
    flagView.frame = CGRectMake(0, 0, kScreenWidth, [LYJFlagView rowHeight]);
    flagView.flag = self.flags[row];
    return flagView;
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    return [LYJFlagView rowHeight];
}


//!MARK: - ---- <UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 1;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    return self.flags.count;

}

@end
