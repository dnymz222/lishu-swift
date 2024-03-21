//
//  LSMoonGridItemCell.m
//  lishu
//
//  Created by xueping on 2021/9/20.
//

#import "LSMoonGridItemCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSMoonGridItemCell ()

@property(nonatomic,strong)UILabel *label;
@property(nonatomic,strong)UIImageView *iconView;

@end

@implementation LSMoonGridItemCell

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        
        self.contentView.backgroundColor = UIColorFromRGB(0x222222);
        [self.contentView addSubview:self.label];
        [self.contentView addSubview:self.iconView];
        
        
        [self.label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(2);
            make.top.equalTo(self.contentView).offset(2);
            make.right.equalTo(self.contentView).offset(-2);
            make.bottom.equalTo(self.contentView).offset(-2);
        }];
        
        [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(3);
            make.top.equalTo(self.contentView).offset(3);
            make.right.equalTo(self.contentView).offset(-3);
            make.bottom.equalTo(self.contentView).offset(-3);
        }];
    }
    return self;
}

- (UILabel *)label {
    if (!_label) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        label.adjustsFontSizeToFitWidth  = YES;
        label.textColor  = UIColorFromRGB(Themecolor);
        _label = label;
    }
    return _label;
}

- (UIImageView *)iconView {
    if (!_iconView) {
        UIImageView *imageview =  [[UIImageView alloc] init];
        imageview.contentMode  = UIViewContentModeScaleAspectFit;
        
        
      
        _iconView =  imageview;
    }
    return _iconView;
}

- (void)configNull {
    self.label.text = @"";
    [self.iconView setImage:nil];
}

- (void)configMonth:(NSInteger)month {
    
    NSString *key = [NSString stringWithFormat:@"month_%ld_s",month];
    
    self.label.text = [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:@"lish"];
    [self.iconView setImage:nil];
    
    
}

- (void)configDay:(NSInteger)day {
    self.label.text = [NSString stringWithFormat:@"%d",day];
    [self.iconView setImage:nil];
}

- (void)configPhase:(LSDay *)phaseDay {
    
    if (phaseDay) {
        self.label.text  =@"";
        
        int phase = ((int)((phaseDay.phase_delta/12)+0.5))%30;
        NSString *imagename = [NSString stringWithFormat:@"moon_%02d",phase];
        [self.iconView setImage:[UIImage imageNamed:imagename   ]];
    } else {
        [self configNull];
    }
    
}







@end
