//
//  LSYearViewController.m
//  lishu
//
//  Created by xueping on 2021/3/28.
//

#import "LSYearViewController.h"
#import "ColorSizeMacro.h"
#import "LSLocation.h"
#import <Masonry/Masonry.h>
#import "LSHandler.h"
#import "LSYearHolidayViewController.h"
#import "LSYearSunViewController.h"
#import "LSYearMoonViewController.h"
#import "LSYearEclipseViewController.h"
#import "LSYear.h"
#import "LSDate.h"
#import "LSYearEraViewController.h"


@interface LSYearViewController ()<LSHandlerDelegate>

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

@property(nonatomic,strong)LSYear *selectLSYear;

@property(nonatomic,strong)NSDate *selectDate;

@end

@implementation LSYearViewController


- (instancetype)init {
    self = [super init];
    if (self) {
        self.typeArray  = @[NSLocalizedString(@"holidays", nil),NSLocalizedString(@"sun", nil),NSLocalizedString(@"moon", nil),NSLocalizedString(@"eclipse", nil),NSLocalizedString(@"era", nil)];
        self.menuViewStyle = WMMenuViewStyleLine;
        self.menuView.lineColor = UIColorFromRGB(TextDarkColor);
        self.menuView.scrollView.backgroundColor = UIColorFromRGB(Themecolor);
        
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
        make.left.equalTo(self.dateButton.mas_right).offset(2);
        make.top.equalTo(self.view).offset(5);
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
    
//    NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:@"2021" attributes:self.dateAttrsDict];
//    [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
    
    
    
    NSDate *date = [NSDate date];
    
    self.selectDate = date;
    
    if (self.lsHandler.selectLocation) {
        self.selectLocation = self.lsHandler.selectLocation;
        LSDate *lsdate = [[LSDate alloc] initWithDate:date timezoneName:self.selectLocation.TimeZone.Name];
        
        self.selectYear = lsdate.localYear;
 
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",self.selectYear] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSYear = [[LSYear alloc] initWithyear:self.selectYear timezone:self.selectLocation.TimeZone.Name];;
        
        LSYearHolidayViewController *holidayVC  = (LSYearHolidayViewController *)self.currentViewController;
       
            [holidayVC configYear:self.selectYear location:self.selectLocation];
   
        
        
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
       
        
        
        
    }
    
    
    

    // Do any additional setup after loading the view.
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

-  (void)selectHandlerTableViewSelectLocation:(LSLocation *)location {
    
    [self configLocation:location];
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
    
    if (self.selectLocation) {
        
        self.selectYear = self.selectYear -1;
        
        
        LSDate *lsdate = [[LSDate alloc] initWithYear:self.selectYear month:1 day:2 timezone:self.selectLocation.TimeZone.Name];
        self.selectDate = lsdate.date;
        
        
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",self.selectYear] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSYear = [[LSYear alloc] initWithyear:self.selectYear timezone:self.selectLocation.TimeZone.Name];
        [self configYear];
        
        
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
    if (self.selectLocation) {
        
        self.selectYear = self.selectYear +1;
        
        LSDate *lsdate = [[LSDate alloc] initWithYear:self.selectYear month:1 day:2 timezone:self.selectLocation.TimeZone.Name];
        self.selectDate = lsdate.date;
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",self.selectYear] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSYear = [[LSYear alloc] initWithyear:self.selectYear timezone:self.selectLocation.TimeZone.Name];
        [self configYear];
        
        
    }

}


- (void)configLocation:(LSLocation *)location {
    self.selectLocation =  location;
    if (self.selectDate ) {
        
        LSDate *lsdate = [[LSDate alloc] initWithDate:self.selectDate timezoneName:self.selectLocation.TimeZone.Name];
        
        self.selectYear = lsdate.localYear;
 
        
        self.selectLSYear = [[LSYear alloc] initWithyear:self.selectYear timezone:self.selectLocation.TimeZone.Name];
        self.navigationItem.title = [NSString stringWithFormat:@"%@(%@)",self.selectLocation.LocalizedName,self.selectLocation.TimeZone.Name];
        [self configYear];
    }
}

- (void)configYear {
    
    
    UIViewController *viewController = self.currentViewController;
    
    if ([viewController isKindOfClass:[LSYearHolidayViewController class]]) {
        
        LSYearHolidayViewController *holidayVC  = (LSYearHolidayViewController *)viewController;
        if (self.selectLSYear) {
            [holidayVC configYear:self.selectYear location:self.selectLocation];
        }
        
        
    }else if ([viewController isKindOfClass:[LSYearMoonViewController class]]) {
        LSYearMoonViewController   *moonVc = (LSYearMoonViewController*)viewController;
        
        if (self.selectLSYear) {
            [moonVc configYear:self.selectLSYear];
        }
        
    } else if ([viewController isKindOfClass:[LSYearSunViewController class]]){
        
        if (self.selectLSYear) {
            LSYearSunViewController *yearSunVC =  (LSYearSunViewController*)self.currentViewController;
            [yearSunVC configYear:self.selectYear location:self.selectLocation];
        }
        
    } else if ([viewController isKindOfClass:[LSYearEclipseViewController class]]){
        LSYearEclipseViewController *eclipseVC  =(LSYearEclipseViewController*)self.currentViewController;
        if (self.selectLSYear) {
            [eclipseVC configYear:self.selectYear location:self.selectLocation];
        }
        
        
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
    
    
    NSDate *date = [NSDate date];
    
    self.selectDate = date;
    
    if (self.selectLocation) {

        LSDate *lsdate = [[LSDate alloc] initWithDate:date timezoneName:self.selectLocation.TimeZone.Name];
        
        self.selectYear = lsdate.localYear;
 
        
        NSAttributedString *attrs  = [[NSAttributedString alloc] initWithString:[NSString stringWithFormat:@"%ld",self.selectYear] attributes:self.dateAttrsDict];
        [self.dateButton setAttributedTitle:attrs forState:UIControlStateNormal];
        
        self.selectLSYear = [[LSYear alloc] initWithyear:self.selectYear timezone:self.selectLocation.TimeZone.Name];;
        
        [self configYear];
   
        
        
    }
    
    
    
}



-(NSInteger)numbersOfChildControllersInPageController:(WMPageController *)pageController {
    return self.typeArray.count;
}

- (NSString *)pageController:(WMPageController *)pageController titleAtIndex:(NSInteger)index {
   
    NSString *string  = self.typeArray[index];
    return string;
}


- (UIViewController *)pageController:(WMPageController *)pageController viewControllerAtIndex:(NSInteger)index {
    
    if (0 == index){
        
        LSYearHolidayViewController *monthVC   =[[LSYearHolidayViewController alloc] init];
        
        return monthVC;
    }
    
   else if (1 == index) {
        
        LSYearSunViewController *sunVc    =[[LSYearSunViewController alloc] init];
        return sunVc;
        
    } else if (2 == index){
        
        LSYearMoonViewController *moonVc  =[[LSYearMoonViewController alloc] init];
        
        return moonVc;
        
    }  else if (3 == index){
        
        LSYearEclipseViewController *monthVc  =[[LSYearEclipseViewController alloc] init];
        
        return monthVc;
        
    } else {
        
        LSYearEraViewController * eravc = [[LSYearEraViewController alloc] init];
        return  eravc;
        
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
    
   
    if ([viewController isKindOfClass:[LSYearMoonViewController class]]) {
        LSYearMoonViewController   *moonVc = (LSYearMoonViewController*)viewController;
        
        if (self.selectLSYear) {
            [moonVc configYear:self.selectLSYear];
        }
        
    } else if ([viewController isKindOfClass:[LSYearSunViewController class]]){
        
        if (self.selectYear) {
            LSYearSunViewController *yearSunVC =  (LSYearSunViewController*)viewController;
            [yearSunVC configYear:self.selectYear location:self.selectLocation];
        }
        
    }else if ([viewController isKindOfClass:[LSYearEclipseViewController class]]){
        LSYearEclipseViewController *eclipseVC  =(LSYearEclipseViewController *)viewController;
        
        [eclipseVC configYear:self.selectYear location:self.selectLocation];
        
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
