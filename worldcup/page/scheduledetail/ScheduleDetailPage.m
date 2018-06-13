//
//  ScheduleDetailPage.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailPage.h"
#import "ScheduleDetailView.h"

@interface ScheduleDetailPage ()<ScheduleDetailViewDelegate>

@property(strong, nonatomic)ScheduleModel *mData;
@property(strong, nonatomic)ScheduleDetailView *scheduleDetailView;

@end

@implementation ScheduleDetailPage

+(void)show:(BaseViewController *)controller model:(ScheduleModel *)model{
    ScheduleDetailPage *page = [[ScheduleDetailPage alloc]init];
    page.mData = model;
    [controller pushPage:page];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:@"比赛详情" needback:YES];
    [self initView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:c03];
}


-(void)initView{
    ScheduleDetailViewModel *viewModel = [[ScheduleDetailViewModel alloc]initWithData:_mData];
    viewModel.delegate = self;
    
    _scheduleDetailView = [[ScheduleDetailView alloc]initWithViewModel:viewModel];
    _scheduleDetailView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    _scheduleDetailView.backgroundColor = cwhite;
    [self.view addSubview:_scheduleDetailView];
    
    
}


-(void)onInitAdMob{
    [self initAdmob];
}

-(void)onRequestDatas:(Boolean)success{
    if(success){
        [_scheduleDetailView updateView];
    }
}

@end
