//
//  LSCalendarTypefilterViewController.m
//  lishu
//
//  Created by xueping on 2021/10/18.
//

#import "LSCalendarTypefilterViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSDataBaseTool.h"
#import "LSFilterCell.h"
#import "LSCalendarGroup.h"
#import "LSNormalHeaderView.h"
#import "KeyMacro.h"


@interface LSCalendarTypefilterViewController ()<UITableViewDelegate,UITableViewDataSource,LSFilterCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
//@property(nonatomic,assign)BOOL is_vip;

@property(nonatomic,assign)BOOL has_change;

@end

@implementation LSCalendarTypefilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
//
//    self.is_vip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
    
    self.dataArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        LSCalendarGroup *group = [[LSCalendarGroup alloc] initWithType:i];
        [group createData];
        [self.dataArray addObject:group];
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    
    // Do any additional setup after loading the view.
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LSCalendarGroup *group = self.dataArray[section];
    return group.dataArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSFilterCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSFilterCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.delegate = self;
    }
    LSCalendarGroup *group = self.dataArray[indexPath.section];
    
    LSCalendarTypeModel *calendar = group.dataArray[indexPath.row];
    
    [cell configCalendarType:calendar ];
    
    
    
    
    
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LSNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSNormalHeaderView alloc] initWithReuseIdentifier:@"header"];

    }
    LSCalendarGroup *group = self.dataArray[section];
    headerView.titleLabel.text  =group.name;
    return headerView;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)filtercellButtonClick:(UIButton *)button calendar:(LSCalendarTypeModel *)calendar {
    

    BOOL result = [LSDataBaseTool updateCalendarConfigWithType:calendar.type selected:!calendar.selected];
    if (result) {
        calendar.selected = !calendar.selected;
        [self.tableView reloadData];
        self.has_change = YES;
    }
  
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter] postNotificationName:calendar_config_filter_key object:nil];
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
