//
//  JianLeKeBaiCaiMainView.m
//  QingKu
//
//  Created by mdb-losaic on 2019/7/25.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import "JianLeKeBaiCaiMainView.h"

#import "JianLeKeBaiCaiMainScrollView.h"

#import "LJDynamicItem.h"

#define maxOffsetY kMainScreenW*1.2
#define tabviewHeight kMainScreenH-kTopHeight-kTabBarHeight


static CGFloat rubberBandDistance(CGFloat offset, CGFloat dimension) {
    
    const CGFloat constant = 0.55f;
    CGFloat result = (constant * fabs(offset) * dimension) / (dimension + constant * fabs(offset));
    // The algorithm expects a positive offset, so we have to negate the result if the offset was negative.
    return offset < 0.0f ? -result : result;
}

@interface JianLeKeBaiCaiMainView ()<UIGestureRecognizerDelegate,UIScrollViewDelegate,JianLeKeBaiCaiMainScrollViewDelegate>
{
    UIScrollView *scvback;
    JianLeKeBaiCaiMainScrollView *jview;
    
    /////弹性和惯性动画
    CGFloat currentScorllY;
    __block BOOL isVertical;//是否是垂直
    
}
//弹性和惯性动画
@property (nonatomic, strong) UIDynamicAnimator *animator;
@property (nonatomic, weak) UIDynamicItemBehavior *decelerationBehavior;
@property (nonatomic, strong) LJDynamicItem *dynamicItem;
@property (nonatomic, weak) UIAttachmentBehavior *springBehavior;

@end

@implementation JianLeKeBaiCaiMainView

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

-(void)dealloc
{
     [self.animator removeAllBehaviors];
}

-(id)initWithFrame:(CGRect)frame
{
    if(self = [super initWithFrame:frame])
    {
        [self drawUI];
        self.animator = [[UIDynamicAnimator alloc] initWithReferenceView:self];
        self.dynamicItem = [[LJDynamicItem alloc] init];
    }
    return self;
}

-(void)drawUI
{
    scvback = [[UIScrollView alloc] init];
    [self addSubview:scvback];
    [scvback setDelegate:self];
    UIPanGestureRecognizer *pangesture = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(pangestureAction:)];
    [pangesture setDelegate:self];
    [scvback addGestureRecognizer:pangesture];
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.bottom.equalTo(self);
        make.width.offset(kMainScreenW);
    }];
    
    ///
    UIView *viewheader = [[UIView alloc] init];
    [viewheader setBackgroundColor:[UIColor brownColor]];
    [scvback addSubview:viewheader];
    [viewheader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->scvback);
        make.width.offset(kMainScreenW);
        make.height.offset(kMainScreenW*1.2);
    }];
    
    
    ///
    jview = [[JianLeKeBaiCaiMainScrollView alloc] init];
    [scvback addSubview:jview];
    [jview setScoDelegate:self];
    [jview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(viewheader);
        make.top.equalTo(viewheader.mas_bottom);
        make.height.offset(kMainScreenH-kTopHeight-kTabBarHeight);
    }];
    
    [scvback mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self->jview.mas_bottom);
    }];
    
}

#pragma mark - 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    /*
    if(scrollView == scvback)
    {
        if(scrollView.contentOffset.y>=maxOffsetY)
        {
            [scrollView setContentOffset:CGPointMake(0, maxOffsetY) animated:NO];
            [scvback setScrollEnabled:NO];
            [jview.subItemView setScrollEnabled:YES];
            subScrollEnabled = YES;
            mainScrollEnabled = NO;
            currentPanY = 0;
        }

//        NSLog(@"1111");
    }
    else
    {
        if(scrollView.contentOffset.y<=0)
        {
            [scrollView setContentOffset:CGPointMake(0, 0) animated:NO];
            [scvback setScrollEnabled:YES];
            [jview.subItemView setScrollEnabled:NO];
            subScrollEnabled = NO;
            mainScrollEnabled = YES;
            currentPanY = 0;
        }
//        NSLog(@"2222");
    }
    */
}

- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer {
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {
        UIPanGestureRecognizer *recognizer = (UIPanGestureRecognizer *)gestureRecognizer;
        CGFloat currentY = [recognizer translationInView:self].y;
        CGFloat currentX = [recognizer translationInView:self].x;
        
        if (currentY == 0.0) {
            return YES;
        } else {
            if (fabs(currentX)/currentY >= 5.0) {
                return YES;
            } else {
                return NO;
            }
        }
    }
    return NO;
}
- (void)pangestureAction:(UIPanGestureRecognizer *)recognizer {
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:
            currentScorllY = scvback.contentOffset.y;
            CGFloat currentY = [recognizer translationInView:self].y;
            CGFloat currentX = [recognizer translationInView:self].x;
            
            if (currentY == 0.0) {
                isVertical = NO;
            } else {
                if (fabs(currentX)/currentY >= 5.0) {
                    isVertical = NO;
                } else {
                    isVertical = YES;
                }
            }
            [self.animator removeAllBehaviors];
            break;
        case UIGestureRecognizerStateChanged:
        {
            //locationInView:获取到的是手指点击屏幕实时的坐标点；
            //translationInView：获取到的是手指移动后，在相对坐标中的偏移量
            
            if (isVertical) {
                //往上滑为负数，往下滑为正数
                CGFloat currentY = [recognizer translationInView:self].y;
                [self controlScrollForVertical:currentY AndState:UIGestureRecognizerStateChanged];
            }
        }
            break;
        case UIGestureRecognizerStateCancelled:
            
            break;
        case UIGestureRecognizerStateEnded:
        {
            if (isVertical) {
                self.dynamicItem.center = self.bounds.origin;
                //velocity是在手势结束的时候获取的竖直方向的手势速度
                CGPoint velocity = [recognizer velocityInView:self];
                UIDynamicItemBehavior *inertialBehavior = [[UIDynamicItemBehavior alloc] initWithItems:@[self.dynamicItem]];
                [inertialBehavior addLinearVelocity:CGPointMake(0, velocity.y) forItem:self.dynamicItem];
                // 通过尝试取2.0比较像系统的效果
                inertialBehavior.resistance = 2.0;
                __block CGPoint lastCenter = CGPointZero;
                __weak typeof(self) weakSelf = self;
                inertialBehavior.action = ^{
                    if (self->isVertical) {
                        //得到每次移动的距离
                        CGFloat currentY = weakSelf.dynamicItem.center.y - lastCenter.y;
                        [weakSelf controlScrollForVertical:currentY AndState:UIGestureRecognizerStateEnded];
                    }
                    lastCenter = weakSelf.dynamicItem.center;
                };
                [self.animator addBehavior:inertialBehavior];
                self.decelerationBehavior = inertialBehavior;
            }
        }
            break;
        default:
            break;
    }
    //保证每次只是移动的距离，不是从头一直移动的距离
    [recognizer setTranslation:CGPointZero inView:self];
}

//控制上下滚动的方法
- (void)controlScrollForVertical:(CGFloat)detal AndState:(UIGestureRecognizerState)state {
    //判断是主ScrollView滚动还是子ScrollView滚动,detal为手指移动的距离
    if (scvback.contentOffset.y >= maxOffsetY-1) {
        CGFloat offsetY = jview.subItemView.contentOffset.y - detal;
        if (offsetY < 0) {
            //当子ScrollView的contentOffset小于0之后就不再移动子ScrollView，而要移动主ScrollView
            offsetY = 0;
            scvback.contentOffset = CGPointMake(scvback.frame.origin.x, scvback.contentOffset.y - detal);
        } else if (offsetY > (jview.subItemView.contentSize.height - jview.subItemView.frame.size.height)) {
            //当子ScrollView的contentOffset大于tableView的可移动距离时
            
            offsetY = jview.subItemView.contentOffset.y - rubberBandDistance(detal, tabviewHeight);
        }
        NSLog(@"subTableView -- %f",offsetY);
        jview.subItemView.contentOffset = CGPointMake(0, offsetY);
    } else {
        CGFloat mainOffsetY = scvback.contentOffset.y - detal;
        if (mainOffsetY < 0) {
            //滚到顶部之后继续往上滚动需要乘以一个小于1的系数
            
            mainOffsetY = scvback.contentOffset.y - rubberBandDistance(detal, tabviewHeight);
            
        } else if (mainOffsetY > maxOffsetY) {
            mainOffsetY = maxOffsetY;
        }
        NSLog(@"mainScrollView -- %f",mainOffsetY);
        scvback.contentOffset = CGPointMake(scvback.frame.origin.x, mainOffsetY);
        
        
        if (mainOffsetY == 0) {
            jview.subItemView.contentOffset = CGPointMake(0, 0);
//            for (UITableView *tableView in tableArray) {
//                tableView.contentOffset = CGPointMake(0, 0);
//            }
        }
    }
    
    BOOL outsideFrame = [self outsideFrame];
    if (outsideFrame &&
        (self.decelerationBehavior && !self.springBehavior)) {
        CGPoint target = CGPointZero;
        BOOL isMian = NO;
        if (scvback.contentOffset.y < 0) {
            self.dynamicItem.center = scvback.contentOffset;
            target = CGPointZero;
            isMian = YES;
        } else if (jview.subItemView.contentOffset.y > (jview.subItemView.contentSize.height - jview.subItemView.frame.size.height)) {
            self.dynamicItem.center = jview.subItemView.contentOffset;
            
            target.x = jview.subItemView.contentOffset.x;
            target.y = jview.subItemView.contentSize.height > jview.subItemView.frame.size.height ? jview.subItemView.contentSize.height - jview.subItemView.frame.size.height: 0;
            isMian = NO;
        }
        [self.animator removeBehavior:self.decelerationBehavior];
        __weak typeof(self) weakSelf = self;
        UIAttachmentBehavior *springBehavior = [[UIAttachmentBehavior alloc] initWithItem:self.dynamicItem attachedToAnchor:target];
        springBehavior.length = 0;
        springBehavior.damping = 1;
        springBehavior.frequency = 2;
        springBehavior.action = ^{
            if (isMian) {
                self->scvback.contentOffset = weakSelf.dynamicItem.center;
                if (self->scvback.contentOffset.y == 0) {
                    self->jview.subItemView.contentOffset = CGPointMake(0, 0);
//                    for (UITableView *tableView in tableArray) {
//                        tableView.contentOffset = CGPointMake(0, 0);
//                    }
                }
            } else {
                self->jview.subItemView.contentOffset = self.dynamicItem.center;
//                if (jview.subItemView.mj_footer.refreshing) {
//                    jview.subItemView.contentOffset = CGPointMake(jview.subItemView.contentOffset.x, jview.subItemView.contentOffset.y + 44);
//                }
            }
        };
        [self.animator addBehavior:springBehavior];
        self.springBehavior = springBehavior;
    }
}

//判断是否超出ViewFrame边界
- (BOOL)outsideFrame {
    if (scvback.contentOffset.y < 0) {
        return YES;
    }
    if (jview.subItemView.contentSize.height > jview.subItemView.frame.size.height) {
        if (jview.subItemView.contentOffset.y > (jview.subItemView.contentSize.height - jview.subItemView.frame.size.height)) {
            return YES;
        } else {
            return NO;
        }
    } else {
        if (jview.subItemView.contentOffset.y > 0) {
            return YES;
        } else {
            return NO;
        }
    }
    return NO;
}

@end
