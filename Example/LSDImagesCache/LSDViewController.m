//
//  LSDViewController.m
//  LSDImagesCache
//
//  Created by nsleader on 04/15/2015.
//  Copyright (c) 2014 nsleader. All rights reserved.
//

#import "LSDViewController.h"
#import "SDWebImageManager.h"
#import <LSDImagesCache/LSDImagesCache.h>

@interface LSDViewController ()

@end

@implementation LSDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];

    [[[SDWebImageManager sharedManager] imageCache] clearMemory];
    [[[SDWebImageManager sharedManager] imageCache] clearDisk];



}

- (IBAction)touchUp:(UIButton *)sender
{
    NSArray *urls = @[
            [NSURL URLWithString:@"http://www.wallpage.ru/imgbig/wallpapers_55894.jpg"],
            [NSURL URLWithString:@"http://www.nextwindows.ru/uploads/posts/2012-09/1346956002_abstract_wallpapers-5.jpg"],
            [NSURL URLWithString:@"http://www.nextwindows.ru/uploads/posts/2012-09/1346955964_abstract_wallpapers-19.jpg"],
            [NSURL URLWithString:@"http://www.nextwindows.ru/uploads/posts/2012-09/1346955959_abstract_wallpapers-4.jpg"],
            [NSURL URLWithString:@"http://www.nextwindows.ru/uploads/posts/2012-08/1344106074_img3.jpg"],
            [NSURL URLWithString:@"http://www.nextwindows.ru/uploads/posts/2012-09/1346956308_abstract_wallpapers-1.jpg"],
    ];

    LSDImagesCache *imagesCache = [LSDImagesCache new];
    [imagesCache cacheImagesWithURLs:urls
                          concurrent:NO
                               queue:nil
                            progress:^(NSURL *url, UIImage *image, NSError *error) {
                                if (error) {
                                    NSLog(@"%@", error);
                                } else {
                                    NSLog(@"%0.f x %0.f %@", image.size.width, image.size.height, url);
                                }

                            }
                          completion:^(BOOL success) {
                              NSLog(@"Completion!");
                          }];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];

}

@end
