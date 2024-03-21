//
//  LSDayCalendarCell.m
//  lishu
//
//  Created by xueping on 2021/5/14.
//

#import "LSDayCalendarCell.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSDayCalendarCell ()

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *eraLabel;

@property(nonatomic,strong)UILabel *yearLabel;
@property(nonatomic,strong)UILabel *monthLabel;
@property(nonatomic,strong)UILabel *dayLabel;




@property(nonatomic,strong)UILabel *contentLabel;

@property(nonatomic,strong)UILabel *extraLabel;




@end

@implementation LSDayCalendarCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.contentLabel];
        
        [self.contentView addSubview:self.eraLabel];
        [self.contentView addSubview:self.yearLabel];
        [self.contentView addSubview:self.monthLabel];
        [self.contentView addSubview:self.dayLabel];
        
        
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        
        
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(5);
            make.width.mas_greaterThanOrEqualTo(@60);
            make.height.equalTo(@20);
        }];
        
        [self.eraLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(5);
            make.width.mas_greaterThanOrEqualTo(@80);
            make.height.equalTo(@20);
        }];
        
        
        
       
        
        [self.yearLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.width.equalTo(@(width/3-30));
            make.height.equalTo(@20);
        
        }];
        
        
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
            make.width.equalTo(@(width/3-40));
            make.height.equalTo(@20);
        
        }];
        
        [self.monthLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.yearLabel.mas_right);
            make.right.equalTo(self.dayLabel.mas_left);
            make.top.equalTo(self.nameLabel.mas_bottom).offset(5);
   
            make.height.equalTo(@20);
        
        }];
        
        
        
        
        
        
        [self.contentLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.monthLabel.mas_bottom).offset(5);
            make.height.mas_greaterThanOrEqualTo(@0);
            make.bottom.equalTo(self.contentView).offset(-5);
        }];
        
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont  boldSystemFontOfSize:16.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _nameLabel = label;
    }
    return _nameLabel;
}


- (UILabel *)eraLabel {
    if (!_eraLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _eraLabel = label;
    }
    return _eraLabel;
}


- (UILabel *)yearLabel {
    if (!_yearLabel ) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _yearLabel   = label;
    }
    return _yearLabel   ;
}


- (UILabel *)monthLabel {
    if (!_monthLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.adjustsFontSizeToFitWidth = YES;
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _monthLabel = label;
    }
    return _monthLabel;
}


- (UILabel *)dayLabel {
    if (!_dayLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _dayLabel = label;
    }
    return _dayLabel;
}




- (UILabel *)contentLabel {
    if (!_contentLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.numberOfLines = 0;
        _contentLabel= label;
    }
    return _contentLabel;
}

- (void)configCalnedar:(LSCalendarTypeModel *)calendar {
    
    self.nameLabel.text   =calendar.name;
    
    self.eraLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"era", nil),calendar.eraString];
    
    self.yearLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"year", nil),calendar.yearString];
    self.monthLabel.text = [NSString stringWithFormat:@"%@:%@%@",NSLocalizedString(@"month", nil),calendar.monthString,calendar.localizedMonthString?[NSString stringWithFormat:@"(%@)",calendar.localizedMonthString]:@""];
    self.dayLabel.text = [NSString stringWithFormat:@"%@:%@",NSLocalizedString(@"day", nil),calendar.dayString];
    
    NSString *content = @"";
    if (calendar.isFestival) {
        content = [content stringByAppendingString:calendar.festivalString];
        if (calendar.type == LSCalendarTypeZangli) {
            if (calendar.zangli && calendar.zangli.extraInfo2.length > 0) {
                content = [content stringByAppendingString:[NSString stringWithFormat:@"\n%@",calendar.zangli.extraInfo2]];
            }
        }
    }
    
    self.contentLabel.text = content;
    
//    self.contentLabel.text = [NSString stringWithFormat:@"%d %@ %@%@ %@",calendar.calendarEra,calendar.yearString,calendar.monthString,calendar.localizedMonthString?[NSString stringWithFormat:@"(%@)",calendar.localizedMonthString]:@"",calendar.dayString];
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
