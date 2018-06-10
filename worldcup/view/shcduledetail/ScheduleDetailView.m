//
//  ScheduleDetailView.m
//  worldcup
//
//  Created by by.huang on 2018/6/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailView.h"

@interface ScheduleDetailView()

@property(strong, nonatomic)ScheduleDetailViewModel *mViewModel;

@end

@implementation ScheduleDetailView

-(instancetype)initWithViewModel:(ScheduleDetailViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    
    [self initTop];
    [self initBody];
    
}

-(void)initTop{
    UIImageView *imageView  = [[UIImageView alloc]init];
    imageView.image = [UIImage imageNamed:@"ic_top"];
    imageView.contentMode = UIViewContentModeScaleAspectFill;
    imageView.frame = CGRectMake(0, 0, ScreenWidth,  STHeight(200));
    imageView.clipsToBounds = YES;
    [self addSubview:imageView];
    
    UIImageView *aImageView  = [[UIImageView alloc]init];
    aImageView.contentMode = UIViewContentModeScaleAspectFill;
    aImageView.frame = CGRectMake(STWidth(20), STHeight(60), STWidth(100),  STHeight(40));
    [self addSubview:aImageView];
    [aImageView sd_setImageWithURL:[NSURL URLWithString:_mViewModel.model.team_A_logo]];
    
    
    UILabel *aLabel = [[UILabel alloc]initWithFont:STFont(16) text:_mViewModel.model.team_A_name textAlignment:NSTextAlignmentCenter textColor:c07 backgroundColor:nil multiLine:NO];
    aLabel.frame = CGRectMake(STWidth(20), STHeight(140),  STWidth(100), STHeight(18));
    [self addSubview:aLabel];
    
    UIImageView *bImageView  = [[UIImageView alloc]init];
    bImageView.contentMode = UIViewContentModeScaleAspectFill;
    bImageView.frame = CGRectMake(ScreenWidth -  STWidth(120), STHeight(60), STWidth(100),  STHeight(40));
    [self addSubview:bImageView];
    [bImageView sd_setImageWithURL:[NSURL URLWithString:_mViewModel.model.team_B_logo]];

    UILabel *bLabel = [[UILabel alloc]initWithFont:STFont(16) text:_mViewModel.model.team_B_name textAlignment:NSTextAlignmentCenter textColor:c07 backgroundColor:nil multiLine:NO];
    bLabel.frame = CGRectMake(ScreenWidth -  STWidth(120), STHeight(140),  STWidth(100), STHeight(18));
    [self addSubview:bLabel];
    
    UILabel *timeLabel = [[UILabel alloc]initWithFont:STFont(14) text:[_mViewModel.model.time_utc substringWithRange:NSMakeRange(0, 5)] textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    timeLabel.frame = CGRectMake(0, STHeight(30), ScreenWidth, STHeight(14));
    [self addSubview:timeLabel];
    
    UILabel *vsLabel = [[UILabel alloc]initWithFont:STFont(26) text:@"VS" textAlignment:NSTextAlignmentCenter textColor:cwhite backgroundColor:nil multiLine:NO];
    vsLabel.frame = CGRectMake(0, STHeight(70), ScreenWidth, STHeight(26));
    [self addSubview:vsLabel];
    
    UILabel *statuLabel = [[UILabel alloc]initWithFont:STFont(14) text:_mViewModel.model.TVList textAlignment:NSTextAlignmentCenter textColor:c07 backgroundColor:nil multiLine:NO];
    statuLabel.frame = CGRectMake(0, STHeight(120), ScreenWidth, STHeight(14));
    [self addSubview:statuLabel];
    
    
}
-(void)initBody{
    
    UIView *titleView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(200), ScreenWidth, STHeight(30))];
    titleView.backgroundColor = c02;
    [self addSubview:titleView];
    
    UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"近期战绩" textAlignment:NSTextAlignmentLeft textColor:c01 backgroundColor:nil multiLine:NO];
    titleLabel.frame = CGRectMake(STWidth(15), 0, ScreenWidth, STHeight(30));
    [titleView addSubview:titleLabel];
    
    
}


@end
