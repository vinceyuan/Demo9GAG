Demo9GAG is a demo iPhone app which looks and feels like the offical 9GAG app. 

![Screenshot](https://github.com/vinceyuan/Demo9GAG/raw/master/ScreenShot.png)

##Highlights:

1. There are 3 tabs showing the real Hot/Trending/Fresh images of 9GAG. Horizontally swipe to change the tab.
2. Each tab supports vertical infinite scrolling and pull-to-refresh.
3. At the top of the Hot tab, there is a horizontal-scrolling table (but the content of this table is static). It also supports the loading-more action.
4. Scrolling is very smooth in both vertical and horizontal directions.
5. Images are downloaded asynchronously and cached.
6. It shows progress bars when downloading images. (You'd better switch to a slow connection like 3G for better progress bar effects)
7. The third party data source ([http://infinigag-us.aws.af.cm/](http://infinigag-us.aws.af.cm/)) does not provide each image's width and height. It adjusts the image size after the image is downloaded.
8. It supports multiple lines of captions. Table view cell's height is calculated correctly.
9. The top module (horizontal scrolling) is implemented with a transformed uitableview.
10. Code is clean, well-organized and reusable.
11. Tapping the status bar can scroll the current table view to top.
12. Both unit test and UI test are implemented. (UI Test was introduced in Xcode 7.)
13. It handles memory carefully, and also deals with the memory warning.

##Issues:

1. The third party data source ([http://infinigag-us.aws.af.cm/](http://infinigag-us.aws.af.cm/)) is slow and not stable. This issue is handled in the app. When there is a problem, just pull to refresh. 
2. When the unit test fails because the server returns 500(Internal Server Error), just restart the unit test.

##Third-Party Libraries:

1. AFNetworking - for downloading JSON from the data source.
2. SVProgressHUD - for showing messages.
3. SDWebImage - for downloading and caching images.

Because the data source does not provide the image's width and height, I have to adjust the size of the image view after the image is downloaded. I did not use `[UIImageview sd_setImageWithURL:placeholderImage:]`. Instead, I download the images using `[SDWebImageManager downloadImageWithURL:options:progress:completed:]` and adjust the image view size and table view cell's height.

##Code Structure:

1. The root view controller is a UINavigationController (for the navigation bar);
2. Downloader handles downloading JSON from the server. It can be used for Hot/Trending/Fresh.
3. PagedScrollViewController provides a paged scroll view. Each page is a table view of PostsTableViewController.
4. PostsTableViewController shows posts. It can be used for Hot/Trending/Fresh.
5. The table header view of Hot table view is a transformed table view of TopPostsTableViewController. 
6. PostsTableViewCell, LoadMoreTableViewCell, and TopPostsTableViewCell are customized UITableViewCell.

##Good Practice:

1. To support the horizontal scroll and loading more easily, TopPostsTableViewController is actually a subclass of UITableViewController. The table view is transformed by 90 degree counter-clockwise and the table view cell's content view is transformed by 90 degree clockwise.
2. Used a helper label to calculate the size of multiple lines of caption to avoid the size difference when calculating by NSString.

##IDE:

Xcode 7 beta 3 or higher.

##Author:

Vince Yuan (vince.yuan@gmail.com). 

##License:

###MIT License

Copyright (c) 2015 Vince Yuan (vince.yuan###gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.