//
//  LSDayViewController.m
//  lishu
//
//  Created by xueping on 2021/2/28.
//

#import "LSDayViewController.h"
#import "ColorSizeMacro.h"
#import "LSLocation.h"
#import <Masonry/Masonry.h>
#import "LSHandler.h"
#import "LSDayHeaderView.h"
#import "LSDayHolidayCell.h"
#import "LSDayCalendarCell.h"
#import "LSDaySunCell.h"
#import "LSDayMoonCell.h"
#import "LSHandler.h"
#import "LSDay.h"
#import "LSNetWorkHandler.h"
#import "LSWorkingdayModel.h"
#import <YYModel/YYModel.h>
#import "LSWorkingDayConfigFilterViewController.h"
#import "LSCalendarTypefilterViewController.h"
#import "LSJulianCalendar.h"
#import "LSDataBaseTool.h"
#import "LSYear.h"
#import "KeyMacro.h"
#import "LSDatePickerView.h"
#import "ProgressHUD.h"



@interface LSDayViewController ()<UITableViewDelegate,UITableViewDataSource,LSDayHeaderViewDelegate,LSHandlerDelegate,LSDatePickerViewDelegate>


@property(nonatomic,strong)LSLocation *selectLocation;


@property(nonatomic,strong)UIButton *dateButton;

@property(nonatomic,strong)UIButton *ealierButton;
@property(nonatomic,strong)UIButton *laterButton;
@property(nonatomic,strong)UIButton *restoreButton;


@property(nonatomic,copy)NSDictionary *dateAttrsDict;

@property(nonatomic,strong)UIButton *rightButton;



@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *calendarArray;


@property(nonatomic,strong)NSDate *selectDate;

@property(nonatomic,strong)LSHandler *lsHandler;

@property(nonatomic,strong)LSDay *lsDay;
@property(nonatomic,strong)LSYear *lsYear;

@property(nonatomic,copy)NSArray *resultHolidaysArray;
@property(nonatomic,copy)NSArray *holidaysArray;


@property(nonatomic,copy)NSArray *resultCalendarArray;


@property(nonatomic,copy)NSArray *workingdayConfigArray;


@property(nonatomic,copy)NSArray *calendarConfigArray;




@end

@implementation LSDayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = UIColorFromRGB(ViewBackGroundColor);
    
    self.calendarArray = [NSMutableArray array];
    
    [self.view addSubview:self.dateButton];
    [self.view addSubview:self.laterButton];
    [self.view addSubview:self.ealierButton];
    [self.view addSubview:self.restoreButton];
    [self.view addSubview:self.tableView];
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(@28);
        make.width.equalTo(@118);
    }];
    
    [self.ealierButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateButton.mas_left).offset(-5);
        make.top.equalTo(self.view).offset(2);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [self.laterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateButton.mas_right).offset(5);
        make.top.equalTo(self.view).offset(2);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    [self.restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.laterButton.mas_right).offset(10);
        make.top.equalTo(self.view).offset(2);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.dateButton.mas_bottom).offset(10);
    }];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
   
    
    self.workingdayConfigArray   = [LSDataBaseTool  excuteWorkingdaysconfigSelected:YES];
    
    self.calendarConfigArray = [LSDataBaseTool  excuteCaledarConfigArraySelected:YES];

    
    
    NSDate *date= [NSDate date];
   
    
    self.selectDate = date;
    
    
    if (self.lsHandler.selectLocation) {
        
       
        self.selectLocation = self.lsHandler.selectLocation;
        
        
//        LSDay *lsday = [[LSDay alloc] initWithyear:1900 month:8 day:10 timezone:self.selectLocation.TimeZone.Name];
        
        
        LSDate *lsdate = [LSDate localZerodateWithDate:date timeZone:self.selectLocation.TimeZone.Name];
        
        LSDay *lsday = [[LSDay alloc] initWithDate:self.selectDate timezone:self.selectLocation.TimeZone.Name];
        

        
        
        
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d-%02d",lsday.lsdate.localYear,lsday.lsdate.localMonth,lsday.lsdate.localDay] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.lsDay = lsday;
        self.lsYear = [[LSYear alloc] initWithyear:lsdate.localYear timezone:self.selectLocation.TimeZone.Name];
        [self.lsYear createFestilvalArray];
        [self.lsDay calulateMoonWithLocation:self.selectLocation.GeoPosition];
        
        [self.lsDay calculateSunWithLocation:self.selectLocation.GeoPosition];
        
        [self.lsDay calculateCalendarWithLSYear:self.lsYear];
        
        
        [self requestWorkingDaysHoliday];
        
        [self filterCalendarArray];
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
        
//        [self.tableView reloadData];
        
        
        
    }
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveWorkingDayConfigFilterNote:) name:working_dayconfig_filter_key object:nil];

    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(receiveCalenarConfigFilterNote:) name:calendar_config_filter_key object:nil];
    
    
    
    
//    
//    self.selectLocation =  [LSHandler shareHandler].selectLocation;
//    
//    self.navigationItem.title =  self.selectLocation.LocalizedName;
    
    
    
    
    
    
    

    // Do any additional setup after loading the view.
}




- (void)receiveWorkingDayConfigFilterNote:(NSNotification*)note {
    
    self.workingdayConfigArray   = [LSDataBaseTool  excuteWorkingdaysconfigSelected:YES];
    
//    [self  requestWorkingDaysHoliday];
    
    if (self.holidaysArray) {
        [self filterHolidayDayArray];
    } else {
        [self requestWorkingDaysHoliday];
    }
    

}



- (void)receiveCalenarConfigFilterNote:(NSNotification *)note {

    
    self.calendarConfigArray = [LSDataBaseTool  excuteCaledarConfigArraySelected:YES];
    
    [self filterCalendarArray];
    
    
}


- (void)filterHolidayDayArray {
    
    
    
    NSMutableArray *dayArray = [NSMutableArray array];
    for (LSWorkingdayModel *daymodel in self.holidaysArray) {
        for (LSWorkingDayConfig *config in self.workingdayConfigArray) {
            if ([config.code isEqualToString:daymodel.code] && [config.config isEqualToString:daymodel.configuration]) {
                [dayArray addObject:daymodel];
                continue;
            }
        }
    }
    
    self.resultHolidaysArray= dayArray.copy;
    [self.tableView reloadData];
    
    
}

- (void)filterCalendarArray {
    
    NSMutableArray *dayArray = [NSMutableArray array];
    for (LSCalendarTypeModel *daymodel in self.lsDay.clanedarArray) {
        for (LSCalendarTypeModel *config in self.calendarConfigArray) {
            if (config.type == daymodel.type    ) {
                [dayArray addObject:daymodel];
                continue;
            }
        }
    }
    
    self.resultCalendarArray = dayArray.copy;
    [self.tableView reloadData];
}

- (void)requestWorkingDaysHoliday {
    
    NSString *date = [NSString stringWithFormat:@"%ld-%02d-%02d",self.lsDay.year,self.lsDay.month,self.lsDay.dayInMonth];
    
    NSDictionary *dict = @{@"date":date};
    
    [LSNetWorkHandler WorkingDaysDayWithparamater:dict success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        
        NSArray * holidaysArray = [NSArray yy_modelArrayWithClass:[LSWorkingdayModel class] json:data];
        
//        NSMutableArray *dayArray = [NSMutableArray array];
//        for (LSWorkingdayModel *daymodel in holidaysArray) {
//            for (LSWorkingDayConfig *config in self.workingdayConfigArray) {
//                if ([config.code isEqualToString:daymodel.code] && [config.config isEqualToString:daymodel.configuration]) {
//                    [dayArray addObject:daymodel];
//                    continue;
//                }
//            }
//        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            if (holidaysArray.count) {
                
                LSWorkingdayModel *daymodel = [holidaysArray firstObject];
                if ([daymodel.date isEqualToString:[NSString stringWithFormat:@"%ld-%02d-%02d",self.lsDay.year,self.lsDay.month,self.lsDay.dayInMonth]]) {
                    
                    self.holidaysArray = holidaysArray.copy;
                    
                    [self filterHolidayDayArray];
                    
//                    [self.tableView reloadData];
                    
                }
                
                
            } else{
                
                self.holidaysArray = [NSArray array];
                
                [self filterHolidayDayArray];
                
            }
            
            
        });
        
    } failed:^(NSError * _Nonnull error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            self.holidaysArray = [NSArray array];
            
            [self filterHolidayDayArray];
            [ProgressHUD showError:error.localizedDescription];
        });
        
    }];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.lsHandler.tableView.superview) {
        [self.lsHandler.tableView removeFromSuperview];
    }
}

- (LSHandler *)lsHandler {
    if (!_lsHandler) {
        _lsHandler  = [[LSHandler alloc] init];
        _lsHandler.delegate = self;
    }
    return _lsHandler;
}

- (void)selectHandlerTableViewSelectLocation:(LSLocation *)location {

    [self configSelectLocation:location];
}

-(UIButton *)ealierButton {
    if (!_ealierButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"xiangqian"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(earlierButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _ealierButton  = button;
    }
    return _ealierButton    ;
}

-(void)earlierButtonClick:(UIButton *)button {
    
    NSDate *date  = [NSDate dateWithTimeInterval:-3600*24 sinceDate:self.selectDate];
    
    [self calculateDate:date];
    
    
}


- (void)calculateDate:(NSDate *)date{
    
    self.selectDate = date;
    if (self.selectLocation) {
        
        LSDay *lsday = [[LSDay alloc] initWithDate:self.selectDate timezone:self.selectLocation.TimeZone.Name];
        
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d-%02d",lsday.lsdate.localYear,lsday.lsdate.localMonth,lsday.lsdate.localDay] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        
        self.lsDay = lsday;
        [self.lsDay calulateMoonWithLocation:self.selectLocation.GeoPosition];
        
        [self.lsDay calculateSunWithLocation:self.selectLocation.GeoPosition];
        
        if (self.lsYear.year != lsday.lsdate.localYear) {
            self.lsYear = [[LSYear alloc] initWithyear:lsday.lsdate.localYear timezone:self.selectLocation.TimeZone.Name];
            [self.lsYear createFestilvalArray];
        }
        
        
        [self.lsDay calculateCalendarWithLSYear:self.lsYear];
        
        [self filterCalendarArray];
        
        
        [self requestWorkingDaysHoliday];
        
    
        [self.tableView reloadData];
    }
    
    
}

- (void)configSelectLocation:(LSLocation *)location {
    
    self.selectLocation = location;
    
    if (self.selectDate) {
        LSDay *lsday = [[LSDay alloc] initWithDate:self.selectDate timezone:self.selectLocation.TimeZone.Name];
        
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d-%02d",lsday.lsdate.localYear,lsday.lsdate.localMonth,lsday.lsdate.localDay] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
        
        
        self.lsDay = lsday;
        [self.lsDay calulateMoonWithLocation:self.selectLocation.GeoPosition];
        
        [self.lsDay calculateSunWithLocation:self.selectLocation.GeoPosition];
        
        
        self.lsYear = [[LSYear alloc] initWithyear:lsday.lsdate.localYear timezone:self.selectLocation.TimeZone.Name];
        [self.lsYear createFestilvalArray];
        
        [self.lsDay calculateCalendarWithLSYear:self.lsYear];
        
        
       
        
        [self filterCalendarArray];
        
        
        
        [self requestWorkingDaysHoliday];
        

        [self.tableView reloadData];
    }
    
   
}

-(UIButton *)laterButton {
    if (!_laterButton ) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"xianghou"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(laterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _laterButton  = button;
    }
    return _laterButton    ;
}

- (void)laterButtonClick:(UIButton *)button {
    
    NSDate *date  = [NSDate dateWithTimeInterval:3600*24 sinceDate:self.selectDate];
    
    [self calculateDate:date];
    
}

-(UIButton *)dateButton {
    if (!_dateButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, 44, 44);
        
        button.layer.cornerRadius =  4;
        button.layer.borderWidth  =1.5;
        button.layer.borderColor   = UIColorFromRGB(TextDarkColor).CGColor;
        button.layer.masksToBounds  =  YES;
      
        [button addTarget:self action:@selector(dateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _dateButton  = button;
    }
    return _dateButton;
}

-(void)dateButtonClick:(UIButton *)button {
    if (self.selectLocation) {
        [LSDatePickerView showInView:self.view delegate:self date:self.selectDate];
    }
    
    
}


- (NSDictionary *)dateAttrsDict {
    if (!_dateAttrsDict) {
        _dateAttrsDict  =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.f],
                       NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor)
        };
    }
    return _dateAttrsDict;
}

-(UIButton *)rightButton {
    if (!_rightButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"xianxia"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton  = button;
    }
    return _rightButton    ;
}

- (void)rightButtonClick:(UIButton*)button {
    if (!self.lsHandler.tableView.superview) {
        [self.view addSubview:self.lsHandler.tableView];
        CGFloat width   = [UIScreen mainScreen].bounds.size.width;
        
        self.lsHandler.tableView.frame   =CGRectMake(width-200, 0, 200, 0);
       
        [UIView animateWithDuration:0.25 animations:^{
            self.lsHandler.tableView.frame   =CGRectMake(width-200, 0, 200, 260);
        }];
    } else {
        
        CGFloat width   = [UIScreen mainScreen].bounds.size.width;
        
        [UIView animateWithDuration:0.25 animations:^{
            self.lsHandler.tableView.frame   =CGRectMake(width-200, 0, 200, 0);
        } completion:^(BOOL finished) {
            [self.lsHandler.tableView removeFromSuperview];
        }];
        
    }
    
}

-(UIButton *)restoreButton {
    if (!_restoreButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"huanyuan"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(restoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _restoreButton  = button;
    }
    return _restoreButton    ;
}

- (void)restoreButtonClick:(UIButton *)button {
    
    NSDate *date= [NSDate date];
//    self.selectDate = date;
//    LSDate *lsdate = [LSDate localZerodateWithDate:date timeZone:self.selectLocation.TimeZone.Name];
    
   
    
    [self calculateDate:date];
    
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
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section) {
        return 2;
    } else if (1 == section){

            return self.resultCalendarArray.count;
        
    } else {
        return self.resultHolidaysArray.count;
    }
    
}


- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath  {
    
    if (0 == indexPath.section) {
        return 70;
    } else if(1 == indexPath.section){
        return 60;
    }else {
        
        return 44;
    }
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (0 == indexPath.section) {
        return 70;
    } else if(1 == indexPath.section){
        return UITableViewAutomaticDimension;
    }else {
        
        return 55;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (0 == indexPath.section) {
        if (0 == indexPath.row) {
            LSDaySunCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"sun"];
            if (cell == nil) {
                cell  = [[LSDaySunCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"sun"];
            }
            
            if (self.lsDay) {
                [cell configDay:self.lsDay];
            }
            return cell;
        } else {
            
            LSDayMoonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"moon"];
            if (cell == nil) {
                cell = [[LSDayMoonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"moon"];
            }
//            [cell cinfigFaseView];
            if (self.lsDay) {
                [cell configDay:self.lsDay];
            }
            
            return cell;
            
        }
        
       
    } else if (1 == indexPath.section){
        LSDayCalendarCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"calendar"];
       if (cell == nil) {
           cell  = [[LSDayCalendarCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"calendar"];
       }
//        if (self.lsDay) {
            LSCalendarTypeModel *calendar = self.resultCalendarArray[indexPath.row];
            
            [cell configCalnedar:calendar];
//        }
        
        
       return cell;
    } else {
        
        LSDayHolidayCell     *cell  = [tableView dequeueReusableCellWithIdentifier:@"holiday"];
       if (cell == nil) {
           cell  = [[LSDayHolidayCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"holiday"];
       }
        
        LSWorkingdayModel *workingdaymodel = self.resultHolidaysArray[indexPath.row];
        [cell configWorkingDayFromDay:workingdaymodel];
        
       return cell;
        
    }
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
   
    return 44;
    
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LSDayHeaderView  *headerView  = [tableView  dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSDayHeaderView alloc] initWithReuseIdentifier:@"header"];
        headerView.delegate = self;
        
    }
    if (0 == section) {
        [headerView.filterButton setImage:nil forState:UIControlStateNormal];
    } else {
        [headerView.filterButton setImage:[UIImage imageNamed:@"shaixuan"] forState:UIControlStateNormal];
    }
    
    headerView.tag =  section;
    
    if (0 == section) {
        
        headerView.titleLabel.text = NSLocalizedString(@"solunar", nil);
    } else if (1 == section){
        headerView.titleLabel.text = NSLocalizedString(@"calendar", nil);
    } else if (2 == section){
        headerView.titleLabel.text = NSLocalizedString(@"public_holiday", nil);
    }
    
    
    return headerView;
    
}


- (void)lsDayheaderFilterButtonClickSection:(NSInteger)section {
    
    if (1 == section) {
        
        LSCalendarTypefilterViewController *filterVC  =[[LSCalendarTypefilterViewController alloc] init];
        
        [self.navigationController pushViewController:filterVC animated:YES];
        

        
    }else if (2 == section) {
        LSWorkingDayConfigFilterViewController *configVc = [[LSWorkingDayConfigFilterViewController alloc] init];
        [self.navigationController pushViewController:configVc animated:YES];
    }
    
}




- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}


- (void)datePickerViewSelectDate:(NSDate *)date {
    
//    if (self.selectLocation) {
        
//        self.selectDate = date;
        
        [self calculateDate:date];
//    }
    
    
}

- (UIUserInterfaceStyle)overrideUserInterfaceStyle {

    return UIUserInterfaceStyleLight;
}



- (void)dealloc  {
    
    [[NSNotificationCenter defaultCenter] removeObserver:self];
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
