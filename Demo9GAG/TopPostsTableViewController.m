//
//  TopPostsTableViewController.m
//  Demo9GAG
//
//  Created by Vince Yuan on 18/7/15.
//  Copyright © 2015 Vince Yuan. All rights reserved.
//

#import "TopPostsTableViewController.h"
#import "TopPostsTableViewCell.h"
#import "Post.h"
#import "LoadMoreTableViewCell.h"

@interface TopPostsTableViewController () {
    NSMutableArray *_posts; // fake top posts
}

@end

@implementation TopPostsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    _posts = [[NSMutableArray alloc] init];
    [_posts addObject:[Post postWithCaption:@"This is my universal translator"]];
    [_posts addObject:[Post postWithCaption:@"Gets to work on time\ninstead of the usual hour early"]];
    [_posts addObject:[Post postWithCaption:@"Don't get married Bro\nBro!! Don't do it!\nThink about it!"]];
    [_posts addObject:[Post postWithCaption:@"DC vs Marvel"]];
    [_posts addObject:[Post postWithCaption:@"Same people at same place"]];
    [_posts addObject:[Post postWithCaption:@"Black hole"]];
    [_posts addObject:[Post postWithCaption:@"Move b*tch..."]];
    [_posts addObject:[Post postWithCaption:@"IT ONLY MATTERS WHAT'S INSIDE\nOH LOOK ABS"]];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if ([_posts count] < 16) {
        return 2;
    }
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (section == TopSectionTypePosts) {
        return [_posts count];
    } else {
        return 1;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TopSectionTypePosts) {
        static NSString *CellIdentifier = @"TopPostsTableViewCell";
        TopPostsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (!cell) {
            cell = (TopPostsTableViewCell *)[TopPostsTableViewCell cellFromNibNamed:@"TopPostsTableViewCell"];
        }

        [cell setupWithPosts:_posts index:indexPath.row];
        return cell;
    } else {
        LoadMoreTableViewCell *cell = (LoadMoreTableViewCell *)[LoadMoreTableViewCell cellFromNibNamed:@"LoadMoreTableViewCell"];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == TopSectionTypePosts) {
        return TopPostsTableViewCellWidth;
    } else {
        return 60;
    }
}

- (void)tableView:(nonnull UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    if (indexPath.section == TopSectionTypeLoadMore) {
        [self performSelector:@selector(delayAddMore) withObject:nil afterDelay:3];
    }
}

- (void)delayAddMore {
    if ([_posts count] >= 16) {
        [self.tableView reloadData];
        return;
    }

    [_posts addObject:[Post postWithCaption:@"Life is good\nwhen you have many cans of beer in the ice box."]];
    [_posts addObject:[Post postWithCaption:@"I started an \"I hat Cox\" chat room. Hasn't really worked out they way I planned. It's me, two interns and 14,000 lesbians."]];
    [_posts addObject:[Post postWithCaption:@"IF YOU COULD STOP POSTING ABOUT DC (S VS B & SUICIDE SQUAD)"]];
    [_posts addObject:[Post postWithCaption:@"Before and after"]];
    [_posts addObject:[Post postWithCaption:@"Tuna disposal\n Insert tuna here"]];
    [_posts addObject:[Post postWithCaption:@"What happened?"]];
    [_posts addObject:[Post postWithCaption:@"A beautiful girl is smiling..."]];
    [_posts addObject:[Post postWithCaption:@"A car game"]];
    [self.tableView reloadData];
}
@end
