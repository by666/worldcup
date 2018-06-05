//
//  ScheduleView.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleView.h"
#import "ScheduleViewCell.h"

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
    return [_mViewModel.sortDatas count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *datas = [_mViewModel.sortDatas objectAtIndex:indexPath.row];
    return ([datas count] * CONTENT_HEIGHT) + TITLE_HEIGHT;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ScheduleViewCell *cell = [tableView dequeueReusableCellWithIdentifier:[ScheduleViewCell identify]];
    if(!cell){
        cell = [[ScheduleViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[ScheduleViewCell identify] viewModel:_mViewModel];
    }
    [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    if(_mViewModel && !IS_NS_COLLECTION_EMPTY(_mViewModel.sortDatas)){
        NSInteger row = indexPath.row;
        [cell updateData:[_mViewModel.sortDatas objectAtIndex:row] row:row];
    }
    return cell;
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
