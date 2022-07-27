//
//  LYJFriendViewController.m
//  LYJProject
//
//  Created by LYJ on 2022/1/26.
//

#import "LYJFriendViewController.h"
#import "LYJGroup.h"
#import "LYJFriendCell.h"
#import "LYJFriendHeaderView.h"

@interface LYJFriendViewController () <UITableViewDelegate, UITableViewDataSource, LYJFriendHeaderViewDelegate>

@property (nonatomic, weak) UITableView *tableView;

@property (nonatomic, strong) NSArray *groups;

@end

@implementation LYJFriendViewController

- (NSArray *)groups {
    if (!_groups) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"friends.plist" ofType:nil];
        NSArray *arr = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrM = [NSMutableArray array];
        for (NSDictionary *dict in arr) {
            LYJGroup *model = [LYJGroup groupWithDict:dict];
            [arrM addObject:model];
        }
        _groups = arrM;
    }
    return _groups;
}

- (void)dealloc {
    NSLog(@"--------->>>> %s", __func__);
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = UIColor.whiteColor;
    

    
    UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight) style: UITableViewStylePlain];
    tableView.backgroundColor = UIColor.whiteColor;
    tableView.delegate = self;
    tableView.dataSource = self;
    tableView.rowHeight = 44;
    tableView.sectionHeaderHeight = 50;
    if (@available(iOS 15.0, *)) {
        tableView.sectionHeaderTopPadding = 0;
    }
    [self.view addSubview:tableView];
    _tableView = tableView;


    
}


//!MARK: - ----<UITableViewDelegate, UITableViewDataSource>
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.groups.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LYJGroup *model = self.groups[section];
    if (model.isFold) {
        return model.friends.count;
    } else {
        return 0;
    }
    
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    LYJFriendCell *cell = [LYJFriendCell friendCellWithTableView:tableView];
    
    LYJGroup *groupModel = self.groups[indexPath.section];
    LYJFriend *friendModel = groupModel.friends[indexPath.row];
    
    cell.friendModel = friendModel;
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LYJFriendHeaderView *headerVw = [LYJFriendHeaderView friendHeaderViewWithTableView:tableView];
    
    headerVw.delegate = self;
    
    headerVw.tag = section;
    
    LYJGroup *groupModel = self.groups[section];
    
    headerVw.groupModel = groupModel;
    
    return headerVw;
}


//!MARK: - ----<LYJFriendHeaderViewDelegate>
- (void)friendHeaderViewClickButton:(LYJFriendHeaderView *)headerView {
    NSIndexSet *indexSet = [NSIndexSet indexSetWithIndex:headerView.tag];
    [_tableView reloadSections:indexSet withRowAnimation:UITableViewRowAnimationFade];
}


@end
