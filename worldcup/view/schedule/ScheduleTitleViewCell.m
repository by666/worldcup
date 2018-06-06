//
//  ScheduleTitleViewCell.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleTitleViewCell.h"

@interface ScheduleTitleViewCell()

@property(strong, nonatomic)UILabel *dateLabel;

@end

@implementation ScheduleTitleViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, TITLE_HEIGHT)];
    topView.backgroundColor = c02;
    [self.contentView addSubview:topView];
    
    _dateLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    [topView addSubview:_dateLabel];
    
}


-(void)updateData:(ScheduleModel *)model{
    _dateLabel.text = model.date_utc;
    CGSize timeSize = [_dateLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _dateLabel.frame = CGRectMake(STWidth(15), 0, timeSize.width, TITLE_HEIGHT);

}


+(NSString *)identify{
    return NSStringFromClass([ScheduleTitleViewCell class]);
}
@end
