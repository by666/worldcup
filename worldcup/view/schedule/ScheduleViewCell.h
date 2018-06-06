//
//  ScheduleViewCell.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewModel.h"




@interface ScheduleViewCell : UITableViewCell

-(void)updateData:(ScheduleModel *)model;
+(NSString *)identify;

@end
