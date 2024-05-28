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


@interface LSTimeViewController ()<UITableViewDelegate,UITableViewDataSource,CLLocationManagerDelegate,LSDayHeaderViewDelegate,LSLocationAddFooterDelegate>

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
//@property(nonatomic,strong)UIButton *rightButton;

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
      
    }
    
    
    
    
    self.lastUpdateMapTimestmap =  0;
    self.lastUpdateWeatherTimestmap =  0;
    self.sun =  [[LSSun alloc] init];
    self.moon   =[[LSMoon alloc] init];
    
    LSDate *lsdate  = [[LSDate alloc] initWithDate:[NSDate dateWithTimeInterval:0 sinceDate:[NSDate date]]];
    [lsdate calculateLocation];
    [lsdate calculateTwlightLocation];
    self.lsdate = lsdate;
    
    
    [self addTimer];
    
    if ([[NSUserDefaults standardUserDefaults] boolForKey:has_set_mertric]) {
        self.ismerTric = [[NSUserDefaults standardUserDefaults] boolForKey:is_mertric_key];
    } else {
        self.ismerTric = [NSLocalizedString(@"unit_t", nil) isEqualToString:@"C"];
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:has_set_mertric];
        [[NSUserDefaults standardUserDefaults] setBool:self.ismerTric forKey:is_mertric_key];
    }
    
    
    

    

    
    float scale  = 2004/(swidth);


    self.mapScale  = scale;
    
    [self.view addSubview:self.tableView];
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.view);
//        make.bottom.equalTo(self.mapView.mas_top);
    }];
    

    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.leftButton];

    
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(recieveWillEnterbackgroud:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(willEnterforgroud:) name:UIApplicationWillEnterForegroundNotification object:nil];
    
    
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
            for (int i = 1; i < 22; i++) {
                LSCalendarTypeModel *calendarModel = [[LSCalendarTypeModel alloc] initWithType:(LSCalendarType)i];
                [LSDataBaseTool addCalendarType:calendarModel];
            }
            
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"config_store_1"];
            
        }
        
        
        
    } else {
        
        if(![[NSUserDefaults standardUserDefaults] boolForKey:@"config_store_1"]){
            for (int i = 19; i < 22; i++) {
                LSCalendarTypeModel *calendarModel = [[LSCalendarTypeModel alloc] initWithType:(LSCalendarType)i];
                [LSDataBaseTool addCalendarType:calendarModel];
            }
            
        
            LSCalendarTypeModel *ChineseBuddhist = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeChineseBuddhist];
            [LSDataBaseTool updateCalendarGroupWithType:ChineseBuddhist];
            
            LSCalendarTypeModel *zangliBuddhist = [[LSCalendarTypeModel alloc] initWithType:LSCalendarTypeZangli];
            [LSDataBaseTool updateCalendarGroupWithType:zangliBuddhist];
            
           
            
        
            
    
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
      
}


- (void)viewDidAppear:(BOOL)animated {
    
    [super viewDidAppear:animated];
    
    if (![[NSUserDefaults standardUserDefaults] boolForKey:@"HasAllowNetworkKey"]) {
        
         [LSNetWorkHandler requestTest];

         [self networkStatusListen];

      
    }
    
    
    NSInteger showtimes = [[NSUserDefaults standardUserDefaults] integerForKey:@"has_showapptimes_key"];
    
    if (showtimes > 3) {
        
        if (![[NSUserDefaults standardUserDefaults] boolForKey:@"has_Showscore_Key"]) {
            NSSet<UIScene*> *scenes = [UIApplication sharedApplication].connectedScenes;
            
            UIScene *scene;
            for (UIScene *ascene in scenes) {
                if(ascene.activationState == UISceneActivationStateForegroundActive && [ascene isKindOfClass:[UIWindowScene class]]) {
                    scene = ascene;
                    break;
                }
            }
            if (scene) {
                [SKStoreReviewController requestReviewInScene:(UIWindowScene*)scene];
                [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"has_Showscore_Key"];
            }
            
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
    
    
     CLAuthorizationStatus status = self.loctionmanager.authorizationStatus;
    

      if (kCLAuthorizationStatusNotDetermined == status){
          
            [self.loctionmanager requestWhenInUseAuthorization];
          
        } else if (kCLAuthorizationStatusDenied == status || kCLAuthorizationStatusRestricted == status ) {
            
            UIAlertController *alertcontroller = [UIAlertController alertControllerWithTitle:NSLocalizedString(@"note", nil) message:NSLocalizedString(@"location_service", nil) preferredStyle:UIAlertControllerStyleAlert];
            
            UIAlertAction *alertcancelaction = [UIAlertAction actionWithTitle:NSLocalizedString(@"cancel", nil) style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
                
            }];
            
            UIAlertAction *defineaction = [UIAlertAction actionWithTitle:NSLocalizedString(@"go_to_setting", nil) style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
                
                NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
                if([[UIApplication sharedApplication] canOpenURL:url]) {
                    NSURL*url =[NSURL URLWithString:UIApplicationOpenSettingsURLString];
                    //此处可以做一下版本适配，至于为何要做版本适配，大家应该很清楚
                    NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
                    
                    [[UIApplication sharedApplication] openURL:url options:options completionHandler:^(BOOL success) {
                        
                    }];
                }
            }];
            
            [alertcontroller  addAction:alertcancelaction];
            [alertcontroller addAction:defineaction];
            
            
            
            [self presentViewController:alertcontroller animated:YES completion:^{
                
            }];
            
            
        } else {
            [self.loctionmanager startUpdatingLocation];
        }

}

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    
    CLLocation *loc = [locations lastObject];
    
  

    self.location = loc;
    
  

    [self requestLocationKey];
    
    [manager stopUpdatingLocation];
}

- (void)locationManagerDidChangeAuthorization:(CLLocationManager *)manager {
    
    if(kCLAuthorizationStatusDenied == manager.authorizationStatus || kCLAuthorizationStatusRestricted == manager.authorizationStatus){
        
        [self insertLondon];
        
    } else if (kCLAuthorizationStatusAuthorizedWhenInUse == manager.authorizationStatus) {
  
        [self locationrefresh];
    }
}



- (void)insertLondon {
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"london.json" ofType:nil];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    
    NSDictionary *dataDict = [NSJSONSerialization  JSONObjectWithData:data options:kNilOptions error:nil];
    
    LSLocation * currentLocation  = [LSLocation yy_modelWithJSON:dataDict];
    
    [LSDataBaseTool updateLocalLocation:currentLocation];
    
    [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"haslocation_key"];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:locationchanged_note_key object:nil];
    
    dispatch_async(dispatch_get_main_queue(), ^{
        [self reloadData];
    });
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
        
        [LSDataBaseTool updateLocalLocation:currentLocation];
        
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"haslocation_key"];
        
        [[NSNotificationCenter defaultCenter] postNotificationName:locationchanged_note_key object:nil];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self reloadData];
        });
        

    } failed:^(NSError *error) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [ProgressHUD showError:error.localizedDescription];
            
            
            if (![[NSUserDefaults standardUserDefaults] boolForKey:@"haslocation_key"]) {
                [self insertLondon];
              
            }
            
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
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (0 == section){
        return self.dataArray.count;
    }  else {
        return  1;
    }

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    if ( 0 == indexPath.section){
        return 88;
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
    }  else {
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
    if (1 == section) {
        return  CGFLOAT_MIN;
    }
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    if (1 == section){
        return nil;
    } else {
        
        LSDayHeaderView  *headerView  = [tableView  dequeueReusableHeaderFooterViewWithIdentifier:@"header"];
        if (headerView == nil) {
            headerView = [[LSDayHeaderView alloc] initWithReuseIdentifier:@"header"];
            headerView.delegate = self;
            
        }
        
        [headerView.filterButton setImage:nil forState:UIControlStateNormal];
        
        
        headerView.tag =  section;
        
        
        
        headerView.titleLabel.text = NSLocalizedString(@"location", nil);
        
        
        return headerView;
    }
    
}

- (void)lsDayheaderFilterButtonClickSection:(NSInteger)section {
    

    
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section {
    if (1 == section){
        return  CGFLOAT_MIN;
    } else {
        return 44;
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section {
    if (1 == section){
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


- (NSDictionary *)dateAttrsDict {
    if (!_dateAttrsDict) {
        _dateAttrsDict  =@{NSFontAttributeName:[UIFont boldSystemFontOfSize:13.f],
                       NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor)
        };
    }
    return _dateAttrsDict;
}


- (UIUserInterfaceStyle)overrideUserInterfaceStyle {

    return UIUserInterfaceStyleLight;
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
