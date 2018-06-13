//
//  ScheduleDetailViewModel.h
//  worldcup
//
//  Created by by.huang on 2018/6/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleViewModel.h"

@protocol ScheduleDetailViewDelegate

-(void)onInitAdMob;
-(void)onRequestDatas:(Boolean)success;

@end

@interface ScheduleDetailViewModel : NSObject
@property(weak, nonatomic)id <ScheduleDetailViewDelegate> delegate;
@property(strong, nonatomic)ScheduleModel *model;
@property(strong, nonatomic)NSMutableArray *aTeamDatas;
@property(strong, nonatomic)NSMutableArray *bTeamDatas;

-(instancetype)initWithData:(ScheduleModel *)model;
-(void)requestDatas;
-(void)initAdMob;
@end
