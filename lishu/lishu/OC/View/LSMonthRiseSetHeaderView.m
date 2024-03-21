//
//  LSMonthRiseSetHeaderView.m
//  lishu
//
//  Created by xueping on 2021/9/21.
//

#import "LSMonthRiseSetHeaderView.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSMonthRiseSetHeaderView ()

@property(nonatomic,strong)UILabel *dayLabel;

//@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *riseLabel;

@property(nonatomic,strong)UILabel *transitLabel;

@property(nonatomic,strong)UILabel *setLabel;

@end

@implementation LSMonthRiseSetHeaderView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        CGFloat width = [UIScreen mainScreen].bounds.size.width;
        
        CGFloat itemwidth = width/7;
        
        self.contentView.backgroundColor = UIColorFromRGB(navColor);
        
        [self.contentView addSubview:self.dayLabel];
        
        [self.contentView addSubview:self.riseLabel];
        [self.contentView addSubview:self.transitLabel];
        [self.contentView addSubview:self.setLabel];
        
//        [self.contentView addSubview:self.iconView];
        
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





/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
