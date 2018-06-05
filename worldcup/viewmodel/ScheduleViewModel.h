//
//  ScheduleViewModel.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ScheduleModel.h"

@protocol ScheduleViewModelDelegate

-(void)onRequestCallback:(Boolean)success errorMsg:(NSString *)errorMsg;
-(void)onGoScheduleDetailPage:(ScheduleModel *)model;

@end

@interface ScheduleViewModel : NSObject
@property(weak, nonatomic)id<ScheduleViewModelDelegate> delegate;
@property(strong, nonatomic)NSMutableArray *datas;
@property(strong, nonatomic)NSMutableArray *sortDatas;
@property(assign, nonatomic)CGFloat height;

-(void)requestNew;
-(void)requestMore;
-(void)goScheduleDetailPage:(NSInteger)index row:(NSInteger)row;


@end
