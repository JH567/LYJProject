//
//  ViewController.m
//  LYJProject
//
//  Created by LYJ on 2021/11/12.
//

#import "ViewController.h"

static NSString *CellID = @"UITableViewCell";

@interface ViewController () <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic, strong) NSArray *dataSource;
@end

@implementation ViewController

- (NSArray *)dataSource {
    if (!_dataSource) {
        _dataSource = @[
            @"LYJTimeLoop",
            @"PopToViewControllerWithStackCount",
            @"StretchableImage",
            @"LYJFriendViewController",
            @"LYJKeyboardFrameNotifViewController",
            @"LYJPickerCityViewController",
            @"LYJPickerFlagViewController",
            @"LYJDatePickerViewController",
            @"LYJDrawViewController",
            @"LYJTouchEventViewController",
            @"LYJGestureRecognizerViewController",
            @"LYJCALayerViewController",
            @"LYJAnimationViewController",
            @"LYJDrawingBoardViewController",
            @"LYJDynamicAnimatorViewController",
            @"LYJMaoMaoChongViewController",
            @"愤怒的小鸟",
            @"幸运转盘",
            @"LYJPThreadViewController",
        ];
    }
    return _dataSource;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    _tableView.rowHeight = 44;
    [_tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:CellID];
    
    
}

//!MARK: - ---<UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    //    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID];
    //    if (!cell) {
    //        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellID];
    //    }
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellID forIndexPath:indexPath];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    cell.textLabel.text = [self.dataSource objectAtIndex: indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:
            [self gotoNextPage: @"LYJTimerViewController"];
            break;
        case 1:
            [self gotoNextPage: @"HomeViewController"];
            break;
        case 2:
            [self gotoNextPage: @"LYJStretchableImageViewController"];
            break;
        case 3:
            [self gotoNextPage: @"LYJFriendViewController"];
            break;
        case 4:
            [self gotoNextPage: @"LYJKeyboardFrameNotifViewController"];
            break;
        case 5:
            [self gotoNextPage: @"LYJPickerCityViewController"];
            break;
        case 6:
            [self gotoNextPage: @"LYJPickerFlagViewController"];
            break;
        case 7:
            [self gotoNextPage: @"LYJDatePickerViewController"];
            break;
        case 8:
            [self gotoNextPage: @"LYJDrawViewController"];
            break;
        case 9:
            [self gotoNextPage: @"LYJTouchEventViewController"];
            break;
        case 10:
            [self gotoNextPage: @"LYJGestureRecognizerViewController"];
            break;
        case 11:
            [self gotoNextPage: @"LYJCALayerViewController"];
            break;
        case 12:
            [self gotoNextPage: @"LYJAnimationViewController"];
            break;
        case 13:
            [self gotoNextPage: @"LYJDrawingBoardViewController"];
            break;
        case 14:
            [self gotoNextPage: @"LYJDynamicAnimatorViewController"];
            break;
        case 15:
            [self gotoNextPage: @"LYJMaoMaoChongViewController"];
            break;
        case 16:
            break;
        case 17:
            break;
        case 18:
            [self gotoNextPage: @"LYJPThreadViewController"];
            break;
            
        default:
            break;
    }
    
}

- (IBAction)gotoNextPage:(NSString *)pageName {
    NSLog(@"------>>>>>>%@\n", self.navigationController.viewControllers);
    [self.navigationController pushViewController:[[NSClassFromString(pageName) alloc] init] animated:YES];
}

@end
