//
//  MainView.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/4.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "MainView.h"
#import "STTabBarView.h"
#import "InfoView.h"
#import "ScheduleView.h"

@interface MainView()<UIScrollViewDelegate,GADBannerViewDelegate>

@property(strong, nonatomic)MainViewModel *mViewModel;
@property(strong, nonatomic)STTabBarView *tabBarView;
@property(strong, nonatomic)UIScrollView *scrollView;
@property(strong, nonatomic)ScheduleViewModel *mScheduleViewModel;
@property(strong, nonatomic)ScheduleView *scheduleView;
@property(strong, nonatomic)InfoView *infoView;

@end

@implementation MainView{
    NSInteger mIndex;
}

-(instancetype)initWithViewModel:(MainViewModel *)viewModel scheduleViewModel:(ScheduleViewModel *)scheduleViewModel{
    if(self == [super init]){
        _mViewModel = viewModel;
        _mScheduleViewModel = scheduleViewModel;
        mIndex = 0;
        [self initView];
    }
    return self;
}

-(void)initView{
//    NSArray *titles = @[MSG_INFO_TITLE,MSG_SCHEDULE_TITLE];
    NSArray *titles = @[MSG_SCHEDULE_TITLE];
    NSArray *images = @[@"ic_info_normal",@"ic_info_select",@"ic_schedule_normal",@"ic_schedule_select"];
    _tabBarView = [[STTabBarView alloc]initWithTitles:titles images:images];
    _tabBarView.hidden = YES;
    [_tabBarView setData:c05 SelectColor:c04 Font:[UIFont systemFontOfSize:STFont(14)]];
    [self addSubview:_tabBarView];
    
    WS(weakSelf)
    [_tabBarView getViewIndex:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setIndexBlock:^(NSString *title, NSInteger index) {
        [UIView animateWithDuration:0.3 animations:^{
            weakSelf.scrollView.contentOffset = CGPointMake(index * ScreenWidth, 0);
        }];
    }];
    
    [_tabBarView setViewIndex:mIndex];
    
    _scrollView = [[UIScrollView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48))];
    _scrollView.delegate = self;
    _scrollView.pagingEnabled = YES;
    _scrollView.bounces = NO;
    _scrollView.showsHorizontalScrollIndicator = NO;
    _scrollView.showsVerticalScrollIndicator = NO;
    _scrollView.contentSize = CGSizeMake([titles count]*ScreenWidth, 0);
    [self addSubview:_scrollView];
    
//    _infoView = [[InfoView alloc]init];
//    _infoView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48));
//    [_scrollView addSubview:_infoView];
    
    _scheduleView = [[ScheduleView alloc]initWithViewModel:_mScheduleViewModel];
    _scheduleView.frame = CGRectMake(0, 0, ScreenWidth, ContentHeight - STHeight(48));
    [_scrollView addSubview:_scheduleView];
    
    
}



- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    NSInteger index = scrollView.contentOffset.x / ScreenWidth;
    [_tabBarView setViewIndex:index];
    if(_mViewModel){
        [_mViewModel changeTab:index];
    }
}


-(void)updateScheduleView{
    if(_scheduleView){
        [_scheduleView updateView];
    }
}



//admob callback
/// Tells the delegate an ad request loaded an ad.
- (void)adViewDidReceiveAd:(GADBannerView *)adView {
    NSLog(@"adViewDidReceiveAd");
}

/// Tells the delegate an ad request failed.
- (void)adView:(GADBannerView *)adView
didFailToReceiveAdWithError:(GADRequestError *)error {
    NSLog(@"adView:didFailToReceiveAdWithError: %@", [error localizedDescription]);
}

/// Tells the delegate that a full-screen view will be presented in response
/// to the user clicking on an ad.
- (void)adViewWillPresentScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillPresentScreen");
}

/// Tells the delegate that the full-screen view will be dismissed.
- (void)adViewWillDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewWillDismissScreen");
}

/// Tells the delegate that the full-screen view has been dismissed.
- (void)adViewDidDismissScreen:(GADBannerView *)adView {
    NSLog(@"adViewDidDismissScreen");
}

/// Tells the delegate that a user click will open another app (such as
/// the App Store), backgrounding the current app.
- (void)adViewWillLeaveApplication:(GADBannerView *)adView {
    NSLog(@"adViewWillLeaveApplication");
}
@end
