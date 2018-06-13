//
//  ScheduleDetailModel.h
//  worldcup
//
//  Created by by.huang on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleDetailModel : NSObject

@property(strong, nonatomic)NSString *competition;
@property(strong, nonatomic)NSString *date;
@property(strong, nonatomic)NSString *team_A_name;
@property(strong, nonatomic)NSString *team_B_name;
@property(strong, nonatomic)NSString *score;

@end
