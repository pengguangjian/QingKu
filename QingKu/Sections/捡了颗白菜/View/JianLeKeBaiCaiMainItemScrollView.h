//
//  Home644HeaderItemView.h
//  Meidebi
//
//  Created by mdb-losaic on 2019/3/20.
//  Copyright © 2019年 meidebi. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN
@protocol JianLeKeBaiCaiMainItemScrollViewDelegate <NSObject>

-(void)btNowSelectItem:(NSInteger)item;


@end

@interface JianLeKeBaiCaiMainItemScrollView : UIView

@property (nonatomic , weak)id<JianLeKeBaiCaiMainItemScrollViewDelegate>delegate;

@property (nonatomic , assign) NSInteger inowselectitem;

#pragma mark - items数据
-(void)bindItemsData:(NSArray *)arrmodels;

///字符串数组
-(void)bindListData:(NSArray *)arrlist;

-(void)btselectItem:(NSInteger)item;

@end

NS_ASSUME_NONNULL_END
