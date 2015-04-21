//
//  LSDImagesCache.m
//  Pods
//
//  Created by IVAN CHIRKOV on 15.04.15.
//
//

#import <UIKit/UIKit.h>
#import "LSDImagesCache.h"
#import "NSOperationQueue+LSDCompletion.h"
#import <SDWebImage/SDWebImageManager.h>


@implementation LSDImagesCache

- (void)cacheImagesWithURLs : (NSArray *)URLs
                 concurrent : (BOOL)concurrent
                      queue : (NSOperationQueue *)queue
                   progress : (void(^)(NSURL *url, UIImage * image, NSError *error))progress
                 completion : (void(^)(BOOL success))completion;
{

    SDImageCache *cache = [[SDWebImageManager sharedManager] imageCache];

    NSOperationQueue *operationQueue = queue ?: [NSOperationQueue new];
    for (NSURL *url in URLs) {

        NSBlockOperation *operation = [NSBlockOperation blockOperationWithBlock:^{
            
            UIImage *cachedImage = [cache imageFromMemoryCacheForKey:[url absoluteString]] ?: [cache imageFromDiskCacheForKey:[url absoluteString]];
            if (cachedImage) {
                if (progress) {
                    progress(url, cachedImage, nil);
                }
                return;
            }

            NSURLRequest *request = [NSURLRequest requestWithURL:url];
            NSHTTPURLResponse *response = nil;
            NSError *error = nil;
            NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:&error];

            if ((response.statusCode == 200 || response.statusCode == 304) && data) {
                UIImage *image = [UIImage imageWithData:data];
                [cache storeImage:image forKey:[url absoluteString]];
                if (progress) {
                    progress(url, image, error);
                }
            } else {
                if (progress) {
                    if (!error) {
                        error = [NSError errorWithDomain:NSURLErrorDomain code:response.statusCode userInfo:nil];
                    }
                    progress(url, nil, error);
                }
            }
        }];

        if (!concurrent && [operationQueue.operations count]) {
            [operation addDependency:[operationQueue.operations lastObject]];
        }
        [operationQueue addOperation:operation];
    }
    [operationQueue setCompletion:^{
        if (completion) {
            completion(YES);
        }
    }];
}


@end
