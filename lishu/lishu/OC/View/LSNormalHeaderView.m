//
//  LSNormalHeaderView.m
//  lishu
//
//  Created by xueping on 2021/10/22.
//

#import "LSNormalHeaderView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSNormalHeaderView    ()

@property(nonatomic,strong,readwrite)UILabel *titleLabel;

@end

@implementation LSNormalHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titleLabel];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-10);
            make.top.bottom.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:16.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _titleLabel = label;
    }
    return _titleLabel;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
