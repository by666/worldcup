//
//  ScheduleView.h
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleViewModel.h"
@interface ScheduleView : UIView

-(instancetype)initWithViewModel:(ScheduleViewModel *)viewModel;
-(void)updateView;

@end
