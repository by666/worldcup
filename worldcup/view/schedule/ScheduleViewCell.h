//
//  ScheduleViewCell.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewModel.h"

#define TITLE_HEIGHT STHeight(30)
#define CONTENT_HEIGHT STHeight(120)


@interface ScheduleViewCell : UITableViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier viewModel:(ScheduleViewModel *)viewModel;
-(void)updateData:(NSArray *)datas row:(NSInteger)row;
+(NSString *)identify;

@end
