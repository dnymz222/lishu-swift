//
//  LSYearMoonCell.m
//  lishu
//
//  Created by xueping on 2021/12/7.
//

#import "LSYearMoonCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"
#import "LSDate.h"

@interface LSYearMoonCell ()



@property(nonatomic,strong)UILabel *timeLabel;
//@property(nonatomic,strong)UIImageView *moonIconView;
//
//@property(nonatomic,strong)UILabel *fulltimeLabel;
//@property(nonatomic,strong)UILabel *fullMoonIconView;
//
//@property(nonatomic,strong)UILabel *nextTimeLabel;


@property(nonatomic,strong)UILabel *durationLabel;

@property(nonatomic,strong)NSMutableArray *imageViews;
@property(nonatomic,strong)NSMutableArray *labels;


@end

@implementation LSYearMoonCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.timeLabel];
        
        
        self.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(15);
            make.width.equalTo(@28);
            make.height.equalTo(@20);
        }];
    
        
        self.imageViews = [NSMutableArray array];
        self.labels = [NSMutableArray array];
        
        [self.contentView addSubview:self.durationLabel];
        
        [self.durationLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(40);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@30);
            make.right.equalTo(self.contentView).offset(-10);
        }];
        
        
        for (int i = 0; i < 4; i ++) {
            
            UIImageView *imageView = [[UIImageView alloc] init];
            imageView.contentMode = UIViewContentModeScaleAspectFit;
            [self.contentView   addSubview:imageView];
            imageView.frame = CGRectMake(50, 50+40*i+6, 28, 28);
            
            [self.imageViews addObject:imageView];
            
            
            
            
            UILabel *label = [[UILabel alloc] init];
            label.textAlignment = NSTextAlignmentLeft;
            label.font = [UIFont systemFontOfSize:15.f];
            label.textColor  = UIColorFromRGB(TextDarkColor);
            
            [self.contentView addSubview:label];
            
            label.frame = CGRectMake(88, 50+40*i+10, 160, 20);
            
            [self.labels addObject:label];
            
            
            
        }
        
        
//        [self.contentView addSubview:self.nextTimeLabel];
        
        
        
//        [self.nextTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//            make.left.equalTo(self.durationLabel.mas_right).offset(10);
//            make.bottom.equalTo(self.contentView).offset(-10);
//            make.height.equalTo(@40);
//            make.right.equalTo(self.contentView).offset(-10);
//        }];
        
        
        
    }
    return self;
}


- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)durationLabel {
    if (!_durationLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _durationLabel = label;
    }
    return _durationLabel;
}

//- (UILabel *)nextTimeLabel {
//    if (!_nextTimeLabel) {
//        UILabel *label = [[UILabel alloc] init];
//        label.textAlignment = NSTextAlignmentLeft;
//        label.font = [UIFont systemFontOfSize:15.f];
//        label.textColor  = UIColorFromRGB(TextDarkColor);
//        label.numberOfLines = 0;
//        _nextTimeLabel = label;
//    }
//    return _nextTimeLabel;
//}


- (void)configIndex:(NSInteger)index lunarTerm:(LSLunarTermModel *)lunarTerm {
    
    self.timeLabel.text =[NSString stringWithFormat:@"%ld:",index];
    
    NSInteger n  = lunarTerm.lunarArray.count;
    for (int i = 0; i <4 ; i++) {
        
        UIImageView *imageview =  self.imageViews[i];
        UILabel *label  = self.labels[i];
        if (i < n) {
            
            LSLunarTermItemModel *itemModel = lunarTerm.lunarArray[i];
            
            switch (itemModel.type) {
                case 0:{
                    UIImage *image = [UIImage imageNamed:@"newmoon"];
                    [imageview setImage:image];
                }
                    break;
                case 1:
                {
                    UIImage *image = [UIImage imageNamed:@"firstqurter"];
                    [imageview   setImage:image];
                }
                    
                    break;
                case 2:
                {
                    UIImage *image = [UIImage imageNamed:@"fullmoon"];
                    [imageview setImage:image];
                }
                    
                    break;
                case 3:
                {
                    UIImage *image = [UIImage imageNamed:@"lastquarter"];
                    [imageview setImage:image];
                }
                    
                    break;
                    
                    
                default:
                    break;
            }
            
            label.text = [itemModel.localDate localFullTimeString];
            
            
            
            
        } else {
            
            [imageview setImage:nil];
            label.text = @"";
            
            
        }
    }
    
    
    self.durationLabel.text = [NSString stringWithFormat:@"%@ —— %@   %0.2f %@",[lunarTerm.startDate localFullTimeString],[lunarTerm.endDate localFullTimeString],lunarTerm.duration,NSLocalizedString(@"days", nil)];
    
    
    
}









- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
