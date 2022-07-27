//
//  LYJPickerCityViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/27.
//

#import "LYJPickerCityViewController.h"
#import "LYJProvince.h"

@interface LYJPickerCityViewController () <UIPickerViewDelegate, UIPickerViewDataSource>
@property (nonatomic, weak) UIPickerView *pickerView;
@property (nonatomic, weak) UILabel *lbProvince;
@property (nonatomic, weak) UILabel *lbCity;

@property (nonatomic, strong) NSArray *provinces;
@property (nonatomic, strong) LYJProvince *currentProvince;

@end

@implementation LYJPickerCityViewController

- (NSArray *)provinces {
    if (!_provinces) {
        NSArray *dataArr = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"02cities.plist" ofType:nil]];
        
        NSMutableArray *arrM = [NSMutableArray arrayWithCapacity:dataArr.count];
        for (NSDictionary *dict in dataArr) {
            LYJProvince *provinceModel = [LYJProvince provinceWithDict:dict];
            [arrM addObject:provinceModel];
        }
        _provinces = arrM;
    }
    return _provinces;
}

- (void)dealloc {
    NSLog(@"--------->>>> %s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UIColor.whiteColor;
    
    
    
    UIPickerView *pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, SafeAreaTopHeight, kScreenWidth, 300)];
    pickerView.backgroundColor = UIColor.cyanColor;
    pickerView.delegate = self;
    pickerView.dataSource = self;
    [self.view addSubview:pickerView];
    _pickerView = pickerView;
    
    
    UILabel *lbProvince = [[UILabel alloc] initWithFrame:CGRectMake(20, CGRectGetMaxY(pickerView.frame) + 20, 120, 40)];
    lbProvince.backgroundColor = UIColor.lightGrayColor;
    lbProvince.textColor = UIColor.whiteColor;
    lbProvince.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbProvince];
    _lbProvince = lbProvince;
    
    
    UILabel *lbCity = [[UILabel alloc] initWithFrame:CGRectMake(kScreenWidth - 120 - 20, CGRectGetMaxY(pickerView.frame) + 20, 120, 40)];
    lbCity.backgroundColor = UIColor.lightGrayColor;
    lbCity.textColor = UIColor.whiteColor;
    lbCity.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:lbCity];
    _lbCity = lbCity;
    
    
    //默认选中
    [self pickerView:_pickerView didSelectRow:8 inComponent:1];
    
}

//!MARK: - ---- <UIPickerViewDelegate>
- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    if (component == 0) {
        [pickerView reloadComponent:1];
        [pickerView selectRow:0 inComponent:1 animated:YES];
    }
    NSLog(@"------component:%ld --- row:%ld",component, row);
    
//    NSInteger indexPro = [pickerView selectedRowInComponent:0];
//    NSInteger indexCity = [pickerView selectedRowInComponent:1];
//    LYJProvince *model = self.provinces[indexPro];
//    if (model.cities.count <= indexCity) indexCity = 0;
//    NSString *city = model.cities[indexCity];
    
    NSInteger indexCity = [pickerView selectedRowInComponent:1];
    LYJProvince *model = self.currentProvince;
    NSString *city = model.cities[indexCity];
    
    _lbProvince.text = model.name;
    _lbCity.text = city;

}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (component == 0) {
        LYJProvince *model = self.provinces[row];
        return model.name;
    } else {
        //选中第 0 列， 拿到 行 下标
//        NSInteger indexPro = [pickerView selectedRowInComponent:0];
//        LYJProvince *model = self.provinces[indexPro];
//        NSInteger indexCity = row;
//        if (model.cities.count <= indexCity) indexCity = 0;
//        return model.cities[row];
        
        return self.currentProvince.cities[row];
    }
}


//!MARK: - ---- <UIPickerViewDataSource>
- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    return 2;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    if (component == 0) {
        return self.provinces.count;
    } else {
        //选中第 0 列， 拿到 行 下标
        NSInteger indexPro = [pickerView selectedRowInComponent:0];
        LYJProvince *model = self.provinces[indexPro];
        // 缓存当前 省 数据
        self.currentProvince = model;
        return model.cities.count;
    }
}



@end
