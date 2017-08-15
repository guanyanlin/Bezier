//
//  BaseBezierView.h
//  Bezier
//
//  Created by yanglong on 2017/8/14.
//  Copyright © 2017年 yanglong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LineEntry.h"

#define MARGIN 30
#define Y_EVERY_MARGIN 20.0

@interface BaseBezierView : UIView<UIGestureRecognizerDelegate>
@property(nonatomic, assign) NSInteger viewType;//1:实心图形；2：空心图形
@property (nonatomic, strong) NSMutableArray<LineEntry *> *lineEntryArray;
@property (nonatomic, strong) NSMutableArray *xNamesArray;
@end
