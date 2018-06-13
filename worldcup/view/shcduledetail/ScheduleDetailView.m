//
//  ScheduleDetailView.m
//  worldcup
//
//  Created by by.huang on 2018/6/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailView.h"
#import "ScheduleDetailViewCell.h"
@interface ScheduleDetailView()<UITableViewDelegate,UITableViewDataSource>

@property(strong, nonatomic)ScheduleDetailViewModel *mViewModel;
@property(strong, nonatomic)UITableView *aTableView;
@property(strong, nonatomic)UITableView *bTableView;

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
    if(_mViewModel){
        [_mViewModel requestDatas];
    }
    
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

-(void)updateView{
    UIScrollView *scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, STHeight(230), ScreenWidth, ContentHeight - STHeight(230))];
    scrollView.backgroundColor = [cblack colorWithAlphaComponent:0.1f];
    scrollView.contentSize = CGSizeMake(ScreenWidth, STHeight(220)+STHeight(30) * (_mViewModel.aTeamDatas.count + _mViewModel.bTeamDatas.count));
    [self addSubview:scrollView];
    
    [self initATeam:scrollView];
    [self initBTeam:scrollView];
    
    if(_mViewModel){
        [_mViewModel initAdMob];
    }
}

-(void)initATeam:(UIScrollView *)scrollView{
    UIImageView *aImageView  = [[UIImageView alloc]init];
    aImageView.contentMode = UIViewContentModeScaleAspectFill;
    aImageView.frame = CGRectMake(STWidth(15), STHeight(30), STWidth(50),  STHeight(20));
    [aImageView sd_setImageWithURL:[NSURL URLWithString:_mViewModel.model.team_A_logo]];
    [scrollView addSubview:aImageView];
    
    
    NSString *aName = _mViewModel.model.team_A_name;
    UILabel *aLabel = [[UILabel alloc]initWithFont:STFont(14) text:aName textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    CGSize aLabelSize = [aName sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    aLabel.frame = CGRectMake(STWidth(80), STHeight(30), aLabelSize.width, STHeight(20));
    [scrollView addSubview:aLabel];
    
    _aTableView = [self createTableView:_aTableView];
    _aTableView.frame = CGRectMake(0, STHeight(110), ScreenWidth, [_mViewModel.aTeamDatas count] * STHeight(30));
    [scrollView addSubview:_aTableView];
    
    for(int i = 0 ; i < 2 ; i ++ ){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(80) + STHeight(30) * i, ScreenWidth,LineHeight)];
        lineView.backgroundColor = c03;
        [scrollView addSubview:lineView];
    }
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, STHeight(110)+ [_mViewModel.aTeamDatas count] * STHeight(30) , ScreenWidth,LineHeight)];
    lineView3.backgroundColor = c03;
    [scrollView addSubview:lineView3];
    
    NSArray *titles = @[@"日期",@"赛事",@"队伍",@"比分",@"队伍"];
    for(int i = 0 ; i < titles.count ; i ++){
        UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(14) text:titles[i] textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
        titleLabel.frame = CGRectMake(ScreenWidth/5 * i, STHeight(80), ScreenWidth/5, STHeight(30));
        [scrollView addSubview:titleLabel];
        
        if(i  == 4){
            return;
        }
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/ 5 ) * (i+1), STHeight(82),LineHeight,STHeight(26))];
        lineView2.backgroundColor = c03;
        [scrollView addSubview:lineView2];
    }
    
}


-(void)initBTeam:(UIScrollView *)scrollView{
    CGFloat height = STHeight(110) + [_mViewModel.aTeamDatas count] * STHeight(30);
    UIImageView *aImageView  = [[UIImageView alloc]init];
    aImageView.contentMode = UIViewContentModeScaleAspectFill;
    aImageView.frame = CGRectMake(STWidth(15), height + STHeight(30), STWidth(50),  STHeight(20));
    [aImageView sd_setImageWithURL:[NSURL URLWithString:_mViewModel.model.team_B_logo]];
    [scrollView addSubview:aImageView];
    
    
    NSString *aName = _mViewModel.model.team_B_name;
    UILabel *aLabel = [[UILabel alloc]initWithFont:STFont(14) text:aName textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    CGSize aLabelSize = [aName sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    aLabel.frame = CGRectMake(STWidth(80), height + STHeight(30), aLabelSize.width, STHeight(20));
    [scrollView addSubview:aLabel];
    
    _bTableView = [self createTableView:_bTableView];
    _bTableView.frame = CGRectMake(0, height + STHeight(110), ScreenWidth, [_mViewModel.bTeamDatas count] * STHeight(30));
    [scrollView addSubview:_bTableView];
    
    for(int i = 0 ; i < 2 ; i ++ ){
        UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, height + STHeight(80) + STHeight(30) * i, ScreenWidth,LineHeight)];
        lineView.backgroundColor = c03;
        [scrollView addSubview:lineView];
    }
    
    
    UIView *lineView3 = [[UIView alloc]initWithFrame:CGRectMake(0, height + STHeight(110)+ [_mViewModel.bTeamDatas count] * STHeight(30) , ScreenWidth,LineHeight)];
    lineView3.backgroundColor = c03;
    [scrollView addSubview:lineView3];
    
    NSArray *titles = @[@"日期",@"赛事",@"队伍",@"比分",@"队伍"];
    for(int i = 0 ; i < titles.count ; i ++){
        UILabel *titleLabel = [[UILabel alloc]initWithFont:STFont(14) text:titles[i] textAlignment:NSTextAlignmentCenter textColor:c05 backgroundColor:nil multiLine:NO];
        titleLabel.frame = CGRectMake(ScreenWidth/5 * i, height + STHeight(80), ScreenWidth/5, STHeight(30));
        [scrollView addSubview:titleLabel];
        
        if(i  == 4){
            return;
        }
        UIView *lineView2 = [[UIView alloc]initWithFrame:CGRectMake((ScreenWidth/ 5 ) * (i+1), height + STHeight(82),LineHeight,STHeight(26))];
        lineView2.backgroundColor = c03;
        [scrollView addSubview:lineView2];
    }
}


-(UITableView *)createTableView:(UITableView *)tableView{
        tableView = [[UITableView alloc]init];
        tableView.backgroundColor = cwhite;
        tableView.showsVerticalScrollIndicator = NO;
        tableView.showsHorizontalScrollIndicator = NO;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.scrollEnabled = NO;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        if (@available(iOS 11.0, *)) {
            tableView.estimatedRowHeight = 0;
            tableView.estimatedSectionFooterHeight = 0;
            tableView.estimatedSectionHeaderHeight=0;
            tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }
    
    return tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(tableView == _aTableView){
        return _mViewModel.aTeamDatas.count;
    }
    return _mViewModel.bTeamDatas.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return STHeight(30);
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleDetailViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ScheduleDetailViewCell identify]];
    if(!cell){
        cell = [[ScheduleDetailViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleDetailViewCell identify]];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    [cell setBackgroundColor:[cblack colorWithAlphaComponent:0.1f]];
    if(tableView == _aTableView){
        ScheduleDetailModel *model = [_mViewModel.aTeamDatas objectAtIndex:indexPath.row];
        [cell updateData:model];
    }else{
        ScheduleDetailModel *model = [_mViewModel.bTeamDatas objectAtIndex:indexPath.row];
        [cell updateData:model];
    }

    return cell;
}

@end
