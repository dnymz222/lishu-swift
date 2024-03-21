//
//  LSDayWeatherCell.m
//  lishu
//
//  Created by xueping on 2021/4/2.
//

#import "LSDayWeatherCell.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>
#import "LSUinitTool.h"

@interface LSDayWeatherCell ()

@property(nonatomic,strong)UILabel *dateLabel;
@property(nonatomic,strong)UIImageView *sunIconView;
@property(nonatomic,strong)UILabel *sunLabel;
@property(nonatomic,strong)UILabel *moonLabel;
@property(nonatomic,strong)UIImageView *moonIconView;
@property(nonatomic,strong)UIButton *dayIconView;
@property(nonatomic,strong)UIButton *nightIconView;
@property(nonatomic,strong)UILabel *spacelable;
@property(nonatomic,strong)UILabel *temperaturelabel;

@end

@implementation LSDayWeatherCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    self   =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.dateLabel];
        [self.contentView addSubview:self.sunIconView];
        [self.contentView addSubview:self.sunLabel];
        [self.contentView addSubview:self.moonIconView];
        [self.contentView addSubview:self.moonLabel];
        [self.contentView addSubview:self.dayIconView];
        [self.contentView addSubview:self.spacelable];
        [self.contentView addSubview:self.nightIconView];
        [self.contentView addSubview:self.temperaturelabel];
        
        [self.dateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.equalTo(self.contentView);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@20);
        }];
        
        [self.sunIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.dateLabel.mas_bottom).offset(5);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        [self.moonIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.sunIconView.mas_bottom).offset(5);
            make.width.equalTo(@20);
            make.height.equalTo(@20);
        }];
        
        [self.sunLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.sunIconView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.sunIconView);
            make.height.equalTo(@20);
        }];
        
        [self.moonLabel   mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.moonIconView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.moonIconView);
            make.height.equalTo(@20);
        }];
        [self.dayIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.equalTo(self.moonIconView.mas_bottom).offset(5);
            make.width.equalTo(@42);
            make.height.equalTo(@27);
        }];
        
        
        [self.spacelable  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.dayIconView.mas_right).offset(2);
            make.width.equalTo(@20);
            make.centerY.equalTo(self.dayIconView);
            make.height.equalTo(@20);
        }];
        
        [self.nightIconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.spacelable.mas_right).offset(2);
            make.top.equalTo(self.moonIconView.mas_bottom).offset(5);
            make.width.equalTo(@42);
            make.height.equalTo(@27);
        }];
        
        [self.temperaturelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            
            make.left.equalTo(self.nightIconView.mas_right).offset(15);
            make.centerY.equalTo(self.nightIconView);
            make.right.equalTo(self.contentView).offset(-10);
            make.height.equalTo(@20);
        }];
        
     
       
        
    }
    return self;
}

- (UILabel *)dateLabel {
    if (!_dateLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:17.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _dateLabel = label;
    }
    return _dateLabel;
}


- (UIImageView *)sunIconView {
    if (!_sunIconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"sun"];
        [imageview setImage:image];
        _sunIconView =  imageview;
    }
    return _sunIconView;
}



- (UILabel *)sunLabel    {
    if (!_sunLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _sunLabel    = label;
    }
    return _sunLabel;
}



- (UIImageView *)moonIconView {
    if (!_moonIconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        
        _moonIconView =  imageview;
    }
    return _moonIconView;
}

- (UILabel *)moonLabel {
    if (!_moonLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _moonLabel = label;
    }
    return _moonLabel;
}

-(UIButton *)dayIconView {
    if (!_dayIconView) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        button.backgroundColor  =UIColorFromRGB(0xeeeecc);
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds =  YES;
//        NSDictionary *attrsDict = @{NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor),
//                                    NSFontAttributeName:[UIFont systemFontOfSize:14.f]
//        };
//        NSAttributedString *attrs = [[NSAttributedString alloc] initWithString:@"day" attributes:attrsDict];
//        [button setAttributedTitle:attrs forState:UIControlStateNormal];

        _dayIconView  = button;
    }
    return _dayIconView;
}





-(UIButton *)nightIconView {
    if (!_nightIconView) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        button.backgroundColor = UIColorFromRGB(0xa3a382);
        button.layer.cornerRadius = 2.f;
        button.layer.masksToBounds =  YES;
//        NSDictionary *attrsDict = @{NSForegroundColorAttributeName:UIColorFromRGB(TextDarkColor),
//                                    NSFontAttributeName:[UIFont systemFontOfSize:14.f]
//        };
//        NSAttributedString *attrs = [[NSAttributedString alloc] initWithString:@"night" attributes:attrsDict];
//        [button setAttributedTitle:attrs forState:UIControlStateNormal];

        _nightIconView  = button;
    }
    return _nightIconView;
}

- (UILabel *)temperaturelabel {
    if (!_temperaturelabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _temperaturelabel = label;
    }
    return _temperaturelabel;
}

- (UILabel *)spacelable {
    if (!_spacelable) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.text  =@"/";
        _spacelable = label;
    }
    return _spacelable;
}



- (void)configModel:(LSAccuDayWeatherModel *)daymodel  is_mertric:(BOOL)is_mertric{
    
    int age = [[daymodel.Moon valueForKey:@"Age"] intValue];
    
    NSString *imgaestring =  [NSString stringWithFormat:@"moon_%02d",age];
    [self.moonIconView setImage:[UIImage imageNamed:imgaestring]];
    self.dateLabel.text =[ daymodel.Date substringToIndex:10];
    
    [self configRisesetLabel:self.sunLabel dict:daymodel.Sun];
    [self configRisesetLabel:self.moonLabel dict:daymodel.Moon];
    
    NSString *dayimagestring = [NSString stringWithFormat:@"%02d-s",daymodel.Day.Icon];
    [self.dayIconView setImage:[UIImage imageNamed:dayimagestring] forState:UIControlStateNormal];
    
    NSString *nightimagestring =  [NSString stringWithFormat:@"%02d-s",daymodel.Night.Icon];
    [self.nightIconView setImage:[UIImage imageNamed:nightimagestring] forState:UIControlStateNormal];
    
    
    double maxF = [[daymodel.Temperature[@"Maximum"] valueForKey:@"Value"] doubleValue];
    double minF = [[daymodel.Temperature[@"Minimum"] valueForKey:@"Value"] doubleValue];
    
    
    self.temperaturelabel.text = [NSString stringWithFormat:@"%@-%@",[LSUinitTool temperatureFormFahrenheit:minF isMertic:is_mertric],[LSUinitTool temperatureFormFahrenheit:maxF isMertic:is_mertric]];
    
    
    
    
    
}


- (void)configRisesetLabel:(UILabel *)label dict:(NSDictionary *)dict {
    
    NSString *rise = [dict valueForKey:@"Rise"];
    NSString *riseString;
    if ([rise isKindOfClass:[NSString class]]  && rise.length > 10) {
     NSArray*  risearray  = [rise componentsSeparatedByString:@"T"];
        riseString= [risearray[1] substringToIndex:5];
    } else {
        riseString = @"";
    }
   
    
    NSString *set = [dict valueForKey:@"Set"];
    NSString *setString ;
    if ([set isKindOfClass:[NSString class]]  && set.length > 10) {
      NSArray* setarray   = [set componentsSeparatedByString:@"T"];
        setString= [setarray[1] substringToIndex:5];
        
    } else {
        setString = @"";
    }

    label.text = [NSString stringWithFormat:@"↑:%@  ↓:%@",riseString,setString];
    
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
