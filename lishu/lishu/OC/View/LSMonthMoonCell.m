//
//  LSMonthMoonCell.m
//  lishu
//
//  Created by xueping on 2021/5/19.
//

#import "LSMonthMoonCell.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>


@interface LSMonthMoonCell ()


@property(nonatomic,strong)UILabel *dayLabel;

@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *riseLabel;

@property(nonatomic,strong)UILabel *transitLabel;

@property(nonatomic,strong)UILabel *setLabel;



@end


@implementation LSMonthMoonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat itemwidth = width/8;
        
        [self.contentView addSubview:self.dayLabel];
        
        [self.contentView addSubview:self.riseLabel];
        [self.contentView addSubview:self.transitLabel];
        [self.contentView addSubview:self.setLabel];
        
        [self.contentView addSubview:self.iconView];
        
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView);
            make.width.equalTo(@(itemwidth));
            make.top.bottom.equalTo(self.contentView);
        }];
        
        
        [self.riseLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(itemwidth);
            make.width.equalTo(@(itemwidth*2));
            make.top.bottom.equalTo(self.contentView);
        }];
        
        [self.transitLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(itemwidth*3);
            make.width.equalTo(@(itemwidth*2));
            make.top.bottom.equalTo(self.contentView);
        }];
        
        [self.setLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(itemwidth*5);
            make.width.equalTo(@(itemwidth*2));
            make.top.bottom.equalTo(self.contentView);
        }];
        
        CGFloat space = (itemwidth-28)/2;
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(itemwidth*7+space);
            make.width.equalTo(@28);
            make.height.equalTo(@28);
            make.centerY.equalTo(self.contentView);
        }];
        
        
        
        
    }
    return self;
}


- (UILabel *)dayLabel {
    if (!_dayLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _dayLabel = label;
    }
    return _dayLabel;
}


- (UILabel *)riseLabel {
    if (!_riseLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _riseLabel = label;
    }
    return _riseLabel;
}

- (UILabel *)setLabel {
    if (!_setLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _setLabel = label;
    }
    return _setLabel;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
       
        _iconView =  imageview;
    }
    return _iconView;
}


- (UILabel *)transitLabel {
    if (!_transitLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _transitLabel = label;
    }
    return _transitLabel;
}


- (void)configDay:(LSDay *)day {
    
    
    self.dayLabel.text = [NSString stringWithFormat:@"%02d",day.dayInMonth];
    
    self.riseLabel.text = [LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.moon.moonRiseJD];
    
    self.transitLabel.text = [LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.moon.moontransitJD];
    
    self.setLabel.text =[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.moon.moonSetJD] ;
    
    
    int phase = ((int)((day.phase_delta/12)+0.5))%30;
    NSString *imagename = [NSString stringWithFormat:@"moon_%02d",phase];
    [self.iconView setImage:[UIImage imageNamed:imagename   ]];
    
    
    
    
    
    
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
