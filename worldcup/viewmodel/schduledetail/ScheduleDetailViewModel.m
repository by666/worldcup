//
//  ScheduleDetailViewModel.m
//  worldcup
//
//  Created by by.huang on 2018/6/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleDetailViewModel.h"
#import "STNetUtil.h"
@implementation ScheduleDetailViewModel

-(instancetype)initWithData:(ScheduleModel *)model{
    if(self == [super init]){
        self.model = model;
    }
    return self;
}

-(void)requestDatas{
    if(_delegate){
        WS(weakSelf)
        [STNetUtil get:[NSString stringWithFormat:@"%@%@",ScheduleDetailUrl,_model.match_id] parameters:nil success:^(id respondObj) {
            ScheduleRespondModel *respondModel = [ScheduleRespondModel mj_objectWithKeyValues:respondObj];
            NSMutableArray *originDatas = [ScheduleModel mj_objectArrayWithKeyValuesArray:respondModel.list];
            NSInteger total = [originDatas count];
            weakSelf.datas = [self sortDatas:originDatas];
            weakSelf.height = [self countTableViewHeight:total];
            if(weakSelf.delegate){
                [weakSelf.delegate onRequestCallback:YES errorMsg:MSG_SUCCESS];
            }
        } failure:^(NSError *error) {
            if(weakSelf.delegate){
                [weakSelf.delegate onRequestCallback:NO errorMsg:MSG_ERROR];
            }
        }];
        [_delegate onRequestDatas:YES];
    }
}

@end
