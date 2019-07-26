//
//  JianLeKeBaiCaiMainScrollView.h
//  QingKu
//
//  Created by mdb-losaic on 2019/7/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JianLeKeBaiCaiMainTableView.h"

NS_ASSUME_NONNULL_BEGIN
@protocol JianLeKeBaiCaiMainScrollViewDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface JianLeKeBaiCaiMainScrollView : UIView

//@property (nonatomic,assign) CGPoint contentOffsetc;

@property (nonatomic,retain) JianLeKeBaiCaiMainTableView *subItemView;

@property(nonatomic,weak)id<JianLeKeBaiCaiMainScrollViewDelegate>scoDelegate;

//-(void)setAllScrollEnabled:(BOOL)able;
//-(void)setItemContOffset:(CGPoint)point;

@end

NS_ASSUME_NONNULL_END
