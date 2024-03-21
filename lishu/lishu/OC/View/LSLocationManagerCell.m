//
//  LSLocationManagerCell.m
//  lishu
//
//  Created by xueping on 2021/5/29.
//

#import "LSLocationManagerCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"



@interface LSLocationManagerCell ()

@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *timeZoneLabel;
//@property(nonatomic,strong)UILabel *countryOrRegionLabel;
@property(nonatomic,strong)UILabel *geoLabel;

@property(nonatomic,strong)UILabel *currentLabel;

@end

@implementation LSLocationManagerCell



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self   =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.timeZoneLabel];
//        [self.contentView addSubview:self.countryOrRegionLabel];
        [self.contentView addSubview:self.geoLabel];
        [self.contentView addSubview:self.currentLabel];
        
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-120);
            make.top.equalTo(self.contentView).offset(8);
            make.height.equalTo(@18);
        }];
        [self.timeZoneLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(4);
            make.height.equalTo(@18);
        }];
//        [self.countryOrRegionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(13);
//            make.right.equalTo(self.contentView).offset(-13);
//            make.top.equalTo(self.timeZoneLabel.mas_bottom).offset(4);
//            make.height.equalTo(@18);
//        }];
        [self.geoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.timeZoneLabel.mas_bottom).offset(4);
            make.height.equalTo(@18);
        }];
        
        
        [self.currentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
           
            make.right.equalTo(self.contentView).offset(-13);
            make.width.mas_greaterThanOrEqualTo(@60);
            make.top.equalTo(self.contentView).offset(8);
            make.height.equalTo(@18);
        }];
        
        
        
        
        
    }
    return self;
}

- (UILabel *)timeZoneLabel {
    if (!_timeZoneLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeZoneLabel = label;
    }
    return _timeZoneLabel;
}


- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _titleLabel = label;
    }
    return _titleLabel;
}


//- (UILabel *)countryOrRegionLabel {
//    if (!_countryOrRegionLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont systemFontOfSize:15.f];
//        label.textColor  = UIColorFromRGB(TextDarkColor);
//        _countryOrRegionLabel = label;
//    }
//    return _countryOrRegionLabel;
//}
- (UILabel *)geoLabel {
    if (!_geoLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _geoLabel = label;
    }
    return _geoLabel;
}

- (UILabel *)currentLabel {
    if (!_currentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _currentLabel= label;
    }
    return _currentLabel;
}






- (void)configWithLocation:(LSLocation *)location  {
    
    self.titleLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"name", nil),location.LocalizedName];
    
    self.timeZoneLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"timezone", nil),location.TimeZone.Name];
//    self.countryOrRegionLabel.text = [NSString stringWithFormat:@"国家或地区：%@",location.CountryOrDistrict.LocalizedName];
    self.geoLabel.text =[NSString stringWithFormat:@"%@:%0.3f，%@:%0.3f",NSLocalizedString(@"longitude", nil),location.GeoPosition.Longitude,NSLocalizedString(@"latitude", nil),location.GeoPosition.Latitude];
    
    if (location.isCurrent) {
        self.currentLabel.text = NSLocalizedString(@"current_location", nil);
    } else {
        self.currentLabel.text  =@"";
    }
}





- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
