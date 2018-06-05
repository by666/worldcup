//
//  ScheduleDetailPage.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailPage.h"

@interface ScheduleDetailPage ()

@property(strong, nonatomic)ScheduleModel *mData;

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
    [self showSTNavigationBar:@"" needback:YES];
    [self initView];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [self setStatuBarBackgroud:c02];
    
    UILabel *label = [[UILabel alloc]initWithFont:STFont(18) text:_mData.time_utc textAlignment:NSTextAlignmentCenter textColor:c02 backgroundColor:nil multiLine:NO];
    label.frame = CGRectMake(0, STHeight(200), ScreenWidth, STHeight(18));
    [self.view addSubview:label];
}


-(void)initView{
    
}


@end
