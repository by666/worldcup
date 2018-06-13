//
//  ScheduleDetailViewCell.m
//  worldcup
//
//  Created by by.huang on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailViewCell.h"

@interface ScheduleDetailViewCell()

@property(strong, nonatomic)UILabel *dateLabal;
@property(strong, nonatomic)UILabel *competitionLabel;
@property(strong, nonatomic)UILabel *aTeamLabel;
@property(strong, nonatomic)UILabel *bTeamLabel;
@property(strong, nonatomic)UILabel *scoreLabel;

@end

@implementation ScheduleDetailViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        [self initView];
    }
    return self;
}

-(void)initView{
    CGFloat width = ScreenWidth/5;
    
    _dateLabal = [[UILabel alloc]initWithFont:STFont(13) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _dateLabal.frame = CGRectMake(0, 0, width, STHeight(30));
    [self.contentView addSubview:_dateLabal];

    _competitionLabel = [[UILabel alloc]initWithFont:STFont(13) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _competitionLabel.frame = CGRectMake(width, 0, width, STHeight(30));
    [self.contentView addSubview:_competitionLabel];
    
    _aTeamLabel = [[UILabel alloc]initWithFont:STFont(13) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _aTeamLabel.frame = CGRectMake(width * 2, 0, width, STHeight(30));
    [self.contentView addSubview:_aTeamLabel];
 
    _scoreLabel = [[UILabel alloc]initWithFont:STFont(13) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _scoreLabel.frame = CGRectMake(width * 3, 0, width, STHeight(30));
    [self.contentView addSubview:_scoreLabel];
    
    _bTeamLabel = [[UILabel alloc]initWithFont:STFont(13) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    _bTeamLabel.frame = CGRectMake(width * 4, 0, width, STHeight(30));
    [self.contentView addSubview:_bTeamLabel];
    
}


-(void)updateData:(ScheduleDetailModel *)model{
    _dateLabal.text = model.date;
    _aTeamLabel.text = model.team_A_name;
    _bTeamLabel.text = model.team_B_name;
    _scoreLabel.text = model.score;
    _competitionLabel.text = model.competition;
}





+(NSString *)identify{
    return NSStringFromClass([ScheduleDetailViewCell class]);
}

@end
