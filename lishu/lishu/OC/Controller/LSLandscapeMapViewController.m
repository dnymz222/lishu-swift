//
//  LSLandscapeMapViewController.m
//  lishu
//
//  Created by xueping on 2021/3/14.
//

#import "LSLandscapeMapViewController.h"
#import "LSDate.h"
#import "LSTimeZoneMapView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSTimeZoneMapTipController.h"
#import "LSNightDayTool.h"


@interface LSLandscapeMapViewController ()<UIScrollViewDelegate>


@property(nonatomic,strong)LSTimeZoneMapView  *mapView;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UIButton *rightButton;



@end

@implementation LSLandscapeMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor  = UIColorFromRGB(ViewBackGroundColor);
    
    self.navigationItem.title   =[NSString stringWithFormat:@"%@",self.date];
    
    self.navigationItem.rightBarButtonItem  = [[UIBarButtonItem alloc] initWithCustomView:self.rightButton];
    
 
    
    CGFloat statusBarHeight = 0.f;
 
        statusBarHeight = [[UIApplication sharedApplication] statusBarFrame].size.height;

    
    CGFloat navheight   = statusBarHeight + 44;
    
    
    
    
    CGFloat height  = [UIScreen mainScreen].bounds.size.height;
    CGFloat width  =  [UIScreen mainScreen].bounds.size.width;
    
    [self.view addSubview:self.scrollView];
    self.scrollView.frame   =CGRectMake(0, 0, width, height-navheight);
    

    
    
    CGFloat scale   = 1104/(height-navheight);
    [self.scrollView addSubview:self.mapView];
    CGFloat mapwidth   = 2160/scale;
    self.mapView.frame =  CGRectMake(0, 0, mapwidth, height-navheight);
    self.scrollView.contentSize = CGSizeMake(mapwidth, height-navheight);
//    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.bottom.equalTo(self.view);
//        make.centerX.equalTo(self.view);
//        make.width.equalTo(@(2004/scale));
//    }];
    
//    LSDate *lsdate  = [[LSDate alloc] initWithDate:self.date];
//    [lsdate calculateLocation];
//    [lsdate calculateTwlightLocation];
//    [self.mapView configLocationArray:lsdate.locationArray scale:scale fix:lsdate.fix];
//    [self.mapView configTwilightLocationArray:lsdate.twlightLocationArray scale:scale fix:lsdate.fix];
    // Do any additional setup after loading the view.
    
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        LSNightDayTool *daynightTool = [[LSNightDayTool alloc] initWihDate:self.date];
        
        
        
        UIImage *  dayNightImage = [daynightTool generateImage:2];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.mapView.overlayView setImage: dayNightImage];
        });
    });
}

-(LSTimeZoneMapView *)mapView {
    if (!_mapView) {
        _mapView  = [[LSTimeZoneMapView alloc] init];
    }
    return _mapView;
}

- (UIScrollView *)scrollView {
    if (!_scrollView) {
        _scrollView  =  [[UIScrollView alloc] init];
        _scrollView.delegate  =self;
    }
    return _scrollView;
}

-(UIButton *)rightButton {
    if (!_rightButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"tishi"];
        [button setImage:image forState:UIControlStateNormal];
        [button addTarget:self action:@selector(rightButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _rightButton  = button;
    }
    return _rightButton    ;
}

-(void)rightButtonClick:(UIButton *)button {
    
    LSTimeZoneMapTipController *tipvc = [[LSTimeZoneMapTipController alloc] init];
    [self.navigationController  pushViewController:tipvc animated:YES];
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
