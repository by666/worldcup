//
//  ScheduleRespondModel.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleRespondModel : NSObject

@property(strong, nonatomic)NSMutableArray *list;
@property(copy, nonatomic)NSString *prevDate;
@property(copy, nonatomic)NSString *nextDate;
@property(assign, nonatomic)BOOL finishFlag;

@end
