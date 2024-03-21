//
//  LSFilterCell.m
//  lishu
//
//  Created by xueping on 2021/10/13.
//

#import "LSFilterCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSFilterCell ()

@property(nonatomic,strong)UILabel *titlelabel;
@property(nonatomic,strong)UIButton *filterButton;

@property(nonatomic,strong)LSWorkingDayConfig *config;

@property(nonatomic,strong)LSCalendarTypeModel *calendar;

@end

@implementation LSFilterCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.titlelabel    ];
        [self.contentView  addSubview:self.filterButton];
        self.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        self.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self.titlelabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(13);
            make.top.bottom.equalTo(self.contentView);
            make.right.equalTo(self.contentView).offset(-70);
        }];
        
        [self.filterButton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-15);
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
        
        UIImage *selectimage   =[UIImage imageNamed:@"xuanzhong"];
        [button setImage:selectimage forState:UIControlStateSelected];
        
//        UIImage *buimage   =[UIImage imageNamed:@"suoguan"];
//        [button setImage:buimage forState:UIControlStateDisabled];
        
//        button.enabled = NO;
        
        [button addTarget:self action:@selector(buttonClick:) forControlEvents:UIControlEventTouchUpInside];
        
        _filterButton  = button;
    }
    return _filterButton    ;
}

-(void)buttonClick:(UIButton *)button {
    
    if (self.config) {
        if (self.delegate && [self.delegate respondsToSelector:@selector(filtercellButtonClick:config:)]) {
            [self.delegate filtercellButtonClick:button config:self.config];
        }
    } else if (self.calendar){
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(filtercellButtonClick:calendar:)]) {
            [self.delegate filtercellButtonClick:button calendar:self.calendar];
        }
        
    }
    
    
    
    
}

- (void)configWorkingDay:(LSWorkingDayConfig *)config   {
    
    self.config  = config;
    if (config.is_default) {
        self.titlelabel.text = [NSString stringWithFormat:@"%@%@",NSLocalizedString(@"default", nil),config.config];
    } else {
        self.titlelabel .text = config.config;
    }
    
//    if (isvip || config.is_default) {
//
//        self.filterButton.enabled = YES;
        self.filterButton.selected = config.selected;
//    } else {
//        self.filterButton.enabled = NO;
//        self.filterButton.selected = NO;
//    }
  
    
}

- (void)configCalendarType:(LSCalendarTypeModel *)calendar  {
    self.calendar = calendar;
    self.titlelabel.text = calendar.name;
    
//    if (isvip || calendar.is_default) {
//
//        self.filterButton.enabled = YES;
        self.filterButton.selected = calendar.selected;
//    } else {
//        self.filterButton.enabled = NO;
//        self.filterButton.selected  =NO;
//    }
  
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
