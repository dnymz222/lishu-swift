//
//  LSMonthMoonHeaderView.m
//  lishu
//
//  Created by xueping on 2021/5/19.
//

#import "LSMonthMoonHeaderView.h"
#import "LSMonthMoonItemCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSMonthMoonHeaderView ()


@property(nonatomic,strong)UILabel *dayLabel;

@property(nonatomic,strong)UILabel *iconView;

@property(nonatomic,strong)UILabel *riseLabel;

@property(nonatomic,strong)UILabel *transitLabel;

@property(nonatomic,strong)UILabel *setLabel;





@end

@implementation LSMonthMoonHeaderView

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat itemwidth = width/8;
        
        self.contentView.backgroundColor = UIColorFromRGB(navColor);
        
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
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(itemwidth*7);
            make.width.equalTo(@(itemwidth));
            make.top.bottom.equalTo(self.contentView);
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
        label.text = NSLocalizedString(@"date", nil);
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
        label.text = NSLocalizedString(@"rise", nil);
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
        label.text = NSLocalizedString(@"set", nil);
        _setLabel = label;
    }
    return _setLabel;
}

- (UILabel *)iconView {
    if (!_iconView) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        
        _iconView = label;
    }
    return _iconView;
}

- (UILabel *)transitLabel {
    if (!_transitLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.text = NSLocalizedString(@"transit", nil);
        _transitLabel = label;
    }
    return _transitLabel;
}










@end
