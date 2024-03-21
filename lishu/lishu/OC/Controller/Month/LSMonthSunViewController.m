//
//  LSMonthSunViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSMonthSunViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSMonthRiseSetCell.h"
#import "LSMonthRiseSetHeaderView.h"

@interface LSMonthSunViewController ()<UITableViewDelegate,UITableViewDataSource,UIPickerViewDelegate,UIPickerViewDataSource>

@property(nonatomic,strong)UITableView *tableView;
@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIPickerView *pickerView;

@property(nonatomic,assign)NSInteger selectIndex;
@property(nonatomic,strong)LSMonth *selectMonth;

@property(nonatomic,copy)NSArray *itemsArray;


@end

@implementation LSMonthSunViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    self.itemsArray = @[NSLocalizedString(@"sunrise_sunset", nil),NSLocalizedString(@"civil_dawn_dusk", nil),NSLocalizedString(@"nautical_dawn_dusk", nil),NSLocalizedString(@"astro_dawn_dusk", nil)];
    self.selectIndex = 0;
    
    [self.view addSubview:self.pickerView];
    [self.view addSubview:self.tableView];
    [self.pickerView   mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.width.equalTo(@240);
        make.top.equalTo(self.view);
        make.height.equalTo(@99);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.pickerView.mas_bottom);
        
    }];
    
    // Do any additional setup after loading the view.
}

- (void)configMonth:(LSMonth *)month location:(nonnull LSLocation *)location {
    
    
    for (LSDay *day in month.daysArray) {
        [day calculateSunWithLocation:location.GeoPosition];
    }
    
    self.selectMonth = month;
    
    [self.tableView reloadData];
    
    
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView  = [[UIPickerView alloc] initWithFrame:self.view.frame];
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    
    return _pickerView;
}



- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    
    return 1;
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    return self.itemsArray.count;
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    return 250;
}

- (UIView *)pickerView:(UIPickerView *)pickerView viewForRow:(NSInteger)row forComponent:(NSInteger)component reusingView:(UIView *)view {

    UILabel* pickerLabel = (UILabel*)view;
    if (!pickerLabel){
        pickerLabel = [[UILabel alloc] init];
        pickerLabel.adjustsFontSizeToFitWidth = YES;
        [pickerLabel setTextAlignment:NSTextAlignmentCenter];
        [pickerLabel setBackgroundColor:[UIColor clearColor]];
        pickerLabel.font = [UIFont systemFontOfSize:13.f];
        pickerLabel.textColor = UIColorFromRGB(TextDarkColor);
        pickerLabel.adjustsFontSizeToFitWidth = YES;
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;


}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    NSString *string  = self.itemsArray[row];
    
    return string;

}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 33;
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    
    self.selectIndex = row;
    [self.tableView reloadData];

    
    
}


- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
        _tableView.tableFooterView =  [[UIView alloc] initWithFrame:CGRectZero];
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
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
    
    if (self.selectMonth) {
        return self.selectMonth.daysArray.count;
    } else {
        return 0;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 40;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSMonthRiseSetCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSMonthRiseSetCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.selectionStyle =  UITableViewCellSelectionStyleNone;
    }
    
    if (self.selectMonth) {
        
        LSDay *day = self.selectMonth.daysArray[indexPath.row];
        switch (self.selectIndex) {
            case 0:
                
                [cell configRisetSetTime:day.sun.riseSet day:day];
                
                break;
            case 1:
                
                [cell configRisetSetTime:day.sun.civilRiseSet day:day];
                
                break;
            case 2:
                
                [cell configRisetSetTime:day.sun.nuticalRiseSet day:day];
                
                break;
            case 3:
                
                [cell configRisetSetTime:day.sun.astroRiseSet day:day];
                
                break;
                
            
                
            default:
                break;
        }
    }
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section   {
    
    LSMonthRiseSetHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSMonthRiseSetHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    
    return headerView;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return 40;
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
