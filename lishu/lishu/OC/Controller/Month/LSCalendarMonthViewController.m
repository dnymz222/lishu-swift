//
//  LSCalendarMonthViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSCalendarMonthViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSCalendarHeaderView.h"
#import "LSMonthCalendarItemCell.h"
#import "LSDate.h"
#import "LSNetWorkHandler.h"
#import <YYModel/YYModel.h>
#import "LSWorkingDayConfig.h"
#import "LSCalendarGroup.h"
#import "LSDataBaseTool.h"
#import "LSYear.h"
//#import "LSInAppPurchaseViewController.h"
#import "LSCalendarFooterView.h"
#import "KeyMacro.h"
#import "ProgressHUD.h"

@interface LSCalendarMonthViewController ()<UIPickerViewDelegate,UIPickerViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout>

//@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)NSMutableArray *dataArray;
@property(nonatomic,strong)UIPickerView *pickerView;
@property(nonatomic,strong)UIPickerView *pickerView2;

@property(nonatomic,strong)UIScrollView  *scrollView;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)CGFloat screenwidth;

@property(nonatomic,strong)NSCalendar *calendar;


@property(nonatomic,copy)NSArray *holidayArray;

@property(nonatomic,assign)NSInteger firstdayWeekDay;
@property(nonatomic,strong)LSMonth *lsmonth;


@property(nonatomic,assign)NSInteger selectCalendarIndex;
@property(nonatomic,assign)NSInteger selectSubCalendarIndex;

//@property(nonatomic,copy)NSArray *configArray;

@property(nonatomic,assign)NSInteger selectConfigIndex;

@property(nonatomic,assign)NSInteger selectSubConfigIndex;

@property(nonatomic,strong)UISegmentedControl *segMent;

@property(nonatomic,copy)NSArray *workingconfigsArray;
@property(nonatomic,copy)NSArray *calendarConfigsArray;

//@property(nonatomic,assign)BOOL is_vip;

@property(nonatomic,strong)LSWorkingDayConfig *selectConfig;
@property(nonatomic,assign)LSCalendarType selectCalendarType;


@property(nonatomic,strong)LSYear *lsyear;


@property(nonatomic,strong)LSCalendarTypeModel *selectCalendar;


@property(nonatomic,assign)NSInteger selectRow;





@end

@implementation LSCalendarMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
//    self.is_vip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
    
    self.screenwidth = [UIScreen mainScreen].bounds.size.width;
    self.selectRow = -1;
    
    self.workingconfigsArray = [LSDataBaseTool excuteWorkingdaysconfig];
    NSMutableArray *dataArray = [NSMutableArray array];
    for (int i = 0; i < 10; i++) {
        LSCalendarGroup *group = [[LSCalendarGroup alloc] initWithType:i];
        [group createData];
        [dataArray addObject:group  ];
        
    }
    
    self.calendarConfigsArray = dataArray;
    
    self.selectCalendarIndex = [[NSUserDefaults standardUserDefaults] integerForKey:month_calendar_group_selectindex_key];
    self.selectSubCalendarIndex =  [[NSUserDefaults standardUserDefaults] integerForKey:month_calendar_sub_selectindex_key] ;
    self.selectConfigIndex = [[NSUserDefaults standardUserDefaults] integerForKey:month_workingday_code_selectindex_key];
    self.selectSubConfigIndex = [[NSUserDefaults standardUserDefaults] integerForKey:month_workingday_sub_selectindex_key];
    
    self.selectCalendarType  =1;
    
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
//    [self.view addSubview:self.tableView];
//    [self.pickerView   mas_makeConstraints:^(MASConstraintMaker *make) {
//
//        make.left.equalTo(self.view).offset(0);
//        make.right.equalTo(self.view).offset(0);
//        make.top.equalTo(self.view);
//        make.height.equalTo(@120);
//    }];
    
    [self.view addSubview:self.collectionView];
    
//    CGFloat tabheihgt = KIsiPhoneX ? 49+34:49;
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view);
        make.top.equalTo(self.scrollView.mas_bottom);
        
    }];
    
    
    self.calendar    = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    
    
    [self.pickerView selectRow:self.selectCalendarIndex inComponent:0 animated:NO];
    [self.pickerView selectRow:self.selectSubCalendarIndex inComponent:1 animated:NO];
    
    [self.pickerView2 selectRow:self.selectConfigIndex inComponent:0 animated:NO];
    [self.pickerView2 selectRow:self.selectSubConfigIndex inComponent:1 animated:NO];
    
    
    
    
    LSCalendarGroup *group = self.calendarConfigsArray[self.selectCalendarIndex];
    LSCalendarTypeModel *model  = group.dataArray[self.selectSubCalendarIndex];
    self.selectCalendar = model;
    self.selectCalendarType = model.type;
    
    
    
    LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
    self.selectConfig = config.configs[self.selectSubConfigIndex];
    
    
    self.collectionView.contentInset = UIEdgeInsetsMake(0, 0, 40, 0);
    
    
//    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveBuyVipSuccessNote:) name:purchase_success_note_key object:nil];
  
    
//    [self requestConfig];

    
    // Do any additional setup after loading the view.
}

- (void)configLsMonth:(LSMonth *)month {
    
    self.firstdayWeekDay = month.firstdayWeekday;
    
    self.lsmonth = month;
    
    if (!self.lsyear || (self.lsyear.year != month.year)) {
        self.lsyear = [[LSYear alloc] initWithyear:month.year timezone:month.timeZone];
        [self.lsyear createFestilvalArray];
    }
    
    
    
    for (LSDay *day in self.lsmonth.daysArray) {
        [day calculateCalendarWithLSYear:self.lsyear];
    }
    self.holidayArray = nil;
    self.selectRow = -1;
    [self.collectionView reloadData];
    
    [self requestHoliday];
    
//    [[NSNotificationCenter  defaultCenter] addObserver:self selector:@selector(receiveBuyVipSuccessNote:) name:purchase_success_note_key object:nil];
    
    
}

- (void)requestHoliday {
    
    
    if (self.selectConfig) {
        NSString *config = self.selectConfig.is_default?@"":self.selectConfig.config;
        NSDictionary *dict = @{@"year":@(self.lsmonth.year),
                               @"month":[NSString stringWithFormat:@"%02d",self.lsmonth.month],
                               @"code":self.selectConfig.code,
                               @"configuration":config
        };
        [LSNetWorkHandler  WorkingDaysMonthWithparamater:dict success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
            
           NSArray * holidayArray = [NSArray yy_modelArrayWithClass:[LSWorkingdayModel class] json:data];
            dispatch_async(dispatch_get_main_queue(), ^{
                if (holidayArray.count) {
                    LSWorkingdayModel *dayModel = [holidayArray firstObject];
                    if ([dayModel.month isEqualToString:[NSString stringWithFormat:@"%02d",self.lsmonth.month]]) {
                        self.holidayArray = holidayArray;
                        self.selectRow = -1;
                        [self.collectionView reloadData];
                    } else {
                        self.holidayArray = nil;
                        self.selectRow = -1;
                        [self.collectionView reloadData];
                    }
                } else{
                    self.holidayArray = nil;
                    self.selectRow = -1;
                    [self.collectionView reloadData];
                }
               
            });
            
        } failed:^(NSError * _Nonnull error) {
            
            dispatch_async(dispatch_get_main_queue(), ^{
                [ProgressHUD showError:error.localizedDescription];
                self.holidayArray = nil;
                self.selectRow = -1;
                [self.collectionView reloadData];
            });
        }];
        
    }
    
  
}


//-(void)receiveBuyVipSuccessNote:(NSNotification *)note {
//
//
//    self.is_vip = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
//    [self.pickerView reloadAllComponents];
//    [self.pickerView2 reloadAllComponents];
//    self.selectRow = -1;
//    [self.collectionView reloadData];
//
//}

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

- (UISegmentedControl *)segMent {
    if (!_segMent) {
        _segMent = [[UISegmentedControl alloc] initWithItems:@[NSLocalizedString(@"calendar", nil),NSLocalizedString(@"working_days", nil)]];
        _segMent.tintColor = UIColorFromRGB(TextDarkColor);
        _segMent.selectedSegmentIndex  = 0;
        [_segMent addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
    }
    return _segMent;
}
- (void)segmentClick:(UISegmentedControl *)segment {
    
    
    self.scrollView.contentOffset  = CGPointMake(self.screenwidth*segment.selectedSegmentIndex, 0);
    

    
}





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
        return 2;
    } else {
        return 2;
    }
    
}


- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    
    if (0 == pickerView.tag) {
        if (0 ==component) {
            return self.calendarConfigsArray.count;
        } else {
            LSCalendarGroup *group = self.calendarConfigsArray[self.selectCalendarIndex];
            return group.dataArray.count;
            
        }
    } else {
        
        if (0 ==component){
            
            return self.workingconfigsArray.count;
            
        } else {
          
                LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
                return config.configs.count;
          
            
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
        if (0 == component) {
            LSCalendarGroup *group = self.calendarConfigsArray[row];
            
            return group.name;

        } else {
            LSCalendarGroup *group = self.calendarConfigsArray[self.selectCalendarIndex];
            LSCalendarTypeModel *model  = group.dataArray[row];
//            if (model.is_default || self.is_vip) {
                return model.name;
//            } else {
//                return [NSString stringWithFormat:@"%@🔐",model.name];
//            }
            
        }
        
    } else {
        
        if (0 == component){
            LSWorkingDayConfig *config = self.workingconfigsArray[row];
            return  [[NSBundle mainBundle] localizedStringForKey:config.code value:@"" table:@"lish"];
        } else {
            
          
                LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
               LSWorkingDayConfig *subconfig = config.configs[row];
                if (subconfig.is_default ) {
                    return [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"default", nil),subconfig.config];
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
        if (0 == component) {
            self.selectCalendarIndex  = row;
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            self.selectSubCalendarIndex = 0;
        }

        else {
            self.selectSubCalendarIndex  =row;
          
            
        }
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectCalendarIndex forKey:month_calendar_group_selectindex_key];
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectSubCalendarIndex forKey:month_calendar_sub_selectindex_key];
        
        LSCalendarGroup *group = self.calendarConfigsArray[self.selectCalendarIndex];
        LSCalendarTypeModel *model  = group.dataArray[self.selectSubCalendarIndex];
        self.selectCalendar = model;
        self.selectCalendarType = model.type;
        self.selectRow = -1;
        [self.collectionView reloadData];
        
    } else {
        if (0 ==component) {
           self.selectConfigIndex =  row;
           
            [pickerView reloadComponent:1];
            [pickerView selectRow:0 inComponent:1 animated:YES];
            self.selectSubConfigIndex = 0;
       } else {
           self.selectSubConfigIndex  =row;
       }
        
        
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectConfigIndex forKey:month_workingday_code_selectindex_key];
        [[NSUserDefaults standardUserDefaults] setInteger:self.selectSubConfigIndex forKey:month_workingday_sub_selectindex_key];
        
        LSWorkingDayConfig *config = self.workingconfigsArray[self.selectConfigIndex];
        self.selectConfig = config.configs[self.selectSubConfigIndex];
        [self requestHoliday];
        
        
    }
    
    
}







- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
       _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
       _collectionView.dataSource = self;
       _collectionView.delegate = self;
       _collectionView.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
       [_collectionView registerClass:[LSMonthCalendarItemCell class] forCellWithReuseIdentifier:@"cell"];
  
       [_collectionView registerClass:[LSCalendarHeaderView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        
        [_collectionView registerClass:[LSCalendarFooterView class]  forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.lsmonth.days + self.firstdayWeekDay-1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    

    
    return CGSizeMake((self.screenwidth  -6)/7,70);
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSMonthCalendarItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    if (indexPath.row < self.firstdayWeekDay-1) {
        [cell configLsday:nil calendar:self.selectCalendarType];
        [cell configWorkingDayModel:nil];
    } else {
//        BOOL islocked =( self.is_vip || self.selectCalendar.selected)?NO:YES;
        LSDay *day = self.lsmonth.daysArray[indexPath.row-self.firstdayWeekDay+1];
        [cell configLsday:day calendar:self.selectCalendarType  ];
        if (self.holidayArray && self.holidayArray.count) {
            
            
            LSWorkingdayModel *dayModel = self.holidayArray[indexPath.row-self.firstdayWeekDay+1];
            
            [cell configWorkingDayModel:dayModel ];
        } else {
            [cell configWorkingDayModel:nil ];
        }
    }
    
    cell.contentView.backgroundColor = indexPath.row == self.selectRow ? UIColorFromRGB(navColor):UIColorFromRGB(cellbackGroundColor);
    
    
    
   
    
    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeMake(self.screenwidth, 28);
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {

    if (self.selectRow > -1) {
        LSDay *day = self.lsmonth.daysArray[self.selectRow-self.firstdayWeekDay+1];
        LSWorkingdayModel *dayModel ;
        if (self.holidayArray && self.holidayArray.count) {
            
            
            dayModel = self.holidayArray[self.selectRow-self.firstdayWeekDay+1];
            
            
        }
        
        CGFloat height = 20+5+5+20;
        LSCalendarTypeModel *model  = day.clanedarArray[(int)self.selectCalendarType];
        if (model.isFestival) {
            
            
            NSString *festaivalstring = model.festivalString;
            if (LSCalendarTypeZangli == model.type) {
                if (model.zangli && model.zangli.extraInfo2.length > 0) {
                    festaivalstring = [festaivalstring stringByAppendingString:[NSString stringWithFormat:@"\n%@",model.zangli.extraInfo2]];
                }
            }
            
            CGFloat fheight = [festaivalstring boundingRectWithSize:CGSizeMake(self.screenwidth-20, CGFLOAT_MAX) options:NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:15.f]} context:NULL].size.height;
            height = height + fheight;
        }
        
        if (dayModel && dayModel.public_holiday_description.length) {
            height = height+25;
        }
        
        
        return CGSizeMake(self.screenwidth, height);
        
    } else {

        return CGSizeMake(self.screenwidth, 28);
    }

}



- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]){
      
         LSCalendarHeaderView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header" forIndexPath:indexPath];
 
      
        return view;
        
    }  else {
        LSCalendarFooterView *view = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer" forIndexPath:indexPath];
        
        if (self.selectRow > -1) {
            LSDay *day = self.lsmonth.daysArray[self.selectRow-self.firstdayWeekDay+1];
            LSWorkingdayModel *dayModel ;
            if (self.holidayArray && self.holidayArray.count) {
                
                
                dayModel = self.holidayArray[self.selectRow-self.firstdayWeekDay+1];
                
                
            }
            
            [view configDay:day calendarIndex:(int)self.selectCalendarType workingDayModel:dayModel ];
            
            
        } else {
            [view configDay:nil calendarIndex:(int)self.selectCalendarType workingDayModel:nil];
        }
        
        return view;
    }
    
    
    
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    
    [collectionView deselectItemAtIndexPath:indexPath animated:YES];
    
    
    if (indexPath.row < self.firstdayWeekDay-1) {
   
    } else {
//        BOOL iscalendarlocked =( self.is_vip || self.selectCalendar.selected)?NO:YES;
//
//        BOOL isworkinfdaylocked = NO;

//        if (self.holidayArray && self.holidayArray.count) {
//
//
//
//            isworkinfdaylocked=( self.is_vip || self.selectConfig.is_default)?NO:YES;
//
//        }
        
//        if (iscalendarlocked || isworkinfdaylocked) {
//
//            LSInAppPurchaseViewController *inappVC = [[LSInAppPurchaseViewController alloc] init];
//            [self.navigationController pushViewController:inappVC animated:YES];
//
//        } else {
            
            self.selectRow = indexPath.row;
            [self.collectionView reloadData];
            
//        }
    }
}

- (void)dealloc {
    [[NSNotificationCenter  defaultCenter] removeObserver:self];
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
