//
//  LSDImagesCache.h
//  Pods
//
//  Created by IVAN CHIRKOV on 15.04.15.
//
//

#import <Foundation/Foundation.h>

@class UIImage;

@interface LSDImagesCache : NSObject

- (void)cacheImagesWithURLs : (NSArray *)URLs
                 concurrent : (BOOL)concurrent
                      queue : (NSOperationQueue *)queue
                   progress : (void(^)(NSURL *url, UIImage * image, NSError *error))progress
                 completion : (void(^)(BOOL success))completion;

@end
