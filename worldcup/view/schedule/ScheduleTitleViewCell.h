//
//  ScheduleTitleViewCell.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/6.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleModel.h"

@interface ScheduleTitleViewCell : UITableViewCell

-(void)updateData:(ScheduleModel *)model;
+(NSString *)identify;

@end
