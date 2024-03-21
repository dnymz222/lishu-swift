//
//  LSAstroMonthListViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSAstroMonthListViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSDayHeaderView.h"
#import "LSAstroSectionModel.h"
#import "LSPlanet.h"
#import "LSStar.h"
#import "LSConstellation.h"
#import "LSPlanet.h"
#import "LSPlanetMonthViewController.h"
#import "LSLocation.h"
#import "LSStarMonthViewController.h"
#import "LSConstellationMonthViewController.h"

@interface LSAstroMonthListViewController ()<UITableViewDelegate,UITableViewDataSource,LSDayHeaderViewDelegate>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)LSLocation *selectLocation;


@end

@implementation LSAstroMonthListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  UIColorFromRGB(ViewBackGroundColor);
    self.dataArray =  [NSMutableArray array];
    for (int i = 1; i < 4; i++) {
        LSAstroSectionModel *astro  = [[LSAstroSectionModel alloc] initWithType:i];
        [self.dataArray addObject:astro];
        
    }
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    
    // Do any additional setup after loading the view.
}

- (void)configLocation:(LSLocation *)location {
    self.selectLocation = location;
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataArray.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    LSAstroSectionModel *model  =  self.dataArray[section];
    if (model.isOpen) {
        return model.astroArray.count;
    }
    return 0;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.textLabel.textColor  = UIColorFromRGB(TextDarkColor);
        cell.textLabel.font =  [UIFont systemFontOfSize:15.0];
        cell.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        cell.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
        
        
    }
    
    LSAstroSectionModel *model  =  self.dataArray[indexPath.section];
    
    if (1 == model.type) {
        LSPlanet *planet = model.astroArray[indexPath.row];
        cell.textLabel.text =  planet.name;
    } else if (2 == model.type){
        LSConstellation *constellation = model.astroArray[indexPath.row];
        cell.textLabel.text = [[NSBundle mainBundle] localizedStringForKey:constellation.englishName value:@"" table:@"lish"];
    } else if (3 == model.type){
        LSStar *star =  model.astroArray[indexPath.row];
        cell.textLabel.text  =[[NSBundle mainBundle] localizedStringForKey:star.EnglishName value:@"" table:@"lish"];
    }
    
    
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LSDayHeaderView*headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSDayHeaderView alloc] initWithReuseIdentifier:@"header"];
        headerView.delegate = self;
    }
    LSAstroSectionModel *model  =  self.dataArray[section];
    [headerView configAstroSection:model];
    headerView.tag = section;
    
    return headerView;
    
}


- (void)lsDayheaderFilterButtonClickSection:(NSInteger)section {
    
    LSAstroSectionModel *model  =  self.dataArray[section];
    model.isOpen = !model.isOpen;
    [self.tableView reloadData];
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    LSAstroSectionModel *model  =  self.dataArray[indexPath.section];
    if (1 == model.type) {
        LSPlanet *planet = model.astroArray[indexPath.row];
        if (self.selectLocation) {
            LSPlanetMonthViewController *planetMonthVC = [[LSPlanetMonthViewController alloc] init];
            planetMonthVC.selectLocation  = self.selectLocation;
            planetMonthVC.planet = planet;
            [self.navigationController pushViewController:planetMonthVC animated:YES];
            
        }
    } else if (2 == model.type){
        LSConstellation *constellation = model.astroArray[indexPath.row];
        if (self.selectLocation) {
            LSConstellationMonthViewController *monthVC = [[LSConstellationMonthViewController alloc] init];
            monthVC.constellation = constellation;
            monthVC.selectLocation = self.selectLocation;
            [self.navigationController pushViewController:monthVC animated:YES];
        }
        
    } else if(3 == model.type){
        LSStar *star =  model.astroArray[indexPath.row];
        if (self.selectLocation) {
            
            
            LSStarMonthViewController *monthVC = [[LSStarMonthViewController alloc] init];
           
            monthVC.star = star;
            monthVC.selectLocation = self.selectLocation;
            [self.navigationController pushViewController:monthVC animated:YES];
            
        }
        
    }
    
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
