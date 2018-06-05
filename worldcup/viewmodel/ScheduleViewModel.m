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
@interface ScheduleViewModel()


@end

@implementation ScheduleViewModel{
    NSInteger index;
}

-(instancetype)init{
    if(self == [super init]){
        _datas = [[NSMutableArray alloc]init];
        _sortDatas = [[NSMutableArray alloc]init];
    }
    return self;
}


#pragma mark 请求
-(void)requestNew{
    WS(weakSelf)
    [STNetUtil get:ScheduleUrl parameters:nil success:^(id respondObj) {
        ScheduleRespondModel *respondModel = [ScheduleRespondModel mj_objectWithKeyValues:respondObj];
        weakSelf.datas = [ScheduleModel mj_objectArrayWithKeyValuesArray:respondModel.list];
        NSInteger total = [weakSelf.datas count];
        weakSelf.sortDatas = [self sortDatas];
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
-(NSMutableArray *)sortDatas{
    if(IS_NS_COLLECTION_EMPTY(_datas)){
        return _sortDatas;
    }
    NSMutableArray *datas = _datas;
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
    return groupArr;
}


#pragma mark 计算tableview高度
-(CGFloat)countTableViewHeight:(NSInteger)total{
    CGFloat height = [_sortDatas count] * TITLE_HEIGHT;
    height = height + (total * CONTENT_HEIGHT);
    return height;
}


-(void)goScheduleDetailPage:(NSInteger)index row:(NSInteger)row{
    if(_delegate){
        if(!IS_NS_COLLECTION_EMPTY(_sortDatas)){
            NSArray *array = [_sortDatas objectAtIndex:index];
            ScheduleModel *model = [array objectAtIndex:row];
            [_delegate onGoScheduleDetailPage:model];
        }
    }
}






@end
