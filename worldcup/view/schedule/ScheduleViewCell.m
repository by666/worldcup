//
//  ScheduleViewCell.m
//  worldcup
//
//  Created by 黄成实 on 2018/6/5.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "ScheduleViewCell.h"
#import "UIImageView+WebCache.h"
@interface ScheduleViewCell()

@property(strong, nonatomic)UILabel *dateLabel;
@property(strong, nonatomic)ScheduleViewModel *mViewModel;

@end

@implementation ScheduleViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier viewModel:(ScheduleViewModel *)viewModel{
    if(self == [super initWithStyle:style reuseIdentifier:reuseIdentifier]){
        _mViewModel = viewModel;
        [self initView];
    }
    return self;
}

-(void)initView{
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, ScreenWidth, TITLE_HEIGHT)];
    topView.backgroundColor = c02;
    [self.contentView addSubview:topView];
    
    _dateLabel = [[UILabel alloc]initWithFont:STFont(14) text:@"" textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    [topView addSubview:_dateLabel];
    
}


-(void)updateData:(NSArray *)datas row:(NSInteger)row{
    ScheduleModel *model = [datas objectAtIndex:0];
    _dateLabel.text = model.date_utc;
    CGSize timeSize = [_dateLabel.text sizeWithMaxWidth:ScreenWidth font:[UIFont systemFontOfSize:STFont(14)]];
    _dateLabel.frame = CGRectMake(STWidth(15), 0, timeSize.width, TITLE_HEIGHT);
    
    @synchronized(self){
        for(int i = 0; i < [datas count]; i ++){
            ScheduleModel *model = [datas objectAtIndex:i];
            UIButton *button = [[UIButton alloc]initWithFrame:CGRectMake(0, TITLE_HEIGHT + i * CONTENT_HEIGHT, ScreenWidth, CONTENT_HEIGHT)];
            button.backgroundColor = cwhite;
            button.tag = row;
            button.tag2 = [NSString stringWithFormat:@"%d",i];
            [button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];
            [self.contentView addSubview:button];
            
            if(i + 1  < [datas count]){
                UIView *lineView = [[UIView alloc]initWithFrame:CGRectMake(0, (i+1) * CONTENT_HEIGHT + TITLE_HEIGHT-LineHeight, ScreenWidth, LineHeight)];
                lineView.backgroundColor = c07;
                [self.contentView addSubview:lineView];
            }
            
            [self fillInBtn:button model:model];
        }
    }
}



-(void)fillInBtn:(UIButton *)button model:(ScheduleModel *)model{
    UILabel *timeLabel = [[UILabel alloc]initWithFont:STFont(14) text:[model.time_utc substringWithRange:NSMakeRange(0, 5)] textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    timeLabel.frame = CGRectMake(0, STHeight(20), ScreenWidth, STHeight(14));
    [button addSubview:timeLabel];
    
    UILabel *vsLabel = [[UILabel alloc]initWithFont:STFont(26) text:@"VS" textAlignment:NSTextAlignmentCenter textColor:cblack backgroundColor:nil multiLine:NO];
    vsLabel.frame = CGRectMake(0, STHeight(47), ScreenWidth, STHeight(26));
    [button addSubview:vsLabel];
    
    UILabel *statuLabel = [[UILabel alloc]initWithFont:STFont(12) text:model.TVList textAlignment:NSTextAlignmentCenter textColor:c07 backgroundColor:nil multiLine:NO];
    statuLabel.frame = CGRectMake(0, STHeight(85), ScreenWidth, STHeight(12));
    [button addSubview:statuLabel];
    
    
    CGFloat imageWidth = STHeight(40);
    UIImageView *aImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth / 2 - imageWidth ) /2, STHeight(30), imageWidth, imageWidth)];
    aImageView.contentMode = UIViewContentModeScaleAspectFill;
    [aImageView sd_setImageWithURL:[NSURL URLWithString:model.team_A_logo]];
    [button addSubview:aImageView];
    
    UIImageView *bImageView = [[UIImageView alloc]initWithFrame:CGRectMake((ScreenWidth / 2 - imageWidth ) /2 + ScreenWidth / 2, STHeight(30), imageWidth, imageWidth)];
    bImageView.contentMode = UIViewContentModeScaleAspectFill;
    [bImageView sd_setImageWithURL:[NSURL URLWithString:model.team_B_logo]];
    [button addSubview:bImageView];
    
    
    UILabel *aNameLabel = [[UILabel alloc]initWithFont:STFont(14) text:model.team_A_name textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    aNameLabel.textAlignment = NSTextAlignmentCenter;
    aNameLabel.frame = CGRectMake(0, STHeight(80), ScreenWidth/2, STHeight(14));
    [button addSubview:aNameLabel];
    
    UILabel *bNameLabel = [[UILabel alloc]initWithFont:STFont(14) text:model.team_B_name textAlignment:NSTextAlignmentCenter textColor:c06 backgroundColor:nil multiLine:NO];
    bNameLabel.textAlignment = NSTextAlignmentCenter;
    bNameLabel.frame = CGRectMake(ScreenWidth/2, STHeight(80), ScreenWidth/2, STHeight(14));
    [button addSubview:bNameLabel];

}

-(void)onClick:(id)sender{
    UIButton *button = sender;
    [STLog print:[NSString stringWithFormat:@"第%ld组数据",button.tag] content:[NSString stringWithFormat:@"第%@个",button.tag2]];
    if(_mViewModel){
        [_mViewModel goScheduleDetailPage:button.tag row:[button.tag2 integerValue]];
    }
}

+(NSString *)identify{
    return NSStringFromClass([ScheduleViewCell class]);
}

@end
