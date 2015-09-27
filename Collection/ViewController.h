//
//  ViewController.h
//  Collection
//
//  Created by SIVASANKAR DEVABATHINI on 9/1/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UICollectionViewController <UICollectionViewDataSource, UICollectionViewDelegate, NSURLSessionDelegate,UIScrollViewDelegate>
{
    
}
@property (nonatomic, retain) NSMutableDictionary *descDict;
@property (weak, nonatomic) IBOutlet UIImageView *cellImgview;
@property (nonatomic, retain) NSMutableArray *dataAry;
@property (nonatomic,retain) NSDictionary *dict;

@end

