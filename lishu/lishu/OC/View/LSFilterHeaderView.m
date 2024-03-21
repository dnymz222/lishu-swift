//
//  LSFilterHeaderView.m
//  lishu
//
//  Created by xueping on 2021/10/15.
//

#import "LSFilterHeaderView.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"


@interface LSFilterHeaderView ()

@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UIButton *filterButton;

@property(nonatomic,strong)UIButton *showButton;

@property(nonatomic,strong)LSWorkingDayConfig *config;


@end

@implementation LSFilterHeaderView

- (instancetype)initWithReuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithReuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titlelabel    ];
        [self.contentView  addSubview:self.filterButton];
        [self.contentView  addSubview:self.showButton];
      
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-120);
        }];
        
        
        [self.showButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.showButton.mas_left).offset(-5);
            make.centerY.equalTo(self.contentView);
            make.width.equalTo(@40);
            make.height.equalTo(@40);
        }];
        
        
        
        
        
    }
    return self;
}

- (UILabel *)titlelabel {
    if (!_titlelabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _titlelabel  = label;
    }
    return _titlelabel;
}


-(UIButton *)filterButton {
    if (!_filterButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        
        UIImage *image   =[UIImage imageNamed:@"weixuanzhong"];
        [button setImage:image forState:UIControlStateNormal];
        
        UIImage *select_image   =[UIImage imageNamed:@"xuanzhong"];
        [button setImage:select_image forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag  =0;
        _filterButton  = button;
    }
    return _filterButton    ;
}

-(UIButton *)showButton {
    if (!_showButton) {
        UIButton *button  =[UIButton buttonWithType:UIButtonTypeCustom];
        button.bounds = CGRectMake(0, 0, 44, 44);
        
        UIImage *image   =[UIImage imageNamed:@"xiangyou"];
        [button setImage:image forState:UIControlStateNormal];
        
        UIImage *select_image   =[UIImage imageNamed:@"xianxia"];
        [button setImage:select_image forState:UIControlStateSelected];
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        button.tag = 1;
        _showButton  = button;
    }
    return _showButton    ;
}

-(void)buttonClick:(UIButton *)button {
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(filterHeaderViewButtonClick:buttonIndex:config:)]) {
        [self.delegate filterHeaderViewButtonClick:button buttonIndex:button.tag config:self.config];
    }
    
    
    
}

- (void)configWorkingDay:(LSWorkingDayConfig *)config  {
    
    self.config = config;
    
    self.titlelabel .text = config.configId;
    self.filterButton.selected = config.selected;
    self.showButton.selected  =config.is_show;
}



/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
