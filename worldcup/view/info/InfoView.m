//
//  InfoView.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "InfoView.h"

@interface InfoView()


@end

@implementation InfoView

-(instancetype)init{
    if(self == [super init]){
        [self initView];
    }
    return self;
}


-(void)initView{
    self.backgroundColor = cwhite;
}

@end
