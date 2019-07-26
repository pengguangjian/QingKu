//
//  JianLeKeBaiCaiMainTableView.h
//  QingKu
//
//  Created by mdb-losaic on 2019/7/26.
//  Copyright © 2019 mcxzfa. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol JianLeKeBaiCaiMainTableViewDelegate <NSObject>

- (void)scrollViewDidScroll:(UIScrollView *)scrollView;

@end

@interface JianLeKeBaiCaiMainTableView : UITableView <UITableViewDelegate, UITableViewDataSource>
@property (nonatomic,weak)id<JianLeKeBaiCaiMainTableViewDelegate>listDelegate;

//@property (nonatomic,assign) CGPoint contentOffsetp;

-(JianLeKeBaiCaiMainTableView * )initWithFrame:(CGRect)frame andtype:(NSString *)type;

@end

NS_ASSUME_NONNULL_END
