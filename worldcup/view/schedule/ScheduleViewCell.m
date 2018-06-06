//
//  ScheduleViewCell.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleViewCell.h"
#import "UIImageView+WebCache.h"
@interface ScheduleViewCell()

@property(strong, nonatomic)UILabel *timeLabel;
@property(strong, nonatomic)UILabel *vsLabel;
@property(strong, nonatomic)UILabel *statuLabel;
@property(strong, nonatomic)UIImageView *aImageView;
@property(strong, nonatomic)UIImageView *bImageView;
@property(strong, nonatomic)UILabel *aNameLabel;
@property(strong, nonatomic)UILabel *bNameLabel;
@property(strong, nonatomic)UIView *lineView;

@end

@implementation ScheduleViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    _timeLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _timeLabel.frame = CGRectMake(0, STHeight(20), ScreenWidth, STHeight(14));
    [self.contentView addSubview:_timeLabel];
    
    _vsLabel = [[UILabel alloc]initWithFont:STFont(26) text:@"VS" textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    _vsLabel.frame = CGRectMake(0, STHeight(47), ScreenWidth, STHeight(26));
    [self.contentView addSubview:_vsLabel];
    
    _statuLabel = [[UILabel alloc]initWithFont:STFont(12) text:@"" textAlignment:NSTextAlignmentCenter textColor:c07 backgroundColor:nil multiLine:NO];
    _statuLabel.frame = CGRectMake(0, STHeight(85), ScreenWidth, STHeight(12));
    [self.contentView addSubview:_statuLabel];
    
    
    CGFloat imageWidth = STHeight(40);
    _aImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth / 2 - imageWidth ) /2, STHeight(30), imageWidth, imageWidth)];
    _aImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_aImageView];
    
    _bImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth / 2 - imageWidth ) /2 + ScreenWidth / 2, STHeight(30), imageWidth, imageWidth)];
    _bImageView.contentMode = UIViewContentModeScaleAspectFill;
    [self.contentView addSubview:_bImageView];
    
    
    _aNameLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:YES];
    _aNameLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:_aNameLabel];
    
    _bNameLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:YES];
    _bNameLabel.textAlignment = NSTextAlignmentCenter;
    _bNameLabel.frame = CGRectMake(ScreenWidth/2, STHeight(80), ScreenWidth/2, STHeight(14));
    [self.contentView addSubview:_bNameLabel];
    
    _lineView = [[UIView alloc]init];
    _lineView.frame = CGRectMake(0, CONTENT_HEIGHT - LineHeight, ScreenWidth, LineHeight);
    _lineView.backgroundColor = c07;
    [self.contentView addSubview:_lineView];
    
}


-(void)updateData:(ScheduleModel *)model{
    _timeLabel.text = [model.time_utc substringWithRange:NSMakeRange(0, 5)];
    _statuLabel.text = model.TVList;
    if(IS_NS_STRING_EMPTY(model.team_A_logo)){
        model.team_A_logo = @"https://img.dongqiudi.com//soccer//data//logo//team//team_default.png";
    }
    if(IS_NS_STRING_EMPTY(model.team_B_logo)){
        model.team_B_logo = @"https://img.dongqiudi.com//soccer//data//logo//team//team_default.png";
    }
    [_aImageView sd_setImageWithURL:[NSURL URLWithString:model.team_A_logo]];
    [_bImageView sd_setImageWithURL:[NSURL URLWithString:model.team_B_logo]];
    _aNameLabel.text = model.team_A_name;
    CGSize aSize = [_aNameLabel.text sizeWithMaxWidth:ScreenWidth/4 font:[UIFont systemFontOfSize:STFont(14)]];
    _aNameLabel.frame = CGRectMake((ScreenWidth/2 - ScreenWidth / 4)/2, STHeight(80), ScreenWidth/4, aSize.height);

    _bNameLabel.text = model.team_B_name;
    CGSize bSize = [_bNameLabel.text sizeWithMaxWidth:ScreenWidth/4 font:[UIFont systemFontOfSize:STFont(14)]];
    _bNameLabel.frame = CGRectMake((ScreenWidth/2 - ScreenWidth / 4)/2 + ScreenWidth/2, STHeight(80), ScreenWidth/4, bSize.height);
    
    if(model.hasLine){
        _lineView.hidden = NO;
    }else{
        _lineView.hidden = YES;
    }
}





+(NSString *)identify{
    return NSStringFromClass([ScheduleViewCell class]);
}

@end
