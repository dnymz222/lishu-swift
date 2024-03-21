//
//  LSAccuFooterView.m
//  lishu
//
//  Created by xueping on 2021/11/28.
//

#import "LSAccuFooterView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"


@interface LSAccuFooterView ()

@property(nonatomic,strong)UILabel *powLabel;
@property(nonatomic,strong)UIImageView *iconView;


@end

@implementation LSAccuFooterView


- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.powLabel];
        [self.contentView addSubview:self.iconView  ];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView.mas_centerX).offset(-60);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@30);
            make.width.equalTo(@209);
            
        }];
        
        
        [self.powLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView.mas_centerX).offset(-50);
            make.centerY.equalTo(self.contentView);
            make.height.equalTo(@30);
            make.width.equalTo(@120);
            
        }];
        
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapIn:)];
        [self addGestureRecognizer:tap];
        tap.numberOfTouchesRequired = 1;
        
    }
    return self;
}

- (void)tapIn:(UIGestureRecognizer *)recongnizer {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(accuFooterViewTapLink)]) {
        [self.delegate accuFooterViewTapLink];
    }
}

- (UILabel *)powLabel {
    if (!_powLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:20.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.text = @"Powered by";
        _powLabel = label;
    }
    return _powLabel;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        UIImage *image  = [UIImage imageNamed:@"accuweather"];
        [imageview setImage:image];
        _iconView =  imageview;
    }
    return _iconView;
}




/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
