//
//  LSWeatherViewController.m
//  lishu
//
//  Created by xueping on 2021/3/30.
//

#import "LSWeatherViewController.h"
#import "ColorSizeMacro.h"
#import <YYModel/YYModel.h>
#import "LSDayWeatherCell.h"
#import "LSHourWeatherItemView.h"
#import <Masonry/Masonry.h>
#import "LSNetWorkHandler.h"
#import "LSNetWorkHelper.h"
#import "LSAccuDayWeatherModel.h"
#import "LSAccuWeatherHourModel.h"
#import "LSHourWeatherItemView.h"
#import "KeyMacro.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>
#import "LSAccuFooterView.h"


@interface LSWeatherViewController ()<UITableViewDelegate,UITableViewDataSource,UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,LSAccuFooterViewDelegate>

@property(nonatomic,copy)NSArray *hourArray;
@property(nonatomic,copy)NSArray *dayArray;

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)UIScrollView *scrollView;

@property(nonatomic,strong)UICollectionView *collectionView;

@property(nonatomic,strong)UISegmentedControl *segment;

@property(nonatomic,assign)BOOL isMetric;

//@property(nonatomic, strong) GADInterstitialAd *interstitial;







@end

@implementation LSWeatherViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = UIColorFromRGB(ViewBackGroundColor);
    self.navigationItem.title   =[NSString stringWithFormat:@"%@(%@)",self.location.LocalizedName,self.location.TimeZone.Name];
    [self.view addSubview:self.scrollView];
    [self.scrollView addSubview:self.collectionView];
    [self.view addSubview:self.tableView];
    
    
    [self.scrollView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self.view);
        make.top.equalTo(self.view);
        make.height.equalTo(@90);
    }];
    
    self.scrollView.contentSize  = CGSizeMake(720, 90);
    self.collectionView.frame = CGRectMake(0, 0, 720, 90);
    self.collectionView.showsHorizontalScrollIndicator = YES;
    
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self.view);
        make.top.equalTo(self.scrollView.mas_bottom);
        
    }];
    
    [self requestHour];
    [self requestDay];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:self.segment];
    
    self.isMetric = [[NSUserDefaults standardUserDefaults] boolForKey:is_mertric_key];
    self.segment.selectedSegmentIndex  = self.isMetric ?0:1;
    
    
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

- (void)requestHour {
    
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",self.location.GeoPosition.Latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",self.location.GeoPosition.Longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [LSNetWorkHelper   cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.location.Key,
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    [LSNetWorkHandler accuhourweatherWithparamater:dict success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
       
        self.hourArray   =[NSArray yy_modelArrayWithClass:[LSAccuWeatherHourModel class] json:data];
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.collectionView reloadData];
        });
        
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
    
    
}

- (UISegmentedControl *)segment {
    if (!_segment) {
        _segment    = [[UISegmentedControl alloc] initWithItems:@[@"°C",@"°F"]];
        _segment.tintColor = UIColorFromRGB(TextDarkColor);
        _segment.selectedSegmentIndex = 0;
        
        [_segment addTarget:self action:@selector(segmentClick:) forControlEvents:UIControlEventValueChanged];
        
    }
    return _segment;
}
- (void)segmentClick:(UISegmentedControl *)segment {
    
    self.isMetric = (0 == segment.selectedSegmentIndex);
    
    [[NSUserDefaults standardUserDefaults] setBool:self.isMetric forKey:is_mertric_key];
    
    [[NSNotificationCenter defaultCenter] postNotificationName:unit_change_note_key object:nil];
    
    [self.tableView reloadData];
    [self.collectionView reloadData];
    
}


-(void)requestDay {
    
    NSString   *latitude = [NSString stringWithFormat:@"%0.4f",self.location.GeoPosition.Latitude];
    NSString  *longtitude = [NSString stringWithFormat:@"%0.4f",self.location.GeoPosition.Longitude];
    
    
    NSInteger timestamp = [[NSDate date] timeIntervalSince1970];
    NSInteger total = [LSNetWorkHelper   cacluteTotalWithLat:latitude lon:longtitude time:timestamp];
    
    NSDictionary *dict = @{@"lat":latitude,
                           @"lng":longtitude,
                           @"time":[NSString stringWithFormat:@"%ld",timestamp],
                           @"total":[NSString stringWithFormat:@"%ld",total],
                           @"locationkey":self.location.Key,
                           @"language":NSLocalizedString(@"language", nil)
                           };
    
    [LSNetWorkHandler accudayweatherWithparamater:dict success:^(NSURLResponse * _Nonnull response, id  _Nonnull data) {
        
        NSArray *DailyForecasts   =  [(NSDictionary*)data valueForKey:@"DailyForecasts"];
        
        self.dayArray   =[NSArray yy_modelArrayWithClass:[LSAccuDayWeatherModel class] json:DailyForecasts];
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.tableView reloadData];
        });
        
    } failed:^(NSError * _Nonnull error) {
        
    }];
    
    
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView  = [[UIScrollView alloc] init];
        _scrollView.delegate   =self;
        _scrollView.tag   =0;
    }
    return _scrollView;
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        
        _collectionView = [[UICollectionView alloc] initWithFrame:self.view.frame collectionViewLayout:layout];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.backgroundColor = UIColorFromRGB(navColor);
        [_collectionView registerClass:[LSHourWeatherItemView class] forCellWithReuseIdentifier:@"cell"];
        
      
    }
    
    return _collectionView;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.hourArray.count;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}

- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section {
    return 0;
}


- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    
    
    return CGSizeMake(60,90);
    
}

//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForHeaderInSection:(NSInteger)section {
//    return CGSizeZero;
//}
//-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//    return CGSizeZero;
//}



- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    LSHourWeatherItemView *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    
    LSAccuWeatherHourModel *model = self.hourArray[indexPath.row];
    [cell configModel:model isMertric:self.isMetric];
    
    
    
    return cell;
}



//- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout referenceSizeForFooterInSection:(NSInteger)section {
//
//
//
//        return CGSizeMake(self.screenwidth, 30);
//
//
//
//}







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
        _tableView.tag   =1;
        
    }
    
    return _tableView;
    
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dayArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 115;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSDayWeatherCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSDayWeatherCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        cell.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
    }
    
    LSAccuDayWeatherModel *model  =  self.dayArray[indexPath.row];
    
    [cell configModel:model is_mertric:self.isMetric];
    
    
    return cell;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section   {
    
    if (self.dayArray.count) {
        LSAccuFooterView *footerView = [tableView dequeueReusableHeaderFooterViewWithIdentifier:@"footer"];
        if (footerView == nil) {
            footerView = [[LSAccuFooterView alloc] initWithReuseIdentifier:@"footer"];
            footerView.delegate = self;
        }
        return footerView;
    }
    
    return nil;
    
   
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    if (self.dayArray.count) {
        return 44;
    }
    return CGFLOAT_MIN;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
}

- (void)accuFooterViewTapLink {
    
    NSDictionary *options = @{UIApplicationOpenURLOptionUniversalLinksOnly : @NO};
   
   [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://www.accuweather.com"] options:options completionHandler:^(BOOL success) {
       
   }];

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
//


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
