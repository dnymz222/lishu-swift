//
//  LSDayHolidayCell.m
//  lishu
//
//  Created by xueping on 2021/5/15.
//

#import "LSDayHolidayCell.h"
#import "ColorSizeMacro.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSDayHolidayCell ()

@property(nonatomic,strong)UILabel *regionLabel;

@property(nonatomic,strong)UILabel *localizedLabel;
//@property(nonatomic,strong)UILabel *englishLabel;

@property(nonatomic,strong)UILabel *configLabel;



@end

@implementation LSDayHolidayCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        [self.contentView addSubview:self.regionLabel];
        [self.contentView addSubview:self.localizedLabel];
        [self.contentView addSubview:self.configLabel];
//        [self.contentView addSubview:self.englishLabel];
        [self.regionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.width.mas_greaterThanOrEqualTo(@60);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@20);
        }];
        
        [self.localizedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.regionLabel.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
        
        [self.configLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.regionLabel.mas_right).offset(50);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@20);
            
        }];
        
//        [self.englishLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.contentView).offset(13);
//            make.right.equalTo(self.contentView).offset(-13);
//            make.top.equalTo(self.localizedLabel.mas_bottom).offset(5);
//            make.height.equalTo(@20);
//        }];
    }
    return self;
}

- (UILabel *)regionLabel {
    if (!_regionLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:16.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _regionLabel = label;
    }
    return _regionLabel;
}

- (UILabel *)localizedLabel {
    if (!_localizedLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _localizedLabel = label;
    }
    return _localizedLabel;
}

- (UILabel *)configLabel {
    if (!_configLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _configLabel = label;
    }
    return _configLabel;
}



//- (UILabel *)englishLabel {
//    if (!_englishLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont systemFontOfSize:15.f];
//        label.textColor  = UIColorFromRGB(TextDarkColor);
//        _englishLabel = label;
//    }
//    return _englishLabel;
//}

- (void)configWorkingDayFromDay:(LSWorkingdayModel *)workingday{
    
    
    self.regionLabel.text = [[NSBundle mainBundle] localizedStringForKey:workingday.code value:@"" table:@"lish"];
    self.configLabel.text = [NSString stringWithFormat:@"%@%@",workingday.configuration.length?@"":NSLocalizedString(@"default", nil),workingday.configuration.length?workingday.configuration:[[NSBundle mainBundle] localizedStringForKey:[NSString stringWithFormat:@"%@_default",workingday.code] value:@"" table:@"lish"]];
    self.localizedLabel.text = [[NSBundle mainBundle] localizedStringForKey:workingday.public_holiday_description value:@"" table:@"lish"];
    
}

- (void)configWorkingDayFromYear:(LSWorkingdayModel *)workingday {
    
    self.regionLabel.text =workingday.date;
    self.localizedLabel.text = [[NSBundle mainBundle] localizedStringForKey:workingday.public_holiday_description value:@"" table:@"lish"];
    
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
