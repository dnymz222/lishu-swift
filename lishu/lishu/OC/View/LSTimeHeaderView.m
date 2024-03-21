//
//  LSTimeHeaderView.m
//  lishu
//
//  Created by xueping on 2021/5/16.
//

#import "LSTimeHeaderView.h"
#import "ColorSizeMacro.h"
#import <Masonry/Masonry.h>

@interface LSTimeHeaderView  ()

@property(nonatomic,strong)UILabel *UTCLabel;
@property(nonatomic,strong)UILabel *TDTLabel;
@property(nonatomic,strong)UILabel *JDLabel;

@end

@implementation LSTimeHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.UTCLabel];
        [self.contentView addSubview:self.TDTLabel];
        [self.contentView addSubview:self.JDLabel];
        
        [self.UTCLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.contentView).offset(5);
            make.height.equalTo(@20);
        }];
        
        [self.TDTLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.UTCLabel.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
        
        
        [self.JDLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.equalTo(self.TDTLabel.mas_bottom).offset(5);
            make.height.equalTo(@20);
        }];
        
        
        
    }
    
    return self;
}

- (UILabel *)UTCLabel {
    if (!_UTCLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _UTCLabel = label;
    }
    return _UTCLabel;
}

- (UILabel *)TDTLabel {
    if (!_TDTLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _TDTLabel= label;
    }
    return _TDTLabel;
}

- (UILabel *)JDLabel {
    if (!_JDLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _JDLabel = label;
    }
    return _JDLabel;
}








/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
