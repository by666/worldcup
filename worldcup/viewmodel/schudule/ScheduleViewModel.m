//
//  ScheduleViewModel.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleViewModel.h"
#import "STNetUtil.h"
#import "ScheduleModel.h"
#import "ScheduleRespondModel.h"
#import "ScheduleViewCell.h"
#import "STTimeUtil.h"
@interface ScheduleViewModel()


@end

@implementation ScheduleViewModel{
    NSInteger groupCount;
}

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        
    }
    return self;
}


#pragma mark 请求
-(void)requestNew{
    WS(weakSelf)
    [STNetUtil get:ScheduleUrl parameters:nil success:^(id respondObj) {
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
}

-(void)requestMore{
    
}



#pragma mark 分组排序
-(NSMutableArray *)sortDatas:(NSMutableArray *)originDatas{
    if(IS_NS_COLLECTION_EMPTY(originDatas)){
        return originDatas;
    }
    
    NSMutableArray *resultDatas = [[NSMutableArray alloc]init];
    @synchronized(self){
        NSMutableArray *datas = [[NSMutableArray alloc]init];
        
        for(ScheduleModel *model in originDatas){
            [datas addObject:[self formatTime:model]];
        }
        
        NSMutableSet *set = [NSMutableSet set];
        //日期去重
        [datas enumerateObjectsUsingBlock:^(ScheduleModel * _Nonnull model, NSUInteger idx, BOOL * _Nonnull stop) {
            [set addObject:model.date_utc];
        }];
        
        //分组筛选
        __block NSMutableArray *groupArr = [NSMutableArray array];
        [set enumerateObjectsUsingBlock:^(NSString * _Nonnull date_utc, BOOL * _Nonnull stop) {
            NSPredicate *predicate = [NSPredicate predicateWithFormat:@"date_utc = %@", date_utc];
            NSArray *tempArr = [NSArray arrayWithArray:[datas filteredArrayUsingPredicate:predicate]];
            [groupArr addObject:tempArr];
        }];
        
        //排序
        [groupArr sortUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
            NSArray *array1 = obj1;
            ScheduleModel *model1 = array1[0];
            NSArray *array2 = obj2;
            ScheduleModel *model2 = array2[0];
            if ([model1.date_utc compare: model2.date_utc] == NSOrderedDescending) {
                return NSOrderedDescending;
            }else if ([model1.date_utc compare: model2.date_utc] == NSOrderedAscending) {
                return NSOrderedAscending;
            }
            else {
                return NSOrderedSame;
            }
        }];
        
        groupCount = [groupArr count];
        //
        for(NSArray *array in groupArr){
            [resultDatas addObject:[self generateTitleData:array]];
            for(int i = 0 ; i < [array count] ; i ++){
                ScheduleModel *model = [array objectAtIndex:i];
                if(i + 1 == [array count]){
                    model.hasLine = NO;
                }else{
                    model.hasLine = YES;
                }
                [resultDatas addObject:model];
            }
        }
    }
    return resultDatas;
}


-(ScheduleModel *)generateTitleData:(NSArray *)array{
    ScheduleModel *temp = [array objectAtIndex:0];
    ScheduleModel *model = [[ScheduleModel alloc]init];
    model.isTitle = YES;
    model.date_utc = temp.date_utc;
    return model;
}

-(ScheduleModel *)formatTime:(ScheduleModel *)model{
    NSString *dateStr = model.date_utc;
    NSString *timeStr = model.time_utc;
    NSString *tempStr = [NSString stringWithFormat:@"%@ %@",dateStr,timeStr];
    
    
    NSTimeZone* zone = [NSTimeZone timeZoneForSecondsFromGMT:0];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    [dateFormatter setTimeZone:zone];
    NSDate *date = [dateFormatter dateFromString:tempStr];
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd HH:mm:ss"];
    NSString *currentDateStr = [formatter stringFromDate:date];
    
    model.date_utc = [currentDateStr substringWithRange:NSMakeRange(0, 10)];
    model.time_utc = [currentDateStr substringWithRange:NSMakeRange(11, 8)];
    return model;
}

#pragma mark 计算tableview高度
-(CGFloat)countTableViewHeight:(NSInteger)total{
    CGFloat height = groupCount * TITLE_HEIGHT;
    height = height + (total * CONTENT_HEIGHT);
    return height;
}


-(void)goScheduleDetailPage:(ScheduleModel *)model{
    if(_delegate){
        [_delegate onGoScheduleDetailPage:model];
    }
}






@end
