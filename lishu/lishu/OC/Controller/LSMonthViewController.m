//
//  LSMonthViewController.m
//  lishu
//
//  Created by xueping on 2021/2/28.
//

#import "LSMonthViewController.h"
#import "ColorSizeMacro.h"
#import "LSLocation.h"
#import <Masonry/Masonry.h>
#import "LSHandler.h"
#import "LSMonthSunViewController.h"
#import "LSMonthMoonViewController.h"
//#import "LSCalendarListMonthViewController.h"
#import "LSCalendarMonthViewController.h"
#import "LSAstroMonthListViewController.h"
#import "LSPlanetListViewController.h"
#import "LSStarListViewController.h"
#import "LSConstellationListViewController.h"
#import "LSTwightMonthViewController.h"
#import "LSDay.h"
#import "LSMonth.h"
#import "LSDate.h"




@interface LSMonthViewController ()<LSHandlerDelegate>
@property(nonatomic,strong)LSLocation *selectLocation;


@property(nonatomic,strong)UIButton *dateButton;

@property(nonatomic,strong)UIButton *ealierButton;
@property(nonatomic,strong)UIButton *laterButton;


@property(nonatomic,copy)NSDictionary *dateAttrsDict;

@property(nonatomic,strong)UIButton *rightButton;

@property(nonatomic,strong)UIButton *restoreButton;


@property(nonatomic,copy)NSArray *typeArray;

@property(nonatomic,strong)LSHandler *lsHandler;

@property(nonatomic,assign)NSInteger selectYear;
@property(nonatomic,assign)NSInteger selectMonth;

@property(nonatomic,strong)NSDate *selectDate;

@property(nonatomic,strong)LSMonth *selectLSMonth;

//@property(nonatomic,assign)NSInteger selectIndex;

@end

@implementation LSMonthViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.typeArray  = @[NSLocalizedString(@"calendar", nil),NSLocalizedString(@"sun", nil),NSLocalizedString(@"moon", nil),NSLocalizedString(@"astronomy", nil)];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuView.lineColor = UIColorFromRGB(TextDarkColor);
        self.menuView.scrollView.backgroundColor = UIColorFromRGB(navColor);
        
        self.titleSizeNormal = 13.f;
        self.titleSizeSelected = 14.f;
        self.titleColorNormal = UIColorFromRGB(0x666666);
        self.titleColorSelected= UIColorFromRGB(TextDarkColor);
//        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh:) name:requestWeatherDoneKey object:nil];
    }
    
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor   = UIColorFromRGB(ViewBackGroundColor);
    
    [self.view addSubview:self.dateButton];
    [self.view addSubview:self.laterButton];
    [self.view addSubview:self.ealierButton];
    [self.view addSubview:self.restoreButton];
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
        make.left.equalTo(self.laterButton.mas_right).offset(20);
        make.top.equalTo(self.view).offset(2);
        make.height.equalTo(@44);
        make.width.equalTo(@44);
    }];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
   
    
    
    NSDate *date = [NSDate date];
    
    self.selectDate = date;
    
    if (self.lsHandler.selectLocation) {
        self.selectLocation = self.lsHandler.selectLocation;
        LSDate *lsdate = [[LSDate alloc] initWithDate:date timezoneName:self.selectLocation.TimeZone.Name];
        
        self.selectYear = lsdate.localYear;
        self.selectMonth = lsdate.localMonth;
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
        
        
        
        LSCalendarMonthViewController *monthVc = (LSCalendarMonthViewController *)self.currentViewController;
        
        
        [monthVc configLsMonth:self.selectLSMonth];
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
        
        
    }
    
    
    
//    [self reloadData];
    
    
    
    
    

    // Do any additional setup after loading the view.
}

- (LSHandler *)lsHandler {
    if (!_lsHandler) {
        _lsHandler  = [[LSHandler alloc] init];
        _lsHandler.delegate = self;
    }
    return _lsHandler;
}

- (void)selectHandlerTableViewSelectLocation:(LSLocation *)location {
    
    [self configSelectLocation:location ];
    
}

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.lsHandler.tableView.superview) {
        [self.lsHandler.tableView removeFromSuperview];
    }
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
    if (self.selectLocation) {
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        LSDate *lsdate = [[LSDate alloc] initWithYear:self.selectYear month:self.selectMonth day:2 timezone:self.selectLocation.TimeZone.Name];
        self.selectDate = lsdate.date;
        
        self.selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
        
        [self reloadSubControlller];
        
        
    }
    
}

- (void)reloadSubControlller {
    
    UIViewController *viewController = self.currentViewController;
    
    if ([viewController isKindOfClass:[LSCalendarMonthViewController class]]) {
        
        if (self.selectLSMonth) {
            LSCalendarMonthViewController *monthVc = (LSCalendarMonthViewController *)viewController;
            
            
            [monthVc configLsMonth:self.selectLSMonth];
        }
       
    }else if ([viewController isKindOfClass:[LSMonthSunViewController class]]) {
        if (self.selectLSMonth) {
            
            LSMonthSunViewController *monthsunVc = (LSMonthSunViewController *)viewController;
            
            [monthsunVc configMonth:self.selectLSMonth location:self.selectLocation];
        }
        
    } else if ([viewController isKindOfClass:[LSMonthMoonViewController class]]){
        if (self.selectMonth) {
            LSMonthMoonViewController *moonvc = (LSMonthMoonViewController*)viewController;
            [moonvc configMonth:self.selectLSMonth location:self.selectLocation];
        }
    } else if ([viewController isKindOfClass:[LSAstroMonthListViewController class]]){
        
        LSAstroMonthListViewController *astromonthVc = (LSAstroMonthListViewController *)viewController;
        [astromonthVc configLocation:self.selectLocation ];
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
    
    if (12 == self.selectMonth) {
        
        self.selectMonth = 1;
        self.selectYear = self.selectYear +1;
    } else {
        self.selectMonth = self.selectMonth+1;
    }
    if (self.selectLocation) {
        
        LSDate *lsdate = [[LSDate alloc] initWithYear:self.selectYear month:self.selectMonth day:2 timezone:self.selectLocation.TimeZone.Name];
        self.selectDate = lsdate.date;
        
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
        
        [self reloadSubControlller];
        
        
    }
    
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
    
    if (self.selectLocation) {
        
        self.selectDate = [NSDate date];
        LSDate *lsdate = [[LSDate alloc] initWithDate:self.selectDate timezoneName:self.selectLocation.TimeZone.Name];
       
        
        self.selectYear = lsdate.localYear;
        self.selectMonth = lsdate.localMonth;
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
        [self reloadSubControlller];
    }
    
}


- (void)configSelectLocation:(LSLocation *)location {
    
    self.selectLocation = location;
    
    
    if (self.selectDate) {
        LSDate *lsdate = [[LSDate alloc] initWithDate:self.selectDate timezoneName:self.selectLocation.TimeZone.Name];

        self.selectYear = lsdate.localYear;
        self.selectMonth = lsdate.localMonth;

        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld-%02d",self.selectYear,self.selectMonth] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSMonth = [[LSMonth alloc] initWithYear:self.selectYear month:self.selectMonth timezone:self.selectLocation.TimeZone.Name];
        [self reloadSubControlller];
        
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
    }
    
    
}



- (NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.typeArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
   
    NSString *string  = self.typeArray[index];
    return string;
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    if (0 == index){
        
        LSCalendarMonthViewController *monthVC   =[[LSCalendarMonthViewController alloc] init];
        
        return monthVC;
    }
    
   else if (1 == index) {
        
        LSMonthSunViewController *sunVc    =[[LSMonthSunViewController alloc] init];
        return sunVc;
        
    } else if (2 == index){
        
        LSMonthMoonViewController *moonVc  =[[LSMonthMoonViewController alloc] init];
        
        return moonVc;
        
    }  else {
        
        LSAstroMonthListViewController *monthVc  =[[LSAstroMonthListViewController alloc] init];
        
        return monthVc;
        
        
    }
}

- (CGFloat)menuView:(WMMenuView *)menu widthForItemAtIndex:(NSInteger)index {
    
    NSString *string  = self.typeArray[index];
    
    CGFloat width = string.length *14;
    return width +20;
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForMenuView:(WMMenuView *)menuView {
    //    if (self.menuViewPosition == WMMenuViewPositionBottom) {
    //        menuView.backgroundColor = [UIColor colorWithWhite:0.95 alpha:1.0];
    //        return CGRectMake(0, self.view.frame.size.height - 44, self.view.frame.size.width, 44);
    //    }
    CGFloat leftMargin = self.showOnNavigationBar ? 50 : 0;
    CGFloat originY = 48;
    return CGRectMake(leftMargin, originY, self.view.frame.size.width - 2*leftMargin, 40);
}

- (CGRect)pageController:(WMPageController *)pageController preferredFrameForContentView:(WMScrollView *)contentView {
    //    if (self.menuViewPosition == WMMenuViewPositionBottom) {
    //        return CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64 - 44);
    //    }
    CGFloat originY = CGRectGetMaxY([self pageController:pageController preferredFrameForMenuView:self.menuView]);
    //    if (self.menuViewStyle == WMMenuViewStyleTriangle) {
    //        originY += self.redView.frame.size.height;
    //    }
    return CGRectMake(0, originY, self.view.frame.size.width, self.view.frame.size.height - originY);
}

- (void)pageController:(WMPageController *)pageController didEnterViewController:(__kindof UIViewController *)viewController withInfo:(NSDictionary *)info {
    
    
    if ([viewController isKindOfClass:[LSCalendarMonthViewController class]]) {
        if (self.selectMonth) {
            LSCalendarMonthViewController *monthVc = (LSCalendarMonthViewController *)viewController;
            
            
            [monthVc configLsMonth:self.selectLSMonth];
        }
       
    }else if ([viewController isKindOfClass:[LSMonthSunViewController class]]) {
        if (self.selectLSMonth) {
            
            LSMonthSunViewController *monthsunVc = (LSMonthSunViewController *)viewController;
            
            [monthsunVc configMonth:self.selectLSMonth location:self.selectLocation];
        }
        
    } else if ([viewController isKindOfClass:[LSMonthMoonViewController class]]){
        if (self.selectMonth) {
            LSMonthMoonViewController *moonvc = (LSMonthMoonViewController*)viewController;
            [moonvc configMonth:self.selectLSMonth location:self.selectLocation];
        }
    } else if ([viewController isKindOfClass:[LSAstroMonthListViewController class]]){
        
        LSAstroMonthListViewController *astroMonth =(LSAstroMonthListViewController *)viewController;
        if (self.selectLocation) {
            [astroMonth configLocation:self.selectLocation];
        }
    }
    
    
    
}



- (UIUserInterfaceStyle)overrideUserInterfaceStyle {

    return UIUserInterfaceStyleLight;
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
