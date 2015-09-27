//
//  ViewController.m
//  Collection
//
//  Created by SIVASANKAR DEVABATHINI on 9/1/15.
//  Copyright (c) 2015 SIVASANKAR DEVABATHINI. All rights reserved.
//

#import "ViewController.h"
#import "DescriptionViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.descDict = [[ NSMutableDictionary alloc]init];
    self.dataAry = [[NSMutableArray alloc]init];
    
    NSString *str = @"https://api.instagram.com/v1/tags/kimkardashian/media/recent?count=30&client_id=b0e50ef7aa2843f8bdcac94a6cb2d72a";
    [self serviceCall:str];
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    // Dispose of any resources that can be recreated.
}



-(void)serviceCall:(NSString*)urlString
{
    if(!urlString) return;
    
    NSURLSession *session = [NSURLSession sharedSession];
    [[session dataTaskWithURL:[NSURL URLWithString:urlString]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                self.dict =  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
                if(self.dict)
                {
                    [self.dataAry addObjectsFromArray:[self.dict objectForKey:@"data"]];
                }
                
                
                
                // call on main thread
                dispatch_async(dispatch_get_main_queue(), ^{
                    [self.collectionView reloadData];
                });
                
                
                
            }] resume];
}

#pragma mark - UICollectionView Data Source

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return [self.dataAry count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    UICollectionViewCell *cell=[collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
   
    
    UIImageView *img = [[UIImageView alloc]initWithFrame:cell.bounds];
    
    NSString *str = self.dataAry[indexPath.row][@"images"][@"thumbnail"][@"url"];
    
    [self.descDict setObject:self.dataAry[indexPath.row][@"images"][@"standard_resolution"][@"url"] forKey:indexPath];
    
    [[[NSURLSession sharedSession] dataTaskWithURL:[NSURL URLWithString:str]
             completionHandler:^(NSData *data,
                                 NSURLResponse *response,
                                 NSError *error) {
                 if(data)
                 {
                     dispatch_async(dispatch_get_main_queue(), ^{
                         img.image = [UIImage imageWithData:data];
                     });
                 }
                 
             }] resume];
    
    cell.backgroundColor=[UIColor lightTextColor];
    [cell.contentView addSubview:img];
    
    
    
    if (indexPath.item == [self.dataAry count] - 1) {
        
        [self serviceCall:self.dict [@"pagination"][@"next_url"]];
    }
    
    
    return cell;
}


#pragma mark - UICollectionView Delegate


- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSString *str = [self.descDict objectForKey:indexPath];
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle: nil];
    DescriptionViewController *lvc = [storyboard instantiateViewControllerWithIdentifier:@"Desc"];
    lvc.str = str;
    [self.navigationController pushViewController:lvc animated:YES];
    
        
    
    
}

@end
