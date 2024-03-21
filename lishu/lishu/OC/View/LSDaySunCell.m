//
//  LSDaySunCell.m
//  lishu
//
//  Created by xueping on 2021/5/16.
//

#import "LSDaySunCell.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>




@interface LSDaySunCell ()


@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *riseLabel;
@property(nonatomic,strong)UILabel *otherLabel;

@end

@implementation LSDaySunCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self   =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.riseLabel];
        [self.contentView addSubview:self.otherLabel];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@56);
            make.height.equalTo(@56);
        }];
        
        [self.riseLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
            make.top.equalTo(self.contentView);
            make.bottom.equalTo(self.contentView.mas_centerY);
        }];
        
        [self.otherLabel  mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.iconView.mas_right).offset(10);
            make.right.equalTo(self.contentView).offset(-13);
            make.bottom.equalTo(self.contentView);
            make.top.equalTo(self.contentView.mas_centerY);
        }];
        
    }
    return self;
}
- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"sun"];
        [imageview setImage:image];
        _iconView =  imageview;
    }
    return _iconView;
}

- (UILabel *)riseLabel {
    if (!_riseLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _riseLabel= label;
    }
    return _riseLabel;
}


- (UILabel *)otherLabel {
    if (!_otherLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _otherLabel = label;
    }
    return _otherLabel;
}



- (void)configDay:(LSDay *)day{
    
    self.riseLabel.text = [NSString stringWithFormat:@"%@:%@ %@:%@",NSLocalizedString(@"sun_rise", nil),[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.sun.riseSet.riseJD],NSLocalizedString(@"sun_set", nil),[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.sun.riseSet.setJD]];
    
    self.otherLabel.text = [NSString stringWithFormat:@"%@:%@ %@:%@",NSLocalizedString(@"dawn_civil", nil),[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.sun.civilRiseSet.riseJD],NSLocalizedString(@"dusk_civil", nil),[LSRiseSetTime riseSetStringTimeZone:day.timeZone JD:day.sun.civilRiseSet.setJD]];
    
    
}






- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
