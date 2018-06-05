//
//  ScheduleModel.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ScheduleModel : NSObject

@property(copy, nonatomic)NSString *relate_type;
@property(copy, nonatomic)NSString *relate_id;
@property(copy, nonatomic)NSString *match_id;
@property(copy, nonatomic)NSString *team_A_id;
@property(copy, nonatomic)NSString *team_A_name;
@property(copy, nonatomic)NSString *team_A_logo;
@property(copy, nonatomic)NSString *team_B_id;
@property(copy, nonatomic)NSString *team_B_name;
@property(copy, nonatomic)NSString *team_B_logo;
@property(copy, nonatomic)NSString *date_utc;
@property(copy, nonatomic)NSString *time_utc;
@property(copy, nonatomic)NSString *start_play;
@property(assign, nonatomic)long sort_timestamp;
@property(copy, nonatomic)NSString *status;
@property(copy, nonatomic)NSString *fs_A;
@property(copy, nonatomic)NSString *fs_B;
@property(copy, nonatomic)NSString *ps_A;
@property(copy, nonatomic)NSString *ps_B;
@property(copy, nonatomic)NSString *ets_A;
@property(copy, nonatomic)NSString *ets_B;
@property(copy, nonatomic)NSString *ags_A;
@property(copy, nonatomic)NSString *ags_B;
@property(copy, nonatomic)NSString *gameweek;
@property(copy, nonatomic)NSString *suretime;
@property(copy, nonatomic)NSString *playing_time;
@property(copy, nonatomic)NSString *minute;
@property(copy, nonatomic)NSString *minute_extra;
@property(copy, nonatomic)NSString *minute_period;
@property(copy, nonatomic)NSString *competition_id;
@property(copy, nonatomic)NSString *competition_name;
@property(copy, nonatomic)NSString *round_name;
@property(assign, nonatomic)BOOL area_shield;
@property(copy, nonatomic)NSString *TVList;
@property(assign, nonatomic)BOOL videoFlag;
@property(assign, nonatomic)BOOL webLivingFlag;
@property(assign, nonatomic)BOOL onlySem;
@property(copy, nonatomic)NSString *match_title;
@property(copy, nonatomic)NSString *score_info;
@property(copy, nonatomic)NSString *as_A;
@property(copy, nonatomic)NSString *as_B;
@property(assign, nonatomic)long intermission;


@end
