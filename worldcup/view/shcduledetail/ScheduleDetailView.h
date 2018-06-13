//
//  ScheduleDetailView.h
//  worldcup
//
//  Created by by.huang on 2018/6/10.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ScheduleDetailViewModel.h"
@interface ScheduleDetailView : UIView

-(instancetype)initWithViewModel:(ScheduleDetailViewModel *)viewModel;
-(void)updateView;
@end
