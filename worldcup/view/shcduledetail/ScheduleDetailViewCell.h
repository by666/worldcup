//
//  ScheduleDetailViewCell.h
//  worldcup
//
//  Created by by.huang on 2018/6/11.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDetailModel.h"

@interface ScheduleDetailViewCell : UITableViewCell

-(void)updateData:(ScheduleDetailModel *)model;
+(NSString *)identify;

@end
