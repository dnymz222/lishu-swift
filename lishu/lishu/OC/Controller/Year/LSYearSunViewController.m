//
//  LSYearSunViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSYearSunViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSSolarTermModel.h"
#import "LSSolarTermItemModel.h"
#import "LSSolarTermCell.h"

@interface LSYearSunViewController ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;

@property(nonatomic,strong)LSSolarTermModel *solarTermModel;

@end

@implementation LSYearSunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor =  UIColorFromRGB(ViewBackGroundColor);
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
    }];
    // Do any additional setup after loading the view.
}

- (void)configYear:(int)year location:(LSLocation *)location {
    
    LSSolarTermModel *solarTerm = [[LSSolarTermModel alloc] initWithYear:year timeZone:location.TimeZone.Name];
    NSInteger hemistype = 0;
    if (location.GeoPosition.Latitude < 0) {
        hemistype = 1;
    }
    [solarTerm calculateSolarTermWithHemisType:hemistype];
    
    self.solarTermModel  =  solarTerm;
    
    [self.tableView reloadData];
    
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
    if (self.solarTermModel) {
        return self.solarTermModel.solarTermsArray.count;
        
    } else{
        return 0;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSSolarTermCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSSolarTermCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    if (self.solarTermModel) {
        LSSolarTermItemModel *itemModel = self.solarTermModel.solarTermsArray[indexPath.row];
        [cell configItemModel:itemModel];
        
    }
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
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
