//
//  ScheduleView.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleView.h"
#import "ScheduleViewCell.h"
#import "ScheduleTitleViewCell.h"

@interface ScheduleView()<UITableViewDataSource,UITableViewDelegate>

@property(strong, nonatomic)UITableView *tableView;
@property(strong, nonatomic)ScheduleViewModel *mViewModel;

@end

@implementation ScheduleView


-(instancetype)initWithViewModel:(ScheduleViewModel *)viewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}


-(void)initView{
    self.backgroundColor = cwhite;
    [self addSubview:[self tableView]];
    [self requestNew];
}


-(UITableView *)tableView{
    if(_tableView == nil){
        _tableView = [[UITableView alloc]init];
        _tableView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48));
        _tableView.backgroundColor = cwhite;
        _tableView.showsVerticalScrollIndicator = NO;
        _tableView.showsHorizontalScrollIndicator = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        
        _tableView.mj_footer = [MJRefreshAutoNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(requestMore)];
        MJRefreshStateHeader *header = [MJRefreshStateHeader headerWithRefreshingTarget:self refreshingAction:@selector(requestNew)];
        header.lastUpdatedTimeLabel.hidden = YES;
        _tableView.mj_header = header;
        
        if (@available(iOS 11.0, *)) {
            _tableView.estimatedRowHeight = 0;
            _tableView.estimatedSectionFooterHeight = 0;
            _tableView.estimatedSectionHeaderHeight=0;
            _tableView.contentInsetAdjustmentBehavior= UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _tableView;
}



-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return [_mViewModel.datas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    if(model.isTitle){
        return TITLE_HEIGHT;
    }else{
        return CONTENT_HEIGHT;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    id cell;
    if(model.isTitle){
        cell = [tableView dequeueReusableCellWithIdentifier:[ScheduleTitleViewCell identify]];
        if(!cell){
            cell = [[ScheduleTitleViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleTitleViewCell identify]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell updateData:model];
    }
    else{
        cell = [tableView dequeueReusableCellWithIdentifier:[ScheduleViewCell identify]];
        if(!cell){
            cell = [[ScheduleViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleViewCell identify]];
        }
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell updateData:model];
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleModel *model = [_mViewModel.datas objectAtIndex:indexPath.row];
    if(!model.isTitle && _mViewModel){
        [_mViewModel goScheduleDetailPage:model];
    }
}


-(void)requestMore{
    if(_mViewModel){
        [_mViewModel requestMore];
    }
}

-(void)requestNew{
    if(_mViewModel){
        [_mViewModel requestNew];
    }
}

-(void)updateView{
    [_tableView reloadData];
}


@end
