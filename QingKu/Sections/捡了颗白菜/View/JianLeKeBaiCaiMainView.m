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

#import "NewPeopleBuyTableViewController.h"

//#define maxOffsetY kMainScreenW*1.2
#define maxOffsetY 300
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
    [viewheader setBackgroundColor:[UIColor whiteColor]];
    [scvback addSubview:viewheader];
    [viewheader mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self->scvback);
        make.width.offset(kMainScreenW);
    }];
    [self drawHeaderView:viewheader];
    
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

-(void)drawHeaderView:(UIView *)view
{
    
    UIView *viewsbuy = [self drawzhiboitem:CGRectMake(0, 120, kMainScreenW/2.0, 70) andtitle:@"分享购买" andcont:@"最高获40%奖励金" andimage:@"home_Share_item0"];
    [view addSubview:viewsbuy];
    
    UIView *viewshare = [self drawzhiboitem:CGRectMake(kMainScreenW/2.0, viewsbuy.top, viewsbuy.width, viewsbuy.height) andtitle:@"邀请好友" andcont:@"送免邮券/优惠券" andimage:@"home_Share_item1"];
    [view addSubview:viewshare];
    
    UIView *viewline = [[UIView alloc] initWithFrame:CGRectMake(kMainScreenW/2.0-1, viewsbuy.top+8, 1.5, viewsbuy.height-16)];
    [viewline setBackgroundColor:RGB(234, 234, 234)];
    [view addSubview:viewline];
    
    UIView *viewline1 = [[UIView alloc] initWithFrame:CGRectMake(0, viewsbuy.bottom+10, kMainScreenW, 10)];
    [viewline1 setBackgroundColor:RGB(240, 240, 240)];
    [view addSubview:viewline1];
    
    UIView *viewxinren = [[UIView alloc] initWithFrame:CGRectMake(0, viewline1.bottom, viewline1.width, 80)];
    [viewxinren setBackgroundColor:[UIColor whiteColor]];
    [view addSubview:viewxinren];
    
    UIImageView *imgvxinren = [[UIImageView alloc] initWithFrame:CGRectMake(15, 10, viewxinren.width-30, viewxinren.height-20)];
    [imgvxinren setBackgroundColor:[UIColor grayColor]];
    [viewxinren addSubview:imgvxinren];
    [imgvxinren setUserInteractionEnabled:YES];
    UITapGestureRecognizer *tapxinren = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(xinrenHLAction)];
    [imgvxinren addGestureRecognizer:tapxinren];
    
    UIView *viewline2 = [[UIView alloc] initWithFrame:CGRectMake(0, viewxinren.bottom, kMainScreenW, 10)];
    [viewline2 setBackgroundColor:RGB(240, 240, 240)];
    [view addSubview:viewline2];
    
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(viewline2.mas_bottom);
    }];
    
}

-(UIView *)drawzhiboitem:(CGRect)rect andtitle:(NSString *)strtitle andcont:(NSString *)strcontent andimage:(NSString *)strimage
{
    UIView *view = [[UIView alloc] initWithFrame:rect];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIImageView *imgv = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, view.height-30, view.height-30)];
    [imgv setCenter:CGPointMake(0, view.height/2.0)];
    [imgv setRight:view.width-10];
    [imgv setContentMode:UIViewContentModeScaleAspectFit];
    [imgv setImage:[UIImage imageNamed:strimage]];
//    [imgv setBackgroundColor:[UIColor grayColor]];
    [view addSubview:imgv];
    
    
    UILabel *lbcont = [[UILabel alloc] initWithFrame:CGRectMake(15, view.height/2.0, imgv.left-15, 22)];
    [lbcont setText:strcontent];
    [lbcont setTextColor:RGB(255, 255, 255)];
    [lbcont setTextAlignment:NSTextAlignmentCenter];
    [lbcont setFont:[UIFont systemFontOfSize:11]];
    [lbcont sizeToFit];
    [lbcont setHeight:22];
    [lbcont setWidth:lbcont.width+8];
    [lbcont.layer setMasksToBounds:YES];
    [lbcont.layer setCornerRadius:2];
    [lbcont setBackgroundColor:RadMenuColor];
    [view addSubview:lbcont];
    
    
    UILabel *lbtitle = [[UILabel alloc] initWithFrame:CGRectMake(lbcont.left, view.height/2.0-25, lbcont.width, 25)];
    [lbtitle setText:strtitle];
    [lbtitle setTextColor:RGB(20, 20, 20)];
    [lbtitle setTextAlignment:NSTextAlignmentLeft];
    [lbtitle setFont:[UIFont systemFontOfSize:14]];
    [view addSubview:lbtitle];
    
    
    return view;
}

#pragma mark - 新人送豪礼
-(void)xinrenHLAction
{
    NewPeopleBuyTableViewController *nvc = [[NewPeopleBuyTableViewController alloc] init];
    [self.viewController.navigationController pushViewController:nvc animated:YES];
}

#pragma mark - 滚动
- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
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
