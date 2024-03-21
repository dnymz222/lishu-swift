//
//  LSYearHolidayViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSYearHolidayViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSNetWorkHandler.h"
#import <YYModel/YYModel.h>
#import "LSWorkingDayConfig.h"
#import "LSCalendarGroup.h"
#import "LSDataBaseTool.h"
#import "LSWorkingdayModel.h"
#import "LSDayCalendarCell.h"
#import "LSDayHolidayCell.h"
#import "LSFestivalCell.h"
#import "LSIslamicHolidays.h"
#import "LSChineseFestival.h"
#import "LSJewish.h"
#import "LSWorldDay.h"
#import "LSChristian.h"
#import "LSOrthodox.h"
#import "KeyMacro.h"
//#import "LSUnlockCell.h"
//#import "LSInAppPurchaseViewController.h"





@interface LSYearHolidayViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIPickerView *pickerView2;

@property(nonatomic,strong)UIScrollView  *scrollView;

@property(nonatomic,assign)CGFloat screenwidth;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,assign)NSInteger selectCalendarIndex;
//@property(nonatomic,assign)NSInteger selectSubCalendarIndex;

//@property(nonatomic,copy)NSArray *configArray;

@property(nonatomic,assign)NSInteger selectConfigIndex;

@property(nonatomic,assign)NSInteger selectSubConfigIndex;

@property(nonatomic,strong)UISegmentedControl *segMent;


@property(nonatomic,copy)NSArray *workingconfigsArray;
@property(nonatomic,copy)NSArray *calendarConfigsArray;

@property(nonatomic,assign)NSInteger selectSegmentIndex;

@property(nonatomic,strong)LSWorkingDayConfig  *selectWorkingCongig;
@property(nonatomic,strong)LSCalendarTypeModel *selectCalendarConfig;


@property(nonatomic,assign)NSInteger selectYear;


@property(nonatomic,copy)NSArray *holidayArray;
@property(nonatomic,copy)NSArray *festivalArray;


@property(nonatomic,strong)id<LSFetival> selelctFestival;

//@property(nonatomic,assign)BOOL is_vip;



@end

@implementation LSYearHolidayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    self.dataArray =  [NSMutableArray array];
    
//    self.is_vip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
    
    self.workingconfigsArray = [LSDataBaseTool excuteWorkingdaysconfig ];
    self.selectSegmentIndex = 0;
    
//    NSMutableArray *dataArray = [NSMutableArray array];
//    for (int i = 1; i < 9; i++) {
//        LSCalendarGroup *group = [[LSCalendarGroup alloc] initWithType:i];
//        [dataArray addObject:group];
//    }
    
    self.calendarConfigsArray   = [LSDataBaseTool excuteCaledarConfigArrayHasFestival];
    
    self.screenwidth = [UIScreen mainScreen].bounds.size.width;
    
    self.selectCalendarIndex = [[NSUserDefaults standardUserDefaults] integerForKey:year_calendar_holiday_selectindex_key];
//    self.selectSubCalendarIndex = 0;
    self.selectConfigIndex = [[NSUserDefaults standardUserDefaults] integerForKey:year_workingday_code_selectindex_key];
    self.selectSubConfigIndex = [[NSUserDefaults standardUserDefaults] integerForKey:year_workingday_sub_selectindex_key];
    
    [self.view addSubview:self.segMent];
    
    [self.segMent mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self.view);
        make.height.equalTo(@32);
    }];
    
    [self.view addSubview:self.scrollView];
    
  
    [self.scrollView   mas_makeConstraints:^(MASConstraintMaker *make) {
       
        make.left.equalTo(self.view).offset(0);
        make.right.equalTo(self.view).offset(0);
        make.top.equalTo(self.view).offset(32);
        make.height.equalTo(@108);
    }];
    
    
    [self.view addSubview:self.pickerView];
    
    [self.scrollView addSubview:self.pickerView];
    [self.scrollView addSubview:self.pickerView2];
    
    self.pickerView.frame = CGRectMake(0, 0, self.screenwidth, 99);
    self.pickerView2.frame = CGRectMake(self.screenwidth, 0, self.screenwidth, 99);
    
    self.scrollView.contentSize = CGSizeMake(self.screenwidth*2, 99);
    self.scrollView.scrollEnabled = NO;
    

    [self.view addSubview:self.tableView];
   
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.pickerView.mas_bottom);
        
    }];
    
  
    [self.pickerView selectRow:self.selectCalendarIndex inComponent:0 animated:NO];
    self.selectCalendarConfig = self.calendarConfigsArray[self.selectCalendarIndex];
    
    
    
    [self.pickerView2 selectRow:self.selectConfigIndex inComponent:0 animated:NO];
    [self.pickerView2 selectRow:self.selectSubConfigIndex inComponent:1 animated:NO];
    
    
    
    LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
    self.selectWorkingCongig = config.configs[self.selectSubConfigIndex];
    
    
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivePurchaseSuccessNote:) name:purchase_success_note_key object:nil];
  
    
//    [self requestConfig];
    // Do any additional setup after loading the view.
}


//- (void)receivePurchaseSuccessNote:(NSNotification *)note {
//    
////    self.is_vip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
//    [self.pickerView reloadAllComponents];
//    [self.pickerView2 reloadAllComponents];
//    [self.tableView reloadData];
//    
//}


- (void)configYear:(int)year location:(nonnull LSLocation *)location {
    
    self.selectYear  = year;
    [self calculateCalendar];
    [self requstPublicHoliday];

    
    
}

- (UISegmentedControl *)segMent {
    if (!_segMent) {
        _segMent = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"calendar_festival", nil),NSLocalizedString(@"public_holiday", nil)]];
        _segMent.tintColor = UIColorFromRGB(TextDarkColor);
        _segMent.selectedSegmentIndex  = 0;
        [_segMent addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segMent;
}
- (void)segmentClick:(UISegmentedControl *)segment {
    
    self.selectSegmentIndex = segment.selectedSegmentIndex;
    self.scrollView.contentOffset  = CGPointMake(self.screenwidth*segment.selectedSegmentIndex, 0);
    
    [self.tableView reloadData];

    
}

//- (void)requestConfig {
//
//    [LSNetWorkHandler WorkingDaysConfigWithparamater:@{} success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
//
//        self.configArray = [NSArray yy_modelArrayWithClass:[LSWorkingDayConfig class] json:data];
//        dispatch_async(dispatch_get_main_queue(), ^{
//
//            [self.pickerView2 reloadAllComponents];
//        });
//
//    } failed:^(NSError * _Nonnull error) {
//
//    }];
//}







- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView = [[UIScrollView alloc] init];
        _scrollView.delegate  =self;
    }
    return _scrollView;
}

- (UIPickerView *)pickerView {
    if (!_pickerView) {
        _pickerView  = [[UIPickerView alloc] initWithFrame:self.view.frame];
        _pickerView.tag  =0;
        _pickerView.delegate = self;
        _pickerView.dataSource = self;
    }
    
    return _pickerView;
}

- (UIPickerView *)pickerView2 {
    if (!_pickerView2) {
        _pickerView2  = [[UIPickerView alloc] initWithFrame:self.view.frame];
        _pickerView2.tag  =1;
        _pickerView2.delegate = self;
        _pickerView2.dataSource = self;
    }
    
    return _pickerView2;
}





- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView {
    if (0 == pickerView.tag) {
        return 1;
    } else {
        return 2;
    }
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (0 == pickerView.tag) {
//        if (0 ==component) {
            return self.calendarConfigsArray.count;
//        } else {
//            LSCalendarGroup *group  =self.calendarConfigsArray[self.selectCalendarIndex];
//            return group.dataArray.count;
//
//        }
    } else {
        
        if (0 ==component){
            
            return self.workingconfigsArray.count;
            
        } else {
            LSWorkingDayConfig *confg  = self.workingconfigsArray[self.selectConfigIndex];
            return confg.configs.count;
            
        }
        
    }
    
 
    
}

- (CGFloat)pickerView:(UIPickerView *)pickerView widthForComponent:(NSInteger)component {
    
    
    return self.screenwidth/2;
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
        pickerLabel.numberOfLines = 2;
    }
    pickerLabel.text=[self pickerView:pickerView titleForRow:row forComponent:component];
    return pickerLabel;


}


- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    if (0 == pickerView.tag) {
       
            
            LSCalendarTypeModel *model = self.calendarConfigsArray[row];
            
//            if (model.selected || self.is_vip) {
                return model.name;
//            } else{
//
//                return [NSString stringWithFormat:@"%@🔐",model.name];
//            }

     
        
    } else {
        
        if (0 == component){
            LSWorkingDayConfig *config = self.workingconfigsArray[row];
            
            return   [[NSBundle mainBundle] localizedStringForKey:config.code value:@"" table:@"lish"];
//            return config.configId;
        } else {
            
        
                LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
                LSWorkingDayConfig *subconfig = config.configs[row];
                if (subconfig.is_default) {
                    return [NSString stringWithFormat:@"%@:%@",@"default",subconfig.config];
                } else {
//                    if (self.is_vip) {
                        return subconfig.config;
//                    } else {
//                        return [NSString stringWithFormat:@"%@🔐",subconfig.config];
//                    }
                    
                }
                
           
        }
        
    }
 
    
}





- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component {
    
    return 36;
}




- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component {
    
    if (0 == pickerView.tag) {
        
            self.selectCalendarIndex  = row;
           self.selectCalendarConfig = self.calendarConfigsArray[self.selectCalendarIndex];
        [self calculateCalendar];
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectCalendarIndex forKey:year_calendar_holiday_selectindex_key];
      
        
    } else {
        if (0 ==component) {
           self.selectConfigIndex =  row;
           
           [pickerView reloadComponent:1];
            
            [pickerView selectRow:0 inComponent:1 animated:YES];
            
            self.selectSubConfigIndex = 0;
            
            
       } else {
           self.selectSubConfigIndex  =row;
       }
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectConfigIndex forKey:year_workingday_code_selectindex_key];
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectSubConfigIndex forKey:year_workingday_sub_selectindex_key];
        
        
        LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
        self.selectWorkingCongig = config.configs[self.selectSubConfigIndex];
        [self requstPublicHoliday];
        
    }
    
    
}

- (void)calculateCalendar {
    if (self.selectCalendarConfig && self.selectYear) {
        
        switch (self.selectCalendarConfig.type) {
            case LSCalendarTypeChinese:
                self.selelctFestival = [[LSChineseFestival alloc] initWithYear:self.selectYear];
                break;
            case LSCalendarTypeIslamic:
                self.selelctFestival = [[LSIslamicHolidays alloc] initWithYear:self.selectYear];
                break;
            case LSCalendarTypeHebrew:
                self.selelctFestival = [[LSJewish alloc] initWithYear:self.selectYear];
                break;
            case LSCalendarTypeWorldDay:
                self.selelctFestival = [[LSWorldDay alloc] initWithYear:self.selectYear];
                break;
            case LSCalendarTypeOrthodoxHolidays:
                self.selelctFestival = [[LSOrthodox alloc] initWithYear:self.selectYear];
                break;
            case LSCalendarTypeChristianHolidays:
                self.selelctFestival = [[LSChristian alloc] initWithYear:self.selectYear];
                break;
                
            default:
                break;
        }
        [self.tableView reloadData];
    }
}
- (void)requstPublicHoliday {
    if (self.selectWorkingCongig && self.selectYear) {
        
        
        NSString *config = self.selectWorkingCongig.is_default?@"":self.selectWorkingCongig.config;
        NSDictionary *dict = @{@"year":@(self.selectYear),
                            
                               @"code":self.selectWorkingCongig.code,
                               @"configuration":config
        };
        [LSNetWorkHandler  WorkingDaysYearWithparamater:dict success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
            
           self.holidayArray     = [NSArray yy_modelArrayWithClass:[LSWorkingdayModel class] json:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                
                [self.tableView reloadData];
                
//                if (holidayArray.count) {
//                    LSWorkingdayModel *dayModel = [holidayArray firstObject];
//                    if ([dayModel.month isEqualToString:[NSString stringWithFormat:@"%02d",self.lsmonth.month]]) {
//                        self.holidayArray = holidayArray;
//                        [self.collectionView reloadData];
//                    }
//                }
               
            });
            
        } failed:^(NSError * _Nonnull error) {
            
        }];
        
    }
    
    
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
    
    if (0 == self.selectSegmentIndex) {
//        if (self.selectCalendarConfig.selected || self.is_vip) {
            if (self.selelctFestival) {
                return self.selelctFestival.dataArray.count;
            } else {
                return 0;
            }
//        } else {
//            return 1;
//        }
       
    } else {
//        if (self.selectWorkingCongig.is_default || self.is_vip) {
            return self.holidayArray.count;
//        } else {
//            return 1;
//        }
       
    }
    
 
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    if (0 == self.selectSegmentIndex) {
        return 80;
    } else {
        return 55;
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(nonnull NSIndexPath *)indexPath  {
    
    if (0 == self.selectSegmentIndex) {
        return 80;
    } else {
        return 55;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
   
    
    if (0 == self.selectSegmentIndex) {
        
       
            
            LSFestivalCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
            if (cell == nil) {
                cell  = [[LSFestivalCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            }
            if (self.selelctFestival) {
                id<LSFetivalItem> festival = self.selelctFestival.dataArray[indexPath.row];
                [cell configFestivalItem:festival];
            }
            return cell;
      
       
        
    } else {
        
        
        
            LSDayHolidayCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"holiday"];
            if (cell == nil) {
                cell  = [[LSDayHolidayCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"holiday"];
                cell.selectionStyle =  UITableViewCellSelectionStyleNone;
            }
            
            LSWorkingdayModel *workingday = self.holidayArray[indexPath.row];
            [cell configWorkingDayFromYear:workingday];
            return cell;
   
        
        
    }
    
    
   
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
}

- (void)dealloc {
    

    [[NSNotificationCenter defaultCenter] removeObserver:self];
}





@end
