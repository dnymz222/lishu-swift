//
//  LSTimeZoneMapTipController.m
//  lishu
//
//  Created by xueping on 2021/10/13.
//

#import "LSTimeZoneMapTipController.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSTimeZoneMapTipController ()

@property(nonatomic,strong)UILabel *label1;
@property(nonatomic,strong)UILabel *label2;

@end

@implementation LSTimeZoneMapTipController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = UIColorFromRGB(ViewBackGroundColor);
    
    UIView *view1 = [[UIView alloc] init];
    
    view1.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.2];
    
    [self.view addSubview:view1];
    [self.view addSubview:self.label1];
    
    [view1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(self.view).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [self.label1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view1.mas_right).offset(10);
        make.centerY.equalTo(view1);
        make.height.equalTo(@20);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    UIView *view2 = [[UIView alloc] init];
    
    view2.backgroundColor = [UIColor colorWithRed:0.6 green:0.6 blue:0.6 alpha:0.5];
    
    [self.view addSubview:view2];
    [self.view addSubview:self.label2];
    
    [view2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).offset(10);
        make.top.equalTo(view1.mas_bottom).offset(10);
        make.height.equalTo(@20);
        make.width.equalTo(@60);
    }];
    
    [self.label2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(view2.mas_right).offset(10);
        make.centerY.equalTo(view2);
        make.height.equalTo(@20);
        make.right.equalTo(self.view).offset(-10);
    }];
    
    
    
    
    // Do any additional setup after loading the view.
}

- (UILabel *)label1 {
    if (!_label1) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.text  = NSLocalizedString(@"sunrise_sunset", nil);
        _label1 = label;
    }
    return _label1;
}


- (UILabel *)label2 {
    if (!_label2) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.text  = NSLocalizedString(@"civil_dawn_dusk", nil);
        _label2 = label;
    }
    return _label2;
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
