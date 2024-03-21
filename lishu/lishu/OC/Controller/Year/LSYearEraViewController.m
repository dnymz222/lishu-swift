//
//  LSYearEraViewController.m
//  lishu
//
//  Created by xueping on 2024/1/8.
//

#import "LSYearEraViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSCalendarGroup.h"
#import "LSEraViewController.h"


@interface LSYearEraViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@end

@implementation LSYearEraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  UIColorFromRGB(ViewBackGroundColor);
    
    NSMutableArray *arry = [NSMutableArray array];
    
    for (int i =1; i < 8; i++) {
        LSCalendarGroup *group = [[LSCalendarGroup alloc] initWithType:i];
        [arry addObject:group];
    }
    self.dataArray   = arry.copy;
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
        _tableView.delegate  = self;
        _tableView.dataSource  = self;
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    

        return self.dataArray.count;

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        cell.textLabel.font = [UIFont systemFontOfSize:15.f];
        cell.textLabel.textColor = UIColorFromRGB(TextDarkColor);
        
        cell.detailTextLabel.textColor = UIColorFromRGB(TextLightColor);
        cell.detailTextLabel.font = [UIFont systemFontOfSize:14.f];
        cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
       
    }

        cell.detailTextLabel.text = @"";
        LSCalendarGroup *group = self.dataArray[indexPath.row];
        cell.textLabel.text = group.name;
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 44;
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
        
        LSEraViewController *eraVC = [[LSEraViewController alloc] init];
        LSCalendarGroup *group = self.dataArray[indexPath.row];
        eraVC.name = group.name;
        eraVC.type = group.type;
        
        [self.navigationController pushViewController:eraVC animated:YES];

    
    
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
