//
//  Carousel.m
//  ScrollDemo
//
//  Created by 杨阳 on 15/9/5.
//  Copyright (c) 2015年 yangyang. All rights reserved.
//

#import "Carousel.h"
#import "CycleImageCell.h"

@interface Carousel () <UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout>
{
    
}
#pragma mark - 轮播视图声明
@property (nonatomic, strong) UICollectionView *cycleCollectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *cycleCollectionViewFlowLayout;

#pragma mark - 索引声明
@property (nonatomic, assign) NSUInteger currentIndex;

#pragma mark - 定时器的声明
@property (nonatomic, strong) NSTimer *timer;

#pragma mark - 分页控制器的声明
@property (nonatomic, strong) UIPageControl *pageControl;

@end

@implementation Carousel

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self initSomeAttribute];
        [self createSubViews];
    }
    
    return self;
}

#pragma mark - 父视图被释放时，释放当前timer，以使当前控件被释放
- (void)willMoveToSuperview:(UIView *)newSuperview
{
    if (!newSuperview)
    {
        [_timer invalidate];
        _timer = nil;
    }
}

- (void)dealloc
{
    [_cycleCollectionView setDelegate:nil];
    [_cycleCollectionView setDataSource:nil];
}

#pragma mark - 对外开放方法
- (BOOL)isAutoCarouseling
{
    if (self.cycleCollectionView)
    {
        if ([self imageCount] < 2)
        {
            return NO;
        }
        else
        {
            if (self.timer)
            {
                return YES;
            }
            else
            {
                return NO;
            }
        }
    }
    else
    {
        return NO;
    }
}

- (void)startAutoCarousel
{
    if (_infiniteLoop) //启用无限轮播
    {
        if ([self imageCount] >= 2) //图片个数必须最少2张，才能自动轮播
        {
            [self startTimer];
        }
    }
    else
    {
        [self stopTimer];
    }
}

- (void)stopAutoCarousel
{
    [self stopTimer];
}

#pragma makr - 对外开放属性
- (void)setImageArray:(NSArray *)imageArray
{
    _imageArray = imageArray;
    
    if (self.pageControl && [self imageCount] >= 2)
    {
        self.pageControl.numberOfPages = _imageArray.count;
    }
    
    [self resetViewStateAndStartAutoCarousel];
}

- (void)setImageUrlArray:(NSArray *)imageUrlArray
{
    _imageUrlArray = imageUrlArray;
    if (self.pageControl)
    {
        self.pageControl.numberOfPages = _imageUrlArray.count;
    }
    
    [self resetViewStateAndStartAutoCarousel];
}

- (void)setNeedPageControl:(BOOL)needPageControl
{
    _needPageControl = needPageControl;
    
    if (self.pageControl && [self imageCount] >= 2)
    {
        [self.pageControl setHidden:!_needPageControl];
    }
}

- (void)setInfiniteLoop:(BOOL)infiniteLoop
{
    _infiniteLoop = infiniteLoop;
    
    [self resetAutoCarouselState];
}

- (void)setPageControlPositionType:(PAGE_CONTROL_POSITION_TYPE)pageControlPositionType
{
    _pageControlPositionType = pageControlPositionType;
    [self resetPageControlFrame];
}

#pragma mark - 重置分页控制器的隐藏状态、开始自动轮播
- (void)resetViewStateAndStartAutoCarousel
{
    if (self.cycleCollectionView)
    {
        [self startAutoCarousel];
    }
    
    if (self.pageControl && [self imageCount] > 1) //图片个数最少为2张才能显示分页控制器。
    {
        [self.pageControl setHidden:!_needPageControl];
    }
}

#pragma mark - 重置自动轮播的状态
- (void)resetAutoCarouselState
{
    if (_infiniteLoop)
    {
        [self startAutoCarousel];
    }
    else
    {
        [self stopAutoCarousel];
    }
}
#pragma mark - 重置pageControl的frame
- (void)resetPageControlFrame
{
    if (self.pageControl)
    {
        switch (_pageControlPositionType)
        {
            case PAGE_CONTROL_POSITION_TYPE_LEFT:
            {
                //设置frame
                self.pageControl.frame = CGRectMake(20, CGRectGetMaxY(self.cycleCollectionView.frame) - 30, 60, 30);
            }
                break;
            case PAGE_CONTROL_POSITION_TYPE_MIDDLE:
            {
                self.pageControl.frame = CGRectMake((self.frame.size.width - 60) / 2, CGRectGetMaxY(self.cycleCollectionView.frame) - 30, 60, 30);
            }
                break;
            case PAGE_CONTROL_POSITION_TYPE_RIGHT:
            {
                self.pageControl.frame = CGRectMake(self.frame.size.width - 80, CGRectGetMaxY(self.cycleCollectionView.frame) - 30, 60, 30);
            }
                break;
            default:
                break;
        }
    }
}

#pragma mark - 初始化一些属性
- (void)initSomeAttribute
{
    _needPageControl = YES;
    _infiniteLoop = NO;
    _pageControlPositionType = PAGE_CONTROL_POSITION_TYPE_LEFT;
    
    self.currentIndex = 0;
}

#pragma mark - 创建视图内容
- (void)createSubViews
{
    [self createCollectionView];
    [self createPageControlView];
}

- (void)createCollectionView
{
    if (self.cycleCollectionViewFlowLayout)
    {
        return;
    }
    
    self.cycleCollectionViewFlowLayout = [[UICollectionViewFlowLayout alloc] init];
    // 设置界面布局
    self.cycleCollectionViewFlowLayout.itemSize = CGSizeMake(self.frame.size.width, self.frame.size.height);
    self.cycleCollectionViewFlowLayout.minimumInteritemSpacing = 0;
    self.cycleCollectionViewFlowLayout.minimumLineSpacing = 0;
    self.cycleCollectionViewFlowLayout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.cycleCollectionView = [[UICollectionView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height) collectionViewLayout:self.cycleCollectionViewFlowLayout];
    self.cycleCollectionView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    self.cycleCollectionView.delegate = self;
    self.cycleCollectionView.dataSource = self;
    self.cycleCollectionView.showsHorizontalScrollIndicator = NO;
    self.cycleCollectionView.pagingEnabled = YES;
    [self addSubview:self.cycleCollectionView];
    
    [self.cycleCollectionView registerClass:[CycleImageCell class] forCellWithReuseIdentifier:@"CycleImageCell"];
}

- (void)createPageControlView
{
    if (self.pageControl)
    {
        return;
    }
    
    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(self.frame.size.width - 80, CGRectGetMaxY(self.cycleCollectionView.frame) - 30, 60, 30)];
    self.pageControl.userInteractionEnabled = NO;
    self.pageControl.currentPageIndicatorTintColor = [UIColor redColor];
    self.pageControl.pageIndicatorTintColor = [UIColor darkGrayColor];
    [self addSubview:self.pageControl];
}

#pragma mark - timer funtiions
- (void)startTimer
{
    if (self.timer)
    {
        return;
    }
    
    self.timer = [NSTimer timerWithTimeInterval:3.0 target:self selector:@selector(roll) userInfo:nil repeats:YES];
    [[NSRunLoop currentRunLoop] addTimer:self.timer forMode:NSRunLoopCommonModes];
}
- (void)stopTimer
{
    if (self.timer == nil)
    {
        return;
    }
    [self.timer invalidate];
    self.timer = nil;
}

- (void)roll
{
    if (self.cycleCollectionView)
    {
        //取出当前显示cell
        NSIndexPath *indexPath = [self.cycleCollectionView indexPathsForVisibleItems].lastObject;
        
        //显示下一张
        [self.cycleCollectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForItem:(indexPath.item + 1) inSection:0] atScrollPosition:UICollectionViewScrollPositionCenteredHorizontally animated:YES];
        
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self scrollViewDidEndDecelerating:self.cycleCollectionView];
        });
    }
}

- (NSUInteger)imageCount
{
    if (_imageArray)
    {
        return [_imageArray count];
    }
    else if (_imageUrlArray)
    {
        return [_imageUrlArray count];
    }
    else
    {
        return 0;
    }
}

#pragma mark - UICollectionViewDatasource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    if (_imageArray)
    {
        if ([_imageArray count] >= 2)
        {
            return INT16_MAX;
        }
        
        return [_imageArray count];
    }
    else if (_imageUrlArray)
    {
        if ([_imageUrlArray count] >= 2)
        {
            return INT16_MAX;
        }
        
        return [_imageUrlArray count];
    }
    else
    {
        return 0;
    }
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //[CycleImageCell cellWithCollectionView:collectionView indexPath:indexPath];
    CycleImageCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"CycleImageCell" forIndexPath:indexPath];
    cell.placeHolderImageName = _placeHolderImageName;
    
    NSUInteger imageIndex = [self indexWithOffset:indexPath.item];
    if (_imageArray)
    {
        cell.imageName = self.imageArray[imageIndex];
    }
    else if (_imageUrlArray)
    {
        cell.imageURL = [NSURL URLWithString:self.imageUrlArray[imageIndex]];
    }
    
    return cell;
}

- (NSUInteger)indexWithOffset:(NSUInteger)offset
{
    if (_imageArray)
    {
        
        return (offset % [_imageArray count]);
        
    }
    else if (_imageUrlArray)
    {
        
        return (offset % [_imageUrlArray count]);
        
    }
    else
    {
        return 0;
    }
}


#pragma mark - UIScrollViewDelegate
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSUInteger offset = scrollView.contentOffset.x / scrollView.bounds.size.width;
    
    NSInteger imageCount = 0;
    if (_imageArray)
    {
        imageCount = [_imageArray count];
    }
    else if (_imageUrlArray)
    {
        imageCount = [_imageUrlArray count];
    }
    
    if (offset == 0) //向左滚动
    {
        if (self.pageControl.currentPage == 0) //处理左边界
        {
            self.pageControl.currentPage = MAX(imageCount - 1, 0);
        }
        else
        {
            self.pageControl.currentPage--;
        }
    }
    else //向右滚动
    {
        if (self.pageControl.currentPage == imageCount - 1) //处理右边界
        {
            self.pageControl.currentPage = 0;
        }
        else
        {
            self.pageControl.currentPage++;
        }
    }
    
    self.currentIndex = [self indexWithOffset:offset];
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self stopAutoCarousel];
}

- (void)scrollViewDidEndDragging:(UIScrollView *)scrollView willDecelerate:(BOOL)decelerate
{
    [self startAutoCarousel];
}

@end
