//
//  ScheduleDetailViewModel.m
//  worldcup
//
//  Created by by.huang on 2018/6/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailViewModel.h"
#import "STNetUtil.h"
#import "ScheduleDetailResondModel.h"
#import "ScheduleDetailModel.h"
@implementation ScheduleDetailViewModel

-(instancetype)initWithData:(ScheduleModel *)model{
    if(self == [super init]){
        self.model = model;
        [STLog print:model.match_id];
    }
    return self;
}

-(void)requestDatas{
    if(_delegate){
        WS(weakSelf)
        [STNetUtil get:[NSString stringWithFormat:@"%@%@",ScheduleDetailUrl,_model.match_id] parameters:nil success:^(id respondObj) {
            NSError *error;
            NSDictionary *dic = [NSJSONSerialization JSONObjectWithData:respondObj options:NSJSONReadingMutableContainers error:&error];
            NSDictionary *infoDic = [dic objectForKey:@"info"];
            NSDictionary *recordDic = [infoDic objectForKey:@"recent_record"];
            weakSelf.aTeamDatas = [ScheduleDetailModel mj_objectArrayWithKeyValuesArray:[recordDic objectForKey:@"team_A"]];
            weakSelf.bTeamDatas = [ScheduleDetailModel mj_objectArrayWithKeyValuesArray:[recordDic objectForKey:@"team_B"]];
            if(weakSelf.delegate){
                [weakSelf.delegate onRequestDatas:YES];
            }
        } failure:^(NSError *error) {
            if(weakSelf.delegate){
                [weakSelf.delegate onRequestDatas:NO];
            }
        }];
        [_delegate onRequestDatas:YES];
    }
}

-(void)initAdMob{
    if(_delegate){
        [_delegate onInitAdMob];
    }
}

@end
