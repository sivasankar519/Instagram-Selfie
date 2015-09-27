//
//  DescriptionViewController.m
//  Collection
//
//  Created by SIVASANKAR DEVABATHINI on 9/1/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "DescriptionViewController.h"

@interface DescriptionViewController ()<NSURLSessionDelegate>


@end

@implementation DescriptionViewController

- (void)viewDidLoad {
    
   
    [super viewDidLoad];
    
     
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:self.str]
                                 completionHandler:^(NSData *data,
                                                     NSURLResponse *response,
                                                     NSError *error) {
                                     if(data)
                                     {
                                         dispatch_async(dispatch_get_main_queue(), ^{
                                             
                                             self.imgView.image = [UIImage imageWithData:data];
                                             
                                             
                                         });
                                     }
                                     
                                     
                                 }] resume];
    

    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
