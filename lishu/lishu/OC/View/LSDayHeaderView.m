//
//  LSDayHeaderView.m
//  lishu
//
//  Created by xueping on 2021/5/16.
//

#import "LSDayHeaderView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSDayHeaderView ()

@property(nonatomic,strong,readwrite)UILabel *titleLabel;
@property(nonatomic,strong,readwrite)UIButton *filterButton;

@end

@implementation LSDayHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self  = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        self.contentView.backgroundColor =  UIColorFromRGB(navColor);
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.filterButton  ];
        [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(8);
            make.width.greaterThanOrEqualTo(@100);
            make.top.bottom.equalTo(self.contentView);
        }];
        
        
        
        [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-13);
            make.width.equalTo(@44);
            make.top.bottom.equalTo(self.contentView);
        }];
        
    }
    return self;
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:16];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _titleLabel = label;
    }
    return _titleLabel;
}

-(UIButton *)filterButton {
    if (!_filterButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        UIImage *image   =[UIImage imageNamed:@"xianxia"];
        [button setImage:image forState:UIControlStateNormal];
        UIImage *selectimage   =[UIImage imageNamed:@"xiangyou"];
        [button setImage:selectimage forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(filterButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        _filterButton  = button;
    }
    return _filterButton    ;
}


- (void)filterButtonClick:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(lsDayheaderFilterButtonClickSection:)]) {
        [self.delegate lsDayheaderFilterButtonClickSection:self.tag];
    }
    
}

- (void)configAstroSection:(LSAstroSectionModel *)section {
    self.titleLabel.text     = section.title;
    
    self.filterButton.selected  =section.isOpen;
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
