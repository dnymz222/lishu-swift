//
//  LSWorkingDayConfigFilterViewController.m
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import "LSWorkingDayConfigFilterViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSDataBaseTool.h"
#import "LSFilterCell.h"
#import "LSFilterHeaderView.h"
#import "LSWorkingDayConfig.h"
#import "LSNormalHeaderView.h"
#import "KeyMacro.h"


@interface LSWorkingDayConfigFilterViewController ()<UITableViewDelegate,UITableViewDataSource,LSFilterHeaderViewDelegate,LSFilterCellDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSArray *dataArray;

//@property(nonatomic,assign)BOOL is_vip;

@end

@implementation LSWorkingDayConfigFilterViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    self.dataArray = [LSDataBaseTool excuteWorkingdaysconfig];
//    self.is_vip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
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
    
    LSWorkingDayConfig *config = self.dataArray[section];
  
    return config.configs.count;

    
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
    LSWorkingDayConfig *config = self.dataArray[indexPath.section];
    LSWorkingDayConfig *subconfig = config.configs[indexPath.row];
    [cell configWorkingDay:subconfig ];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section    {
    LSNormalHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
        headerView.textLabel.textColor = UIColorFromRGB(TextDarkColor);
        
    }
    
    LSWorkingDayConfig *config = self.dataArray[section];
    
    headerView.titleLabel.text = [[NSBundle mainBundle] localizedStringForKey:config.code value:@"" table:@"lish"];
    
    
    return headerView;
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)filterHeaderViewButtonClick:(UIButton *)button buttonIndex:(NSInteger)buttonIndex config:(LSWorkingDayConfig *)config {
    
    if (1 == buttonIndex   ) {
        config.is_show  = !config.is_show;
        [self.tableView reloadData];
    } else {
        BOOL selected = !config.selected;
        BOOL result = [LSDataBaseTool updateWorkingDayConfigWithCongifId:config.code selected:selected];
        if (result) {
            config.selected = selected;
            [self.tableView reloadData];
        }
    }
}

- (void)filtercellButtonClick:(UIButton *)button config:(LSWorkingDayConfig *)config {
    
    BOOL selected = !config.selected;
    
    NSString *config_id;
    if (config.is_default) {
        config_id = config.code;
    } else{
        config_id = [NSString stringWithFormat:@"%@_%@",config.code,config.config];
    }
    
    
    BOOL result = [LSDataBaseTool updateWorkingDayConfigWithCongifId:config_id selected:selected];
    if (result) {
        config.selected = selected;
        [self.tableView reloadData];
    }
    
    
}


- (void)dealloc {
    
    [[NSNotificationCenter defaultCenter]postNotificationName:working_dayconfig_filter_key object:nil];
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
