//
//  LSSolarTermCell.m
//  lishu
//
//  Created by efc on 2021/9/23.
//

#import "LSSolarTermCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSSolarTermCell ()

@property(nonatomic,strong)UILabel *nameLabel;

@property(nonatomic,strong)UILabel *timeLabel;



@end

@implementation LSSolarTermCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.contentView.backgroundColor =  UIColorFromRGB(cellbackGroundColor);
        [self.contentView addSubview:self.nameLabel];
        [self.contentView addSubview:self.timeLabel];
        [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.right.equalTo(self.contentView).offset(-140);
            make.height.equalTo(@36);
        }];
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.left.equalTo(self.nameLabel.mas_right).offset(10);
            make.top.equalTo(self.contentView).offset(10);
            make.height.equalTo(@24);
        }];
        
    }
    return self;
}

- (UILabel *)nameLabel {
    if (!_nameLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont boldSystemFontOfSize:14.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.numberOfLines = 0;
        _nameLabel = label;
    }
    return _nameLabel;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:14.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeLabel= label;
    }
    return _timeLabel;
}

- (void)configItemModel:(LSSolarTermItemModel *)solarTerm {
    
    self.nameLabel.text = [NSString stringWithFormat:@"%@(%@ %d°)",solarTerm.name,NSLocalizedString(@"apparent_ecliptic_longitude", nil),solarTerm.targetLong];
    
    self.timeLabel.text = [NSString stringWithFormat:@"%@",[solarTerm.resultDate localFullTimeString]] ;
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
