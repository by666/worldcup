//
//  UITextField+Init.m
//  framework
//
//  Created by 黄成实 on 2018/5/9.
//  Copyright © 2018年 黄成实. All rights reserved.
//

#import "UITextField+Init.h"
#import <objc/runtime.h>

static char *hasValueChar = "hasValue";

@implementation UITextField(Init)

-(instancetype)initWithFont:(CGFloat)fontSize textColor:(UIColor *)textColor backgroundColor:(UIColor *)backgroundColor corner:(CGFloat)corner borderWidth:(CGFloat)borderWidth borderColor:(UIColor *)borderColor padding:(CGFloat)padding{
    if(self == [super init]){
        if(textColor != nil){
            self.textColor = textColor;
        }
        if(backgroundColor != nil){
            self.backgroundColor = backgroundColor;
        }
        if(borderColor != nil){
            self.layer.borderColor = [borderColor CGColor];
        }
        self.font = [UIFont systemFontOfSize:fontSize];
        self.layer.masksToBounds = YES;
        self.layer.cornerRadius = corner;
        self.layer.borderWidth = borderWidth;
        
        UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, padding, 0)];
        leftView.backgroundColor = backgroundColor;
        self.leftView = leftView;
        self.leftViewMode = UITextFieldViewModeAlways;
    }
    return self;
}


-(void)setHasValue:(NSString *)hasValue{
    objc_setAssociatedObject(self, &hasValueChar, hasValue, OBJC_ASSOCIATION_COPY_NONATOMIC);
}

-(NSString *)hasValue{
    return objc_getAssociatedObject(self, &hasValueChar);

}


-(void)setPlaceholder:(NSString *)placeholder color:(UIColor *)color fontSize:(CGFloat)fontSize{
    NSAttributedString *placeholderStr = [[NSAttributedString alloc] initWithString:placeholder attributes:
                                         @{NSForegroundColorAttributeName:color,
                                           NSFontAttributeName:[UIFont systemFontOfSize:fontSize]
                                           }];
    self.attributedPlaceholder = placeholderStr;
}


@end
