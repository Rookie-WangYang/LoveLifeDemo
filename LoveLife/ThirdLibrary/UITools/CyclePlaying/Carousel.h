//
//  Carousel.h
//  ScrollDemo
//
//  Created by 王洋 on 15/9/5.
//  Copyright (c) 2015年 wangyang. All rights reserved.
//

/*
 * 简介：通用轮播控件，
 * 1.内嵌了pageControl，可以用needPageControl是否显示，默认显示(图片个数大于1)；
 * 2.支持图片数组与图片地址数组，采用sdwebImage库做图片的下载与缓存；
 * 3.支持轮播自播放的暂停与开始；
 * 4.只支持横向轮播；
 * 5.要使用该控件，必须在工程中添加对sdwebImage的引用，切记！！！
 *
 * 设计基本思路：
 * 轮播模式a：collectionview有无限个item，每次item显示的时候都去取对应正确的索引图片。
 * 轮播模式b：collectionview的item个数为实际图片的个数。图片初始化后在整个scrollView上的显示情况为item0(pic5)、item1(pic0)、item2(pic1)、
 *   item3(pic2)、item4(pic3)、item5(pic4)。这么显示的原因是：在初始化图片后，会让collectionview滚动到item1的位置上，这样左滑就可以滑动到最后一张图片了，右滑也可以滑动到第二张图片。  
 *   轮播的规则： 右滑--当collectionview从item1 滚动到item2的位置后，这个时候做一个无动画滚动，让位置继续滚回到item1，然后下次右滑的时候依然按照这个流程走，这样就可以保证在从最后一张滑动到第一张的时候，滚动动画的正常。左滑同右滑，只是方向变换一下。
 *
 * 1.当图片个数为1的时候，不能自动轮播
 * 2.当图片个数为2的时候，采用轮播模式a。
 * 3.当图片个数大于2张的时候，采用轮播模式b。
 *
 * @params:
 * imageArray      : local image array. (本地图片数组)
 * imageUrlArray   : image url array ,need to download image. (图片地址数组，需要控制自己内部处
 *                   理下载)
 * needPageControl : to tell view show or hide pageControl. (标识是否需要显示分页控制器)
 * infiniteLoop    : to infiniteLoop carousel image, default is NO. (无限循环轮播，默认不执行无限循环)
 * Prompt: imageArray and imageUrlArray can only use one. If you use two,view will select imageArray to use. Only one image can not auto carouse(本地图片数组与图片地址数组只能同时使用一个, 如果同时使用两个，那么当前轮播控件默认使用 本地图片数组 来做轮播。只有一张图片的时候不会自动轮播。)
 *
 *
 * @funtions:
 *
 * isAutoCarouseling : return the image carousel state, stop or playing. (是否正在轮播，返回 bool值，YES是正在轮播，NO是停止轮播)
 *               
 * startAutoCarousel : start to carousel image, default is start state. Image cout at least two. (开始轮播，默认是开始播放状态。图片个数最少是2张。)
 *
 * stopAutoCarousel  : stop to carousel image, default is can not stop. (停止轮播，默认是不会停止轮播图片。)
 *
 **/

#import <UIKit/UIKit.h>

typedef enum {

    PAGE_CONTROL_POSITION_TYPE_LEFT = 0,
    PAGE_CONTROL_POSITION_TYPE_MIDDLE,
    PAGE_CONTROL_POSITION_TYPE_RIGHT
} PAGE_CONTROL_POSITION_TYPE;

@interface Carousel : UIView

@property (nonatomic, strong) NSArray *imageArray;
@property (nonatomic, strong) NSArray *imageUrlArray;
@property (nonatomic, assign) BOOL needPageControl; //default is YES.
@property (nonatomic, assign) BOOL infiniteLoop;    //default is NO.
@property (nonatomic, strong) NSString *placeHolderImageName;
@property (nonatomic, assign) PAGE_CONTROL_POSITION_TYPE pageControlPositionType;

- (BOOL)isAutoCarouseling; //funtion - return the carousel state, stop or playing. (是否正在轮播)
- (void)startAutoCarousel; //default is start; funtion - start carousel (开始轮播)
- (void)stopAutoCarousel;  //default is can not stop; funtion - stop carousel (停止轮播)

@end
