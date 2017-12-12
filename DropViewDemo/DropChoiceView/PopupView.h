//
//  PopupView.h
//  PopupView
//
//  Created by Zhao Fei on 2016/10/12.
//  Copyright © 2016年 ZhaoFei. All rights reserved.
//
typedef enum {
    ShowLeft = 0,
    ShowRight = 1,
    FreeDomPosition
}HGGPopViewShowPosition;


#import <UIKit/UIKit.h>

@interface PopupView : UIView




+ (void)addCellWithIcon:(UIImage *)icon text:(NSString *)text action: (void (^) ())action;
+ (void)popupViewInPosition:(HGGPopViewShowPosition)position;
+ (void)popupViewInButton:(UIButton *)button;
@end
