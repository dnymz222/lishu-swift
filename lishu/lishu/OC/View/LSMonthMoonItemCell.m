//
//  MLMonthMoonItemCell.m
//  lishu
//
//  Created by xueping on 2021/5/19.
//

#import "LSMonthMoonItemCell.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSMonthMoonItemCell ()

@property(nonatomic,strong)UIImageView  *iconView;
@property(nonatomic,strong)UILabel *dayLabel;

@property(nonatomic,strong)UILabel *timeLabel;

@end

@implementation LSMonthMoonItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self  = [super initWithFrame:frame];
    if (self) {

        [self.contentView addSubview:self.iconView];
        [self.contentView addSubview:self.dayLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.contentView).offset(5);
            make.centerX.equalTo(self.contentView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        [self.dayLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.iconView.mas_bottom).offset(5);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@20);
        }];
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(self.dayLabel.mas_bottom).offset(5);
            make.left.right.equalTo(self.contentView);
            make.height.equalTo(@20);
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
        _dayLabel= label;
    }
    return _dayLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeLabel= label;
    }
    return _timeLabel;
}


- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
     
        _iconView =  imageview;
    }
    return _iconView;
}

- (void)configLunarItemModel:(LSLunarTermItemModel *)lunarItem month:(LSMonth *)month {
    
    switch (lunarItem.type) {
        case 0:{
            UIImage *image = [UIImage imageNamed:@"newmoon"];
            [self.iconView setImage:image];
        }
            break;
        case 1:
        {
            UIImage *image = [UIImage imageNamed:@"firstqurter"];
            [self.iconView setImage:image];
        }
            
            break;
        case 2:
        {
            UIImage *image = [UIImage imageNamed:@"fullmoon"];
            [self.iconView setImage:image];
        }
            
            break;
        case 3:
        {
            UIImage *image = [UIImage imageNamed:@"lastquarter"];
            [self.iconView setImage:image];
        }
            
            break;
            
            
        default:
            break;
    }
    
    LSDate *lsdate = [[LSDate alloc] initWithJD:lunarItem.JD timezone:month.timeZone];
    
    self.dayLabel.text = [lsdate localdayString];
    self.timeLabel.text = [lsdate localTimeString];
}




@end
