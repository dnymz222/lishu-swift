//
//  LSWorldClockCell.m
//  lishu
//
//  Created by xueping on 2021/3/2.
//

#import "LSWorldClockCell.h"
#import "LSClockView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSSoulnarView.h"


@interface LSWorldClockCell ()


@property(nonatomic,strong)LSClockView *clockView;

@property(nonatomic,strong)UILabel *nameLabel;
@property(nonatomic,strong)UILabel *timezoneLabel;
@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *dateLabel;

@property(nonatomic,strong)UIImageView *weatherIconView;
@property(nonatomic,strong)UILabel *temperatureLabel;

@property(nonatomic,strong)LSSoulnarView *solunarView;

@end

@implementation LSWorldClockCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor   = UIColorFromRGB(0xe6e6c5);
        
        self.backgroundColor   = UIColorFromRGB(0xe6e6c5);
        
        [self.contentView addSubview:self.clockView ];
        [self.clockView  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(5);
            make.top.equalTo(self.contentView).offset(4);
            make.width.equalTo(@80);
            make.height.equalTo(@80);
        }];
        
        [self.contentView addSubview:self.nameLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.clockView.mas_right).offset(5);
            make.top.equalTo(self.contentView).offset(2);
            make.height.equalTo(@20);
            make.width.greaterThanOrEqualTo(@50);
        }];
        
        [self.contentView addSubview:self.timezoneLabel];
        [self.timezoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerY.equalTo(self.nameLabel);
            make.left.equalTo(self.nameLabel.mas_right).offset(5);
            make.width.greaterThanOrEqualTo(@50);
            make.height.equalTo(@20);
        }];
        
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom ).offset(10);
            make.left.equalTo(self.clockView.mas_right).offset(5);
            make.width.greaterThanOrEqualTo(@80);
            make.height.equalTo(@20);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.bottom.equalTo(self.clockView ).offset(-5);
            make.left.equalTo(self.clockView.mas_right).offset(5);
            make.width.greaterThanOrEqualTo(@110);
            make.height.equalTo(@20);
        }];
        
        
        [self.contentView addSubview:self.weatherIconView];
        [self.contentView addSubview:self.temperatureLabel];
        [self.contentView addSubview:self.solunarView];
        [self.weatherIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom ).offset(7);
            make.width.equalTo(@40);
            make.height.equalTo(@25);
            make.left.equalTo(self.timeLabel.mas_right).offset(20);
        }];
        
        [self.temperatureLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.timeLabel.mas_right).offset(10);
            make.width.equalTo(@60);
            make.height.equalTo(@20);
            make.top.equalTo(self.weatherIconView.mas_bottom).offset(3);
           
        }];
        
        [self.solunarView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.nameLabel.mas_bottom );
            make.width.equalTo(@66);
            make.height.equalTo(@66);
            make.left.equalTo(self.weatherIconView.mas_right).offset(10);
        }];
        
    }
    return self;
}


- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _nameLabel = label;
    }
    return _nameLabel;
}


- (LSClockView *)clockView {
    if (!_clockView) {
        _clockView  = [[LSClockView alloc] init];
        
    }
    return _clockView;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:13.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _dateLabel = label;
    }
    return _dateLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:13.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)timezoneLabel {
    if (!_timezoneLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:13.f];
        label.textColor  = UIColorFromRGB(TextblackColor);
        _timezoneLabel = label;
    }
    return _timezoneLabel;
}

- (UIImageView *)weatherIconView {
    if (!_weatherIconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
       
        _weatherIconView =  imageview;
    }
    return _weatherIconView;
}

- (UILabel *)temperatureLabel {
    if (!_temperatureLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _temperatureLabel = label;
    }
    return _temperatureLabel;
}

- (LSSoulnarView *)solunarView {
    if (!_solunarView) {
        _solunarView  = [[LSSoulnarView alloc] init];
    }
    return _solunarView;
}





-(void)configLocation:(LSLocation *)location isMetric:(BOOL)ismertric{
    
    NSString *fuhao = location.lsDate.offset >0?@"+":@"-";
    int offset =  abs((int)location.lsDate.offset);
    self.nameLabel.text  =location.LocalizedName;
    
    
    self.timezoneLabel.text  = [NSString stringWithFormat:@"%@(%@%02d%02d)", location.TimeZone.Name,fuhao,offset/3600,(offset%3600)/60];
    
    [self.clockView configHour:location.lsDate.localHour minutes:location.lsDate.localMinute seconds:location.lsDate.second];
    
    NSString *weekstring = [NSString stringWithFormat:@"week_%ld_f",location.lsDate.localDayInWeek-1];
    NSString *week = [[NSBundle mainBundle] localizedStringForKey:weekstring value:@"" table:@"lish"];
    self.dateLabel.text  =[NSString stringWithFormat:@"%02d-%02d %@",location.lsDate.localMonth,location.lsDate.localDay,week];
    self.timeLabel.text  =[NSString stringWithFormat:@"%02d:%02d  %@ %02d:%02d",location.lsDate.localHour,location.lsDate.localMinute,location.lsDate.localHour >11?NSLocalizedString(@"afternoon", nil):NSLocalizedString(@"morning", nil),location.lsDate.localHour>12?location.lsDate.localHour-12:location.lsDate.localHour,location.lsDate.localMinute];
    
    
    
    if (location.currentModel) {
        NSString *icon   =[NSString stringWithFormat:@"%02d-s",location.currentModel.WeatherIcon];
        [self.weatherIconView setImage:[UIImage imageNamed:icon]];
        if (ismertric) {
            
            NSDictionary *mertric =  [location.currentModel.Temperature valueForKey:@"Metric"];
            self.temperatureLabel.text   =[NSString stringWithFormat:@"%0.1f°C",[[mertric valueForKey:@"Value"] floatValue]];
            
        } else {
            NSDictionary *Imperial =  [location.currentModel.Temperature valueForKey:@"Imperial"];
            self.temperatureLabel.text   =[NSString stringWithFormat:@"%0.1f°F",[[Imperial valueForKey:@"Value"] floatValue]];
        }
        
        
    }
    
    if (location.moonPosition) {
        [self.solunarView  configSolunarWithSunPosition:location.sunPostion moonPosition:location.moonPosition];
        self.contentView.backgroundColor   = location.sunPostion.Height<0 ? UIColorFromRGB(0xb3b392):UIColorFromRGB(0xe6e6c5);
//
        self.backgroundColor   = location.sunPostion.Height<0 ? UIColorFromRGB(0xb3b392):UIColorFromRGB(0xe6e6c5);
    } else {
        
        self.contentView.backgroundColor = UIColorFromRGB(0xe6e6c5);
        self.backgroundColor =UIColorFromRGB(0xe6e6c5);
        
    }
    
   
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}



@end
