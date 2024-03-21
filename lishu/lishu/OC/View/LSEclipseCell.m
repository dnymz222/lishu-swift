//
//  LSEclipseCell.m
//  lishu
//
//  Created by xueping on 2021/10/14.
//

#import "LSEclipseCell.h"
#import <Masonry/Masonry.h>
#import "ColorSizeMacro.h"

@interface LSEclipseCell ()

@property(nonatomic,strong)UILabel *timeLabel;
@property(nonatomic,strong)UILabel *typeLabel;

@end

@implementation LSEclipseCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self  =[super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self.contentView addSubview:self.timeLabel];
        [self.contentView addSubview:self.typeLabel];
        self.contentView.backgroundColor = UIColorFromRGB(cellbackGroundColor);
        
        [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.contentView).offset(10);
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(@140);
        }];
        
        [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.contentView).offset(-10);
            make.top.bottom.equalTo(self.contentView);
            make.width.equalTo(@200);
        }];
        
        
        
    }
    return self;
}

- (UILabel *)timeLabel {
    if (!_timeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentLeft;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        _timeLabel = label;
    }
    return _timeLabel;
}

- (UILabel *)typeLabel {
    if (!_typeLabel) {
        UILabel *label = [[UILabel alloc] init];
        label.textAlignment = NSTextAlignmentRight;
        label.font = [UIFont systemFontOfSize:15.f];
        label.textColor  = UIColorFromRGB(TextDarkColor);
        label.adjustsFontSizeToFitWidth = YES;
        _typeLabel = label;
    }
    return _typeLabel;
}

- (void)configModel:(LSEclipseItemModel *)itemModel {
    
    self.timeLabel.text = [NSString stringWithFormat:@"%ld-%02d-%02d %02d:%02d",itemModel.lsdate.localYear,itemModel.lsdate.localMonth,itemModel.lsdate.localDay,itemModel.lsdate.localHour,itemModel.lsdate.localMinute];
    
    self.typeLabel.text = itemModel.name;
    
    
}



- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
