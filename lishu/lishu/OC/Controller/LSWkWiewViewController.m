//
//  LSWkWiewViewController.m
//  lishu
//
//  Created by xueping on 2021/10/31.
//

#import "LSWkWiewViewController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import <WebKit/WebKit.h>

@interface LSWkWiewViewController ()

@property(nonatomic,strong)WKWebView *wkView;

@end

@implementation LSWkWiewViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    
    WKWebViewConfiguration *config = [[WKWebViewConfiguration alloc] init];
    config.selectionGranularity = WKSelectionGranularityDynamic;
    config.allowsInlineMediaPlayback = YES;
    WKPreferences *preferences = [WKPreferences new];
    //是否支持JavaScript
    preferences.javaScriptEnabled = NO;
    //不通过用户交互，是否可以打开窗口
    preferences.javaScriptCanOpenWindowsAutomatically = NO;
    config.preferences = preferences;

//    self.navigationItem.title = NSLocalizedString(@"privacy", nil);
    

    self.wkView = [[WKWebView alloc] initWithFrame:self.view.frame configuration:config];

    
    [self.view addSubview:self.wkView];

if (@available(iOS 13.0, *)) {
    self.wkView.backgroundColor =[UIColor systemBackgroundColor];
} else {
    // Fallback on earlier versions
    self.wkView.backgroundColor = [UIColor groupTableViewBackgroundColor];
}
    



    CGFloat bootomspace = KIsiPhoneX ?34 :0;
    
    [self.wkView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-bootomspace);
        
    }];
    
    UIView *leftView = [[UIView alloc] init];
    leftView.backgroundColor = [UIColor clearColor];
    [self.view addSubview:leftView];
    [leftView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self.view);
        make.width.equalTo(@5);
    }];

//    self.urlString   =@"https://wwww.baidu.com";
    
    if (self.urlString) {
        NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:self.urlString]];
        [self.wkView loadRequest:request];
    }

if (self.navtitle) {
    self.navigationItem.title = self.navtitle;
}
    // Do any additional setup after loading the view.
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
