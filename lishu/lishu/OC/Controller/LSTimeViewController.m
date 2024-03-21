//
//  LSTimeViewController.m
//  lishu
//
//  Created by xueping on 2021/2/28.
//

#import "LSTimeViewController.h"
#import "LSClockView.h"
#import <Masonry/Masonry.h>
#import <MapKit/MapKit.h>
#import "ColorSizeMacro.h"
#import "LSTimeZoneMapLocation.h"
#import "LSTimeZoneMapView.h"
#import "LSDate.h"
#import "LSLandscapeMapViewController.h"
#import <CoreLocation/CoreLocation.h>
#import "LSNetWorkHandler.h"
#import<CoreTelephony/CTCellularData.h>
#import "LSNetWorkHelper.h"
#import "LSLocation.h"
#import <YYModel/YYModel.h>
#import "LSWorldClockCell.h"
#import "LSLocationManagerViewController.h"
#import "LSWeatherViewController.h"
#import "LSHandler.h"
#import "LSSun.h"
#import "LSMoon.h"
#import "LSDataBaseTool.h"
#import "LSTimeHeaderView.h"
#import "LSWorkingDayConfig.h"
#import "LSCalendarTypeModel.h"
#import "KeyMacro.h"
//#import <AppTrackingTransparency/AppTrackingTransparency.h>
//#import <AdSupport/AdSupport.h>
//#import <GoogleMobileAds/GoogleMobileAds.h>
#import <StoreKit/StoreKit.h>
#import "KeyMacro.h"

#import "ProgressHUD.h"
#import "LSTimeDetailViewController.h"
#import "LSWorldClockItemCell.h"
#import "LSDayHeaderView.h"
#import "LSClockPersonCell.h"
#import "LSClockMapCell.h"
#import "LSLishuRoleModel.h"
#import "LSLocationAddFooter.h"


@interface LSTimeViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,UICollectionViewDelegate,UICollectionViewDataSource,LSDayHeaderViewDelegate,LSLocationAddFooterDelegate>

@property(nonatomic,strong)LSClockView *clockView;




@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,copy)NSArray *dataArray;


@property(nonatomic,strong)UIScrollView  *scrollView;

@property(nonatomic,strong)LSTimeZoneMapView *mapView;


@property(nonatomic,strong)CLLocationManager*loctionmanager;


@property(nonatomic,copy)NSString *locationKey;

@property(nonatomic,strong)CLLocation *location;

@property(nonatomic,strong)UILabel *titleLabel;

@property(nonatomic,strong)UIButton *leftButton;
@property(nonatomic,strong)UIButton *rightButton;

//@property(nonatomic,strong)LSLocation *currentLocation;

//@property(nonatomic,strong)UIButton *ealierButton;
//@property(nonatomic,strong)UIButton *laterButton;
@property(nonatomic,copy)NSDictionary *dateAttrsDict;
//@property(nonatomic,strong)UIButton *dateButton;
//
//
//
//@property(nonatomic,strong)UIButton *restoreButton;

@property(nonatomic,assign)NSInteger lastUpdateMapTimestmap;//5分钟

@property(nonatomic,assign)NSInteger lastUpdateWeatherTimestmap;//15分钟

@property(nonatomic,strong)LSSun *sun;
@property(nonatomic,strong)LSMoon *moon;

@property(nonatomic,strong)NSDate *selectMapDate;
@property(nonatomic,assign)float mapScale;

@property(nonatomic,assign)BOOL ismerTric;


@property(nonatomic,strong)LSDate *lsdate;


@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,copy)NSArray *personArray;




@end

@implementation LSTimeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
    
//    self.navigationItem.titleView = self.titleLabel;
    
    CGFloat swidth  = [UIScreen mainScreen].bounds.size.width;
    
    self.navigationItem.titleView = self.titleLabel;
    
    
    

    
    
    
    self.dataArray = [LSDataBaseTool excuteLocationArray];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"haslocation_key"]) {
        [self locationrefresh];
    } else{
    
        
        
    }
    
    
    
    
    
    self.lastUpdateMapTimestmap =  0;
    self.lastUpdateWeatherTimestmap =  0;
    self.sun =  [[LSSun alloc] init];
    self.moon   =[[LSMoon alloc] init];
    
    LSDate *lsdate  = [[LSDate alloc] initWithDate:[NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]]];
    [lsdate calculateLocation];
    [lsdate calculateTwlightLocation];
    self.lsdate = lsdate;
    
    
    
    
    
//    [self.view addSubview:self.clockView];
//    [self.clockView  mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerX.equalTo(self.view);
//        make.top.equalTo(self.view).offset(10);
//        make.height.equalTo(@100);
//        make.width.equalTo(@100);
//    }];
//    [self.clockView configHour:3 minutes:26 seconds:50];
//
    
    
    [self addTimer];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:has_set_mertric]) {
        self.ismerTric = [[NSUserDefaults standardUserDefaults] boolForKey:is_mertric_key];
    } else {
//        self.ismerTric = [[NSUserDefaults standardUserDefaults] boolForKey:is_mertric_key];
        self.ismerTric = [NSLocalizedString(@"unit_t", nil) isEqualToString:@"C"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:has_set_mertric];
        [[NSUserDefaults standardUserDefaults] setBool:self.ismerTric forKey:is_mertric_key];
    }
    
    
    
    
//    BOOL removeAd = [[NSUserDefaults standardUserDefaults] boolForKey:is_vip_key];
//
//    self.is_vip  = removeAd;
    
    
    
//    CGFloat adheight = 0;
//    if (removeAd) {
//        adheight = 0;
//    }
//
    

    
    float scale  = 2004/(swidth);
//    [self.view addSubview:self.mapView];
//    self.mapView.frame  = CGRectMake(0, 0, 2004/scale, 1195/scale);
    
//    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.view);
//        make.right.equalTo(self.view);
//        make.bottom.equalTo(self.view);
//        make.height.equalTo(@(1195/scale));
//    }];
//
    self.mapScale  = scale;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
//        make.bottom.equalTo(self.mapView.mas_top);
    }];
    
//    NSLog(@"123333444_begin");
    

    

//    [self.mapView configLocationArray:lsdate.locationArray scale:scale fix:lsdate.fix];
//
//    NSLog(@"123333444_end");
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];
    self.navigationItem.rightBarButtonItem   =[[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveWillEnterbackgroud:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterforgroud:) name:UIApplicationWillEnterForegroundNotification object:nil];
    

//
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"config_store"]) {
        
        NSString *path = [[NSBundle mainBundle] pathForResource:@"workingconfig.json" ofType:nil];
        NSData *data = [[NSData alloc] initWithContentsOfFile:path];
        
        NSArray *dataArray = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
        
        
        NSArray *data_configs = [NSArray  yy_modelArrayWithClass:[LSWorkingDayConfig class] json:dataArray ];
        for (LSWorkingDayConfig *config in data_configs) {
            [LSDataBaseTool addWorkingDayConfig:config];
        }
        
     
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"config_store"];
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"config_store_1"]){
            for (int i = 1; i < 27; i++) {
                LSCalendarTypeModel *calendarModel = [[LSCalendarTypeModel alloc] initWithType:(LSCalendarType)i];
                [LSDataBaseTool addCalendarType:calendarModel];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"config_store_1"];
            
        }
        
        
        
    } else {
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"config_store_1"]){
            for (int i = 19; i < 27; i++) {
                LSCalendarTypeModel *calendarModel = [[LSCalendarTypeModel alloc] initWithType:(LSCalendarType)i];
                [LSDataBaseTool addCalendarType:calendarModel];
            }
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"config_store_1"];
            
        }
    }
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveLocationChangedNote:) name:locationchanged_note_key object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receiveUnitChangeNote:) name:unit_change_note_key object:nil];
    

    
    
    
    

    
    
    NSInteger showtimes = [[NSUserDefaults standardUserDefaults] integerForKey:@"has_showapptimes_key"];
    if (showtimes < 100) {
        showtimes  = showtimes + 1;
        [[NSUserDefaults standardUserDefaults] setInteger:showtimes forKey:@"has_showapptimes_key"];
    }
      

    
    
    
    
    // Do any additional setup after loading the view.
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasAllowNetworkKey"]) {
        
          [LSNetWorkHandler requestTest];

              [self networkStatusListen];

      
    }
    
    
    NSInteger showtimes = [[NSUserDefaults standardUserDefaults] integerForKey:@"has_showapptimes_key"];
    
    if (showtimes > 5) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"has_Showscore_Key"]) {
             [SKStoreReviewController requestReview];
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"has_Showscore_Key"];
        }
    }
  
    
}

- (void)networkStatusListen{
    //2.根据权限执行相应的交互
    CTCellularData *cellularData = [[CTCellularData alloc] init];
    
    if (cellularData.restrictedState == kCTCellularDataRestricted ||
        cellularData.restrictedState == kCTCellularDataRestrictedStateUnknown) {
        /*
         此函数会在网络权限改变时再次调用
         */
        cellularData.cellularDataRestrictionDidUpdateNotifier = ^(CTCellularDataRestrictedState state) {
            switch (state) {
                case kCTCellularDataRestricted:
                    

                    
                    break;
                case kCTCellularDataNotRestricted:
                
                    

                    if (self.location) {
                        [self requestLocationKey];
                    }
                    
                    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"HasAllowNetworkKey"];
                    
                    break;
                case kCTCellularDataRestrictedStateUnknown:
                    
                    //                    [self reloadAlldata];
//                    [self requestWeather];
                    
                    
                    break;
                    
                default:
                    break;
            }
        };
    }
    
    
}


- (void)receiveUnitChangeNote:(NSNotification *)note {
    
    self.ismerTric = [[NSUserDefaults standardUserDefaults] boolForKey:is_mertric_key];
    [self.tableView reloadData];
}



- (void)receiveLocationChangedNote:(NSNotification *)note {
    
    
    self.dataArray = [LSDataBaseTool excuteLocationArray];
    
    self.lastUpdateMapTimestmap =  0;
    self.lastUpdateWeatherTimestmap =  0;
    
    [self.tableView reloadData];
    
    
}



- (void)recieveWillEnterbackgroud:(NSNotification *)note {
    
    [self removeTimer];
}

- (void)willEnterforgroud:(NSNotification *)note {
    
    [self addTimer];
}

- (void)removeTimer {
    if (_timer) {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)addTimer {
    if (!_timer) {
        _timer  = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerRun) userInfo:nil repeats:YES];
       
    }
    
    [[NSRunLoop currentRunLoop] addTimer:_timer forMode:NSRunLoopCommonModes];
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 230, 30)];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:17.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _titleLabel = label;
    }
    return _titleLabel;
}


- (void)timerRun {
    
//    NSCalendar *calendar  = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    NSDate *date  = [NSDate date];
    
    self.titleLabel.text  = [NSString stringWithFormat:@"%@",date];
    
    
    NSInteger timestamp =  [date timeIntervalSince1970];
    
    
//    if (self.currentLocation) {
//
//        [self.currentLocation calcuteDate:date];
//
//
//
//    }
    
    
    for (LSLocation *location in self.dataArray) {
        
        [location calcuteDate:date isShow:0 == self.tabBarController.selectedIndex ];
    }
    
    [self.tableView reloadData];
    
    
    
    if (timestamp -self.lastUpdateMapTimestmap > 15*60) {
        self.lastUpdateMapTimestmap  = timestamp;
        
        LSDate *lsdate  = [[LSDate alloc] initWithDate:date];
        [lsdate calculateLocation];
        [lsdate calculateTwlightLocation];
        self.lsdate = lsdate;
        
//        [self.mapView configLocationArray:lsdate.locationArray scale:self.mapScale fix:lsdate.fix];
//
//        [self.mapView configTwilightLocationArray:lsdate.twlightLocationArray scale:self.mapScale fix:lsdate.fix];
//
        
        self.selectMapDate = date;
        
        self.sun.jd  = lsdate.JD;
        [self.sun calculateSun];
        self.moon.jd  =  lsdate.JD;
        
        [self.moon calculateMoon];
        
        
        for (LSLocation *location in self.dataArray) {
            [location    calculateSun:self.sun];
            [location calculateMoon:self.moon];
        }
        
        
        [self.tableView reloadData];
        
        
    }
    
    
    
    
    
    
    
    
}

-(UIButton *)leftButton {
    if (!_leftButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image  = [UIImage imageNamed:@"shuaxin"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(leftButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _leftButton  = button;
    }
    return _leftButton;
}

-(void)leftButtonClick:(UIButton *)button {
    
    [self locationrefresh   ];
    
}

-(UIButton *)rightButton {
    if (!_rightButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image  = [UIImage imageNamed:@"add"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton  = button;
    }
    return _rightButton;
}

-(void)rightButtonClick:(UIButton *)button {
    
    LSLocationManagerViewController *managerVC  = [[LSLocationManagerViewController alloc] init];
    [self.navigationController pushViewController:managerVC animated:YES];
    
    
    
}




- (void)fullButtonClick:(UIButton *)button {
    
    LSLandscapeMapViewController *landVC  =[[LSLandscapeMapViewController alloc] init];
    landVC.date   = [NSDate date];
    
    [self.navigationController pushViewController:landVC animated:YES];
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc] init];
    }
    return _scrollView;
}

- (LSTimeZoneMapView *)mapView {
    if (!_mapView) {
        _mapView  =[[LSTimeZoneMapView alloc] init];
    }
    return _mapView;
}

- (LSClockView *)clockView {
    if (!_clockView) {
        _clockView  = [[LSClockView alloc] init];
        
    }
    return _clockView;
}



- (CLLocationManager *)loctionmanager
{
    if (_loctionmanager == nil) {
        _loctionmanager =[[CLLocationManager alloc]init ];
        _loctionmanager.delegate =self;
        //self.loctionmanager =_loctionmanager;
    }
    
    
    return _loctionmanager;
}



- (void)locationrefresh
{
    
    
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    if ([CLLocationManager locationServicesEnabled]) {
        if ([[[UIDevice currentDevice] systemVersion] floatValue] >8.0) {
            
            [self.loctionmanager requestWhenInUseAuthorization];
            
            
        }
        
        
        [self.loctionmanager startUpdatingLocation];
        
        if ([[NSUserDefaults standardUserDefaults] boolForKey:@"refreshed"]) {
            if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status ) {
                
                
               
                
            }
            
        }
        else{
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"refreshed"];
            
           
        }
        
    
    }

    
}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *loc = [locations lastObject];
    
  

    self.location = loc;
    
  

    [self requestLocationKey];
    
    [manager stopUpdatingLocation];
}




- (void)requestLocationKey {
    
    
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",self.location.coordinate.latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",self.location.coordinate.longitude];
#if DEBUG
//    latitude = @"29";
//    longtitude  =@"91";
#endif
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [LSNetWorkHelper cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
  
    
    [LSNetWorkHandler locationkeyWithparamater:dict success:^(NSURLResponse *response, id data) {
        
        LSLocation * currentLocation  = [LSLocation yy_modelWithJSON:data];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"haslocation_key"];
        
//        [LSHandler shareHandler].currentLocation   =  self.currentLocation;
        
        
        
        
        [LSDataBaseTool updateLocalLocation:currentLocation];
        
        
        [[NSNotificationCenter defaultCenter] postNotificationName:locationchanged_note_key object:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        
        
        
        
    } failed:^(NSError *error) {
        

        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [ProgressHUD showError:error.localizedDescription];
            
        });
       
    }];
    
}

- (void)reloadData {
    
    self.dataArray = [LSDataBaseTool excuteLocationArray];
    
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
        if (@available(iOS 15.0, *)) {
            _tableView.sectionHeaderTopPadding = 0;
        }
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 3;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section){
        return self.dataArray.count;
    } else if(1 == section){
        return  self.personArray.count;
    } else {
        return  1;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if ( 0 == indexPath.section){
        return 88;
    } else if (1 == indexPath.section){
        return 144;
    } else {
        return  1195 / self.mapScale;
    }
    
}



- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if( 0 == indexPath.section){
        
        LSWorldClockCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
        if (cell == nil) {
            cell  = [[LSWorldClockCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
            cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
        
        
        
        LSLocation *location  = self.dataArray[indexPath.row];
        [cell configLocation:location isMetric:self.ismerTric];
        
        
        
        return cell;
    } else if (1 == indexPath.section){
        LSClockPersonCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"person"];
        if (cell == nil) {
            cell  = [[LSClockPersonCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"person"];
            cell.accessoryType =  UITableViewCellAccessoryDisclosureIndicator;
            
        }
        
    
        return cell;
    } else {
        LSClockMapCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"map"];
        if (cell == nil) {
            cell  = [[LSClockMapCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"map"];
            [cell.fullButton addTarget:self action:@selector(fullButtonClick:) forControlEvents:UIControlEventTouchUpInside];
            cell.accessoryType =  UITableViewCellAccessoryNone;
            
        }
        if(self.lsdate){
            [cell.mapview configLocationArray:self.lsdate.locationArray scale:self.mapScale fix:self.lsdate.fix];
      
            [cell.mapview configTwilightLocationArray:self.lsdate.twlightLocationArray scale:self.mapScale fix:self.lsdate.fix];
        }
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section  {
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    LSDayHeaderView  *headerView  = [tableView  dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
    if (headerView == nil) {
        headerView = [[LSDayHeaderView alloc] initWithReuseIdentifier:@"header"];
        headerView.delegate = self;
        
    }
    if (2 == section) {
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
    
    if (0 == section) {
        
//        LSCalendarTypefilterViewController *filterVC  =[[LSCalendarTypefilterViewController alloc] init];
//
//        [self.navigationController pushViewController:filterVC animated:YES];
//

        
    }else if (1 == section) {
//        LSWorkingDayConfigFilterViewController *configVc = [[LSWorkingDayConfigFilterViewController alloc] init];
//        [self.navigationController pushViewController:configVc animated:YES];
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (2 == section){
        return  CGFLOAT_MIN;
    } else {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (2 == section){
        return nil;
    } else {
        LSLocationAddFooter *footer  = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        if (footer == nil) {
            footer = [[LSLocationAddFooter alloc] initWithReuseIdentifier:@"footer"];
            footer.delegate   = self;
        }
        footer.tag = section;
        return footer;
    }
    
}

- (void)locationAddFooterViewClick:(UIView *)view {
    if(0 == view.tag){
        LSLocationManagerViewController *managerVC  = [[LSLocationManagerViewController alloc] init];
        [self.navigationController pushViewController:managerVC animated:YES];
    }
    
}



- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    if (0 == indexPath.section){
        
        LSWeatherViewController *weatherVC   =[[LSWeatherViewController alloc] init];
        
        LSLocation *location  = self.dataArray[indexPath.row];
        weatherVC.location   = location;
        
        [self.navigationController pushViewController:weatherVC animated:YES];
    }
    

}

//-(UIButton *)ealierButton {
//    if (!_ealierButton) {
//        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, 44, 44);
//        UIImage *image   =[UIImage imageNamed:@"xiangqian"];
//        [button setImage:image forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(earlierButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        _ealierButton  = button;
//    }
//    return _ealierButton    ;
//}
//
//-(void)earlierButtonClick:(UIButton *)button {
//
//}
//
//-(UIButton *)laterButton {
//    if (!_laterButton ) {
//        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, 44, 44);
//        UIImage *image   =[UIImage imageNamed:@"xianghou"];
//        [button setImage:image forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(laterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        _laterButton  = button;
//    }
//    return _laterButton    ;
//}
//
//- (void)laterButtonClick:(UIButton *)button {
//
//}
//
//-(UIButton *)dateButton {
//    if (!_dateButton) {
//        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
////        button.layer.cornerRadius =  3;
////        button.layer.borderWidth  =2;
////        button.layer.borderColor   = UIColorFromRGB(TextDarkColor).CGColor;
////        button.layer.masksToBounds  =  YES;
//        button.bounds = CGRectMake(0, 0, 44, 44);
//
//        [button addTarget:self action:@selector(dateButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        _dateButton  = button;
//    }
//    return _dateButton;
//}
//
//-(void)dateButtonClick:(UIButton *)button {
//
//}

- (NSDictionary *)dateAttrsDict {
    if (!_dateAttrsDict) {
        _dateAttrsDict  =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.f],
                       NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor)
        };
    }
    return _dateAttrsDict;
}

//-(UIButton *)restoreButton {
//    if (!_restoreButton) {
//        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
//        button.bounds = CGRectMake(0, 0, 44, 44);
//        UIImage *image   =[UIImage imageNamed:@"huanyuan"];
//        [button setImage:image forState:UIControlStateNormal];
//        [button addTarget:self action:@selector(restoreButtonClick:) forControlEvents:UIControlEventTouchUpInside];
//        _restoreButton  = button;
//    }
//    return _restoreButton    ;
//}
//
//- (void)restoreButtonClick:(UIButton *)button {
//
//}



/// Tells the delegate an ad request loaded an ad.
//- (void)adViewDidReceiveAd:(GADBannerView *)adView {
////  NSLog(@"adViewDidReceiveAd");
////    [self.view bringSubviewToFront:adView];
//}
//
///// Tells the delegate an ad request failed.
//- (void)adView:(GADBannerView *)adView
//    didFailToReceiveAdWithError:(NSError *)error {
////    if ([self.bannerView.adUnitID isEqualToString:@"ca-app-pub-3940256099942544/2934735716"]) {
////
////    } else {
////     self.bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
////     [self.bannerView loadRequest:[GADRequest request]];
////    }
//
////  NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
//
//
//}
//
///// Tells the delegate that a full-screen view will be presented in response
///// to the user clicking on an ad.
//- (void)adViewWillPresentScreen:(GADBannerView *)adView {
////  NSLog(@"adViewWillPresentScreen");
//}
//
///// Tells the delegate that the full-screen view will be dismissed.
//- (void)adViewWillDismissScreen:(GADBannerView *)adView {
////  NSLog(@"adViewWillDismissScreen");
//}
//
///// Tells the delegate that the full-screen view has been dismissed.
//- (void)adViewDidDismissScreen:(GADBannerView *)adView {
////  NSLog(@"adViewDidDismissScreen");
//}
//
///// Tells the delegate that a user click will open another app (such as
///// the App Store), backgrounding the current app.
//- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
////  NSLog(@"adViewWillLeaveApplication");
//}



- (UIUserInterfaceStyle)overrideUserInterfaceStyle {

    return UIUserInterfaceStyleLight;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        
        [_collectionView registerClass:[LSWorldClockItemCell class] forCellWithReuseIdentifier:@"cell"];
        
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 1;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return CGSizeMake(collectionView.bounds.size.width /4 - 5, 88 );
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSWorldClockItemCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];

    return cell;
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
    return CGSizeZero;
}


- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    
    
    return nil;
    
}




- (void)dealloc {
    
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
