# Bezier
通过学习，对贝塞尔曲线有基本的认识
贝塞尔曲线添加数据时一般分为两大步骤：
一、添加拐点图层：
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

二、添加贝塞尔曲线的图层:

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


