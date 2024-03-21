//
//  LSYearEclipseViewController.m
//  lishu
//
//  Created by xueping on 2021/10/14.
//

#import "LSYearEclipseViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

#import "LSEclipseModel.h"

#import "LSEclipseItemModel.h"
#import "LSEclipseCell.h"
#import "LSNormalHeaderView.h"



@interface LSYearEclipseViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)LSEclipseModel *eclipseModel;

@end

@implementation LSYearEclipseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)configYear:(int)year location:(LSLocation *)location {
    
    self.eclipseModel   = [[LSEclipseModel alloc] initWithYear:year timeZone:location.TimeZone.Name];
    
    
    [self.tableView reloadData];
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        _tableView.separatorInset  = UIEdgeInsetsZero;
        _tableView.separatorStyle =  UITableViewCellSeparatorStyleSingleLine;
        _tableView.separatorColor = UIColorFromRGB(0xeeeeee);
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (self.eclipseModel) {
        return 2;
    } else {
        return 0;
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section) {
        return self.eclipseModel.solarArray.count;
    } else {
        return self.eclipseModel.lunarArray.count;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   LSEclipseCell  *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSEclipseCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
//    cell.backgroundColor = [UIColor redColor];
    if (0 == indexPath.section) {
        LSEclipseItemModel *itemModel = self.eclipseModel.solarArray[indexPath.row];
        [cell configModel:itemModel];
    } else {
        LSEclipseItemModel *itemModel = self.eclipseModel.lunarArray[indexPath.row];
        [cell configModel:itemModel];
    }
    
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LSNormalHeaderView   *headeView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headeView == nil) {
        headeView = [[LSNormalHeaderView alloc] initWithReuseIdentifier:@"header"];
        headeView.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
        headeView.textLabel.textColor = UIColorFromRGB(TextDarkColor);
    }
    if (0 == section) {
        headeView.titleLabel.text = NSLocalizedString(@"solar_eclipse", nil);
    } else {
        headeView.titleLabel.text  = NSLocalizedString(@"lunar_eclipse", nil);
    }
    return headeView;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
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
