//
//  LSEraViewController.m
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import "LSEraViewController.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSEraModel.h"

#import "LSEraCell.h"
#import "LSDay.h"
#import "KeyMacro.h"
//#import <GoogleMobileAds/GoogleMobileAds.h>
#import "ProgressHUD.h"


@interface LSEraViewController ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong)UITableView *tableView;

@property(nonatomic,strong)LSEraModel *eraModel;

@property(nonatomic,strong)UIButton *dateButton;

@property(nonatomic,strong)UIButton *ealierButton;
@property(nonatomic,strong)UIButton *laterButton;
@property(nonatomic,strong)UIButton *restoreButton;

@property(nonatomic,assign)NSInteger selectHundredYear;

@property(nonatomic,copy)NSDictionary *dateAttrsDict;

@property(nonatomic,strong)NSMutableArray *calendarArray;

//@property(nonatomic, strong) GADInterstitialAd *interstitial;

@end

@implementation LSEraViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    self.navigationItem.title = self.name;
    
    self.calendarArray = [NSMutableArray array];
    
    [self.view addSubview:self.dateButton];
    [self.view addSubview:self.laterButton];
    [self.view addSubview:self.ealierButton];
    [self.view addSubview:self.restoreButton];
    [self.view addSubview:self.tableView];
    [self.dateButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).offset(2);
        make.height.equalTo(@44);
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
        make.top.equalTo(self.dateButton.mas_bottom).offset(2);
    }];
    
    
    NSDate *date  = [NSDate date];
    LSDate *lsdate = [[LSDate alloc] initWithDate:date];
    NSInteger year = lsdate.localYear;
    self.selectHundredYear =  year/100 *100;
    
    
    [self calculateYear];
    
    
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
    
    if (self.selectHundredYear > 99) {
        self.selectHundredYear = self.selectHundredYear-100;
        
        [self calculateYear];
    } else {
        
        [ProgressHUD showError:NSLocalizedString(@"unsupported_year", nil)];
    }
    
   
    
   
    
    
}


- (void)calculateYear{
    
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%ld",self.selectHundredYear,self.selectHundredYear+99] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
//
//     self.eraModel = [[LSEraModel alloc] initWithType:self.type startYear:self.selectHundredYear endyear:self.selectHundredYear+99];
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (int i = 0; i < 100; i++) {
        LSEra *era = [[LSEra alloc] initWithYear:self.selectHundredYear+i type:self.type];
        [dataArray addObject:era];
    }
    [self.calendarArray removeAllObjects];
    [self.calendarArray addObjectsFromArray:dataArray];
    
        [self.tableView reloadData];
 
    
    
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
    
    self.selectHundredYear = self.selectHundredYear + 100;
    
    [self calculateYear];
    
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
    
    NSDate *date= [NSDate date];
    LSDate *lsdate = [[LSDate alloc] initWithDate:date];
    
    self.selectHundredYear = lsdate.localYear/100*100;
    
   
    
    [self calculateYear];
    
}





- (UITableView *)tableView {
    if (!_tableView) {
        _tableView  = [[UITableView alloc] initWithFrame:self.view.frame style:UITableViewStylePlain];
        _tableView.backgroundColor  = UIColorFromRGB(ViewBackGroundColor    );
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
    return self.calendarArray.count;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  {
    
    return 72;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    LSEraCell *cell  = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell  = [[LSEraCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"cell"];
        
    }
    
    LSEra *eramodel = self.calendarArray[indexPath.row];
    [cell configEraItemModel:eramodel];
    
//    LSEraItemModel *itemModel  = self.eraModel.eraArray[indexPath.row];
//    
//    [cell configEraItemModel:itemModel];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    
    
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
