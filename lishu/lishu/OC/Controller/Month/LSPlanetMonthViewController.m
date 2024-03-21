//
//  LSPlanetMonthViewController.m
//  lishu
//
//  Created by xueping on 2021/4/3.
//

#import "LSPlanetMonthViewController.h"
#import "LSRiseSetTime.h"
#import "LSMonthRiseSetCell.h"
#import "LSMonthRiseSetHeaderView.h"
#import "ColorSizeMacro.h"
#import "LSMonth.h"
#import <Masonry/Masonry.h>
#import "KeyMacro.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>

@interface LSPlanetMonthViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIButton *dateButton;

@property(nonatomic,strong)UIButton *ealierButton;
@property(nonatomic,strong)UIButton *laterButton;


@property(nonatomic,copy)NSDictionary *dateAttrsDict;

@property(nonatomic,assign)NSInteger selectYear;
@property(nonatomic,assign)NSInteger selectMonth;

@property(nonatomic,strong)LSMonth *selectLSMonth;



@property(nonatomic,strong)UIButton *restoreButton;


@property(nonatomic,strong)NSMutableArray *dataArray;


@property(nonatomic,strong)UILabel *locationLabel;

//@property(nonatomic, strong) GADInterstitialAd *interstitial;

@end

@implementation LSPlanetMonthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    [self.view addSubview:self.locationLabel];
    self.locationLabel.text = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
    self.navigationItem.title = self.planet.name;
    [self.locationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(10);
        make.left.equalTo(self.view).offset(10);
        make.right.equalTo(self.view).offset(-10);
        make.height.equalTo(@20);
    }];
    
    [self.view addSubview:self.locationLabel];
    
    [self.view addSubview:self.dateButton];
    [self.view addSubview:self.laterButton];
    [self.view addSubview:self.ealierButton];
    [self.view addSubview:self.restoreButton];
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(@118);
    }];
    
    [self.ealierButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.dateButton.mas_left).offset(-5);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [self.laterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.dateButton.mas_right).offset(5);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    [self.restoreButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.laterButton.mas_right).offset(20);
        make.top.equalTo(self.locationLabel.mas_bottom).offset(10);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.dateButton.mas_bottom);
    }];
    
    LSDate *date = [[LSDate alloc] initWithDate:[NSDate date] timezoneName:self.selectLocation.TimeZone.Name];
    self.selectYear = date.localYear;
    self.selectMonth  = date.localMonth;
    NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
    [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
    LSMonth * selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
    
    for (LSDay *day in selectLSMonth.daysArray) {
        
        day.planetRiseSetTime = [self.planet calculateRiseTransitSetWithZeroJD:day.jd location:self.selectLocation.GeoPosition];
    }
    self.selectLSMonth = selectLSMonth;
    
    [self.tableView reloadData];
    
//    if (![[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key]) {
//
//        NSString *unitID;
//#if DEBUG
//        unitID = @"ca-app-pub-3940256099942544/4411468910";
//
//#else
//        unitID =  admob_insert;
//#endif
//
//        GADRequest *request = [GADRequest request];
//          [GADInterstitialAd loadWithAdUnitID:unitID
//                                          request:request
//                                completionHandler:^(GADInterstitialAd *ad, NSError *error) {
//            if (error) {
//              NSLog(@"Failed to load interstitial ad with error: %@", [error localizedDescription]);
//              return;
//            }
//            self.interstitial = ad;
//            self.interstitial.fullScreenContentDelegate = self;
//
//              if (self.interstitial) {
//                  [self.interstitial presentFromRootViewController:self];
//                }
//          }];
//    }
//
    
    // Do any additional setup after loading the view.
}

- (UILabel *)locationLabel {
    if (!_locationLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _locationLabel = label;
    }
    return _locationLabel;
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
    
    if (1 == self.selectMonth) {
        
        self.selectMonth = 12;
        self.selectYear = self.selectYear -1;
    } else {
        self.selectMonth = self.selectMonth-1;
    }
    
    [self calculate];
    
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
    
    if (12 == self.selectMonth) {
        
        self.selectMonth = 1;
        self.selectYear = self.selectYear +1;
    } else {
        self.selectMonth = self.selectMonth+1;
    }
    if (self.selectLocation) {
        
        
        [self calculate];
        
        
    }
    
}

- (void)calculate {
    
    NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
    [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
    
    LSMonth * selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
    
    for (LSDay *day in selectLSMonth.daysArray) {
        
        day.planetRiseSetTime = [self.planet calculateRiseTransitSetWithZeroJD:day.jd location:self.selectLocation.GeoPosition];
    }
    self.selectLSMonth = selectLSMonth;
    
    [self.tableView reloadData];
}

-(UIButton *)dateButton {
    if (!_dateButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        
//        button.layer.cornerRadius =  3;
//        button.layer.borderWidth  =2;
//        button.layer.borderColor   = UIColorFromRGB(TextDarkColor).CGColor;
//        button.layer.masksToBounds  =  YES;
      
        [button addTarget:self action:@selector(dateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _dateButton  = button;
    }
    return _dateButton;
}

-(void)dateButtonClick:(UIButton *)button {
    
}


- (NSDictionary *)dateAttrsDict {
    if (!_dateAttrsDict) {
        _dateAttrsDict  =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:17.f],
                       NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor)
        };
    }
    return _dateAttrsDict;
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
    
    if (self.selectLocation) {
        LSDate *lsdate = [[LSDate alloc] initWithDate:[NSDate date] timezoneName:self.selectLocation.TimeZone.Name];
        
        self.selectYear = lsdate.localYear;
        self.selectMonth = lsdate.localMonth;
        
       
        
        [self calculate];
       
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
    if (self.selectLSMonth) {
        return self.selectLSMonth.daysArray.count;
    } else {
        return 0;
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 44;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSMonthRiseSetCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSMonthRiseSetCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
    }
    
    LSDay *day = self.selectLSMonth.daysArray[indexPath.row];
    [cell configPlanetRisetSetTime:day.planetRiseSetTime day:day];
    return cell;
}
    
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
        return 44;
}
- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
        
    LSMonthRiseSetHeaderView *headerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSMonthRiseSetHeaderView alloc] initWithReuseIdentifier:@"header"];
    }
    return headerView;
        
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    
}



//- (void)adDidRecordImpression:(nonnull id<GADFullScreenPresentingAd>)ad{
//
//
//}
//
///// Tells the delegate that the ad failed to present full screen content.
//- (void)ad:(nonnull id<GADFullScreenPresentingAd>)ad
//didFailToPresentFullScreenContentWithError:(nonnull NSError *)error {
//
//}
//
///// Tells the delegate that the ad presented full screen content.
//- (void)adDidPresentFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{
//
//}
//
///// Tells the delegate that the ad dismissed full screen content.
//- (void)adDidDismissFullScreenContent:(nonnull id<GADFullScreenPresentingAd>)ad{
//
//}



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
