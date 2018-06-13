//
//  InfoDetailPage.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "InfoDetailPage.h"
@interface InfoDetailPage ()

@end

@implementation InfoDetailPage

+(void)show:(BaseViewController *)controller{
    InfoDetailPage *page = [[InfoDetailPage alloc]init];
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
}


-(void)initView{
    
}


@end
