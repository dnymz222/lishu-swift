//
//  LSHourWeatherItemView.m
//  lishu
//
//  Created by xueping on 2021/4/2.
//

#import "LSHourWeatherItemView.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSUinitTool.h"


@interface LSHourWeatherItemView ()


@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *temperatureLabel;

@end

@implementation LSHourWeatherItemView

- (instancetype)initWithFrame:(CGRect)frame {
    self   =[super initWithFrame:frame];
    if (self) {
        
        [self addSubview:self.iconView];
        [self addSubview:self.timeLabel];
        [self addSubview:self.temperatureLabel];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.equalTo(self);
            make.top.equalTo(self).offset(5);
            make.height.equalTo(@20);
        }];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.timeLabel.mas_bottom).offset(5);
            make.width.equalTo(@40);
            make.height.equalTo(@25);
            make.centerX.equalTo(self);
        }];
        
        [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(5);
            make.left.right.equalTo(self);
            make.height.equalTo(@20);
        }];
        
        
        
    }
    return self;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode =  UIViewContentModeScaleAspectFit;
        _iconView =  imageview;
    }
    return _iconView;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont boldSystemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeLabel= label;
    }
    return _timeLabel;
}


- (UILabel *)temperatureLabel {
    if (!_temperatureLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _temperatureLabel = label;
    }
    return _temperatureLabel;
}


- (void)configModel:(LSAccuWeatherHourModel *)model isMertric:(BOOL)ismertric {
    
    NSArray *times = [model.DateTime componentsSeparatedByString:@"T"];
    NSString *hour = [times[1] substringToIndex:5];
    self.timeLabel.text =  hour;
//    self.temperatureLabel.text =  [model.Temperature valueForKey:@"Value"];
    NSString *imagestring  = [NSString stringWithFormat:@"%02d-s",model.WeatherIcon];
    UIImage *image =  [UIImage imageNamed:imagestring];
    [self.iconView setImage:image];
    
    double f =[[model.Temperature valueForKey:@"Value"] doubleValue];
    
    
    self.temperatureLabel.text = [LSUinitTool temperatureFormFahrenheit:f isMertic:ismertric];
    
    
    
}





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
