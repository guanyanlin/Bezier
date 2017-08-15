//
//  BaseBezierView.m
//  Bezier
//
//  Created by yanglong on 2017/8/14.
//  Copyright © 2017年 yanglong. All rights reserved.
//

#import "BaseBezierView.h"

@implementation BaseBezierView
- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        UIView *content = [[UIView alloc]init];
        content.frame = self.frame;
        content.backgroundColor = [UIColor purpleColor];
        UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTapBar:)];
        tapGesture.delegate = self;
        [content addGestureRecognizer:tapGesture];
        [self addSubview:content];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    [self drawXYLine:_xNamesArray];
    if(_viewType==1){
        [self drawCurve];
    }else if(_viewType==2){
        [self drawBar];
    }else if(_viewType==3){
        [self drawPie];
    }
    
}

- (void)drawPie {

    //设置圆点
    CGPoint point = CGPointMake(self.frame.size.width/2,self.frame.size.height/2);
    CGFloat startAngle = 0;
    CGFloat endAngle ;
    CGFloat radius = 100;
    
    //计算总数
    __block CGFloat allValue = 0;
    [_lineEntryArray enumerateObjectsUsingBlock:^(LineEntry * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        allValue += _lineEntryArray[idx].yVal;
    }];
    
    //画图
    for (int i =0; i<_lineEntryArray.count; i++) {
        
        CGFloat targetValue = _lineEntryArray[i].yVal;
        endAngle = startAngle + targetValue/allValue*2*M_PI;
        
        //bezierPath形成闭合的扇形路径
        UIBezierPath *bezierPath = [UIBezierPath bezierPathWithArcCenter:point
                                                                  radius:radius
                                                              startAngle:startAngle                                                                 endAngle:endAngle
                                                               clockwise:YES];
        [bezierPath addLineToPoint:point];
        [bezierPath closePath];
        
        
        //添加文字
        CGFloat X = point.x + 120*cos(startAngle+(endAngle-startAngle)/2) - 10;
        CGFloat Y = point.y + 110*sin(startAngle+(endAngle-startAngle)/2) - 10;
        UILabel *label = [[UILabel alloc]initWithFrame:CGRectMake(X, Y, 30, 20)];
        label.text = _xNamesArray[i];
        label.font = [UIFont systemFontOfSize:11];
        label.textColor = [UIColor blackColor];
        [self.subviews[0] addSubview:label];
        
        
        //渲染
        CAShapeLayer *shapeLayer=[CAShapeLayer layer];
        shapeLayer.lineWidth = 2.0;
        shapeLayer.fillColor = [UIColor purpleColor].CGColor;
        shapeLayer.path = bezierPath.CGPath;
        [self.layer addSublayer:shapeLayer];
        
        startAngle = endAngle;
    }

}
- (void)drawBar {
    [[UIColor orangeColor] set];
    //2.每一个目标值点坐标
    for (int i=0; i<_lineEntryArray.count; i++) {
        CGFloat doubleValue = 2*_lineEntryArray[i].yVal; //目标值放大两倍
        CGFloat X = MARGIN + MARGIN*(i+1)+5;
        CGFloat Y = CGRectGetHeight(self.frame)-MARGIN-doubleValue;
        
        UIBezierPath *path = [UIBezierPath bezierPathWithRect:CGRectMake(X-MARGIN/2, Y, MARGIN-10, doubleValue)];
        CAShapeLayer *shapeLayer = [CAShapeLayer layer];
        shapeLayer.path = path.CGPath;
        shapeLayer.strokeColor = [UIColor clearColor].CGColor;
        shapeLayer.fillColor = [UIColor greenColor].CGColor;
        shapeLayer.borderWidth = 2.0;
        [self.subviews[0].layer addSublayer:shapeLayer];
        
        //3.添加文字
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(X-MARGIN/2, Y-20, MARGIN-10, 20)];
        label.text = [NSString stringWithFormat:@"%.0lf",_lineEntryArray[i].yVal];
        label.textColor = [UIColor purpleColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:10];
        [self.subviews[0] addSubview:label];
    }
   

}
-(void)onTapBar:(UIGestureRecognizer *)sender {
    NSLog(@"dddd");
}
- (void)drawCurve {
    UIColor *curColor = [UIColor blueColor];
    [curColor set];
    
    NSMutableArray *allPoints = [NSMutableArray array];
    for (int i=0; i<_lineEntryArray.count; i++) {
        CGFloat doubleValue = 2*_lineEntryArray[i].yVal; //目标值放大两倍
        CGFloat X = MARGIN + MARGIN*(i+1);
        CGFloat Y = CGRectGetHeight(self.frame)-MARGIN-doubleValue;
        CGPoint point = CGPointMake(X,Y);
        UIBezierPath *path1 = [UIBezierPath bezierPathWithRoundedRect:CGRectMake(point.x-1, point.y-1, 2.5, 2.5) cornerRadius:2.5];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.strokeColor = [UIColor purpleColor].CGColor;
        layer.fillColor = [UIColor purpleColor].CGColor;
        layer.path = path1.CGPath;
        
        [self.subviews[0].layer addSublayer:layer];
        
        [allPoints addObject:[NSValue valueWithCGPoint:point]];
    }
    
    //3.坐标连线
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:[allPoints[0] CGPointValue]];
    CGPoint PrePonit;
    //曲线
    for (int i =0; i<allPoints.count; i++) {
        if (i==0) {
            PrePonit = [allPoints[0] CGPointValue];
        }else{
            CGPoint NowPoint = [allPoints[i] CGPointValue];
            [path addCurveToPoint:NowPoint controlPoint1:CGPointMake((PrePonit.x+NowPoint.x)/2, PrePonit.y) controlPoint2:CGPointMake((PrePonit.x+NowPoint.x)/2, NowPoint.y)]; //三次曲线
            PrePonit = NowPoint;
        }
    }
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor greenColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];

}
/**
 *  画坐标轴
 */
-(void)drawXYLine:(NSMutableArray *)x_names{
    UIColor *color = [UIColor grayColor];
    [color set];
    
    UIBezierPath *path = [UIBezierPath bezierPath];
    
    path.lineWidth = 2.0;
    
    //1.Y轴、X轴的直线
    [path moveToPoint:CGPointMake(MARGIN, CGRectGetHeight(self.frame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN, MARGIN)];
    
    [path moveToPoint:CGPointMake(MARGIN, CGRectGetHeight(self.frame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(self.frame)-2*MARGIN, CGRectGetHeight(self.frame)-MARGIN)];
    
    //2.添加箭头
    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN-5, MARGIN+5)];
    [path moveToPoint:CGPointMake(MARGIN, MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+5, MARGIN+5)];
    
    [path moveToPoint:CGPointMake(MARGIN+CGRectGetWidth(self.frame)-2*MARGIN, CGRectGetHeight(self.frame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(self.frame)-2*MARGIN-5, CGRectGetHeight(self.frame)-MARGIN-5)];
    [path moveToPoint:CGPointMake(MARGIN+CGRectGetWidth(self.frame)-2*MARGIN, CGRectGetHeight(self.frame)-MARGIN)];
    [path addLineToPoint:CGPointMake(MARGIN+CGRectGetWidth(self.frame)-2*MARGIN-5, CGRectGetHeight(self.frame)-MARGIN+5)];
    
    //3.添加索引格
    //X轴
    for (int i=0; i<x_names.count; i++) {
        CGFloat X = MARGIN + MARGIN*(i+1);
        CGPoint point = CGPointMake(X,CGRectGetHeight(self.frame)-MARGIN);
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x, point.y-3)];
    }
    //Y轴（实际长度为200,此处比例缩小一倍使用）
    for (int i=0; i<11; i++) {
        CGFloat Y = CGRectGetHeight(self.frame)-MARGIN-Y_EVERY_MARGIN*i;
        CGPoint point = CGPointMake(MARGIN,Y);
        [path moveToPoint:point];
        [path addLineToPoint:CGPointMake(point.x+3, point.y)];
    }
    
    //4.添加索引格文字
    //X轴
    for (int i=0; i<x_names.count; i++) {
        CGFloat X = MARGIN + 15 + MARGIN*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(X, CGRectGetHeight(self.frame)-MARGIN, MARGIN, 20)];
        textLabel.text = x_names[i];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor blueColor];
        [self addSubview:textLabel];
    }
    //Y轴
    for (int i=0; i<11; i++) {
        CGFloat Y = CGRectGetHeight(self.frame)-MARGIN-Y_EVERY_MARGIN*i;
        UILabel *textLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, Y-5, MARGIN, 10)];
        textLabel.text = [NSString stringWithFormat:@"%d",10*i];
        textLabel.font = [UIFont systemFontOfSize:10];
        textLabel.textAlignment = NSTextAlignmentCenter;
        textLabel.textColor = [UIColor redColor];
        [self addSubview:textLabel];
    }
    
    //5.渲染路径
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.path = path.CGPath;
    shapeLayer.strokeColor = [UIColor blackColor].CGColor;
    shapeLayer.fillColor = [UIColor clearColor].CGColor;
    shapeLayer.borderWidth = 2.0;
    [self.subviews[0].layer addSublayer:shapeLayer];
    [path stroke];
}
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldReceiveTouch:(UITouch *)touch {

    return true;
}
- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer {

    return true;
}

@end
