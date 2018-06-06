//
//  MainPage.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainPage.h"
#import "MainView.h"
#import "InfoDetailPage.h"
#import "ScheduleDetailPage.h"
#import "ScheduleViewModel.h"

@interface MainPage ()<MainViewDelegate,ScheduleViewModelDelegate>

@property(strong, nonatomic)MainView *mainView;

@end

@implementation MainPage

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = cwhite;
    [self showSTNavigationBar:MSG_INFO_TITLE needback:NO];
    [self initView];
    [self initAdmob];
}

-(void)viewWillAppear:(BOOL)animated{ 
    [super viewWillAppear:animated];
    [UIApplication sharedApplication].statusBarStyle = UIStatusBarStyleLightContent;
    [self setStatuBarBackgroud:c03];
}



-(void)initView{
    
    MainViewModel *viewModel = [[MainViewModel alloc]init];
    viewModel.delegate = self;
    
    ScheduleViewModel *scheduleViewModel = [[ScheduleViewModel alloc]init];
    scheduleViewModel.delegate = self;
    
    _mainView = [[MainView alloc]initWithViewModel:viewModel scheduleViewModel:scheduleViewModel];
    _mainView.frame = CGRectMake(0, StatuBarHeight + NavigationBarHeight, ScreenWidth, ContentHeight);
    [self.view addSubview:_mainView];
}


-(void)onRequestCallback:(Boolean)success errorMsg:(NSString *)errorMsg{
    if(_mainView){
        [_mainView updateScheduleView];
    }
}

-(void)onGoScheduleDetailPage:(ScheduleModel *)model{
    [ScheduleDetailPage show:self model:model];
}

-(void)onChangeTab:(NSInteger)index{
    if(index == 0){
        [self.navigationView setTitle:MSG_INFO_TITLE];
    }else{
        [self.navigationView setTitle:MSG_SCHEDULE_TITLE];
    }
}


-(void)initAdmob{
    [self createBanner:self];
}

-(void)createBanner:(UIViewController *)sender
{
    GADRequest *request = [GADRequest request];
    request.testDevices = [NSArray arrayWithObjects:@"450d43d2349f56a320138b0518b12c2195da2791", nil];

    GADBannerView *bannerView = [[GADBannerView alloc] initWithAdSize:kGADAdSizeBanner];
    bannerView.adUnitID = @"ca-app-pub-3940256099942544/2934735716";
    bannerView.rootViewController = (id)self;
    bannerView.delegate = (id<GADBannerViewDelegate>)self;
    bannerView.frame = CGRectMake(0, ScreenHeight - STHeight(48), ScreenWidth , STHeight(48));
    [bannerView loadRequest:request];
    
    [sender.view addSubview:bannerView];
}
@end
