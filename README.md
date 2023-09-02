# NYTimes

Simple application based on NYTimes Api, which shows lists of news from 3 categories:

- Most Emailed;

- Most Shared;

- Most Viewed.

![mainScreens](https://user-images.githubusercontent.com/10026372/203414331-6d82064c-8711-4517-8689-b595de522240.jpg)

App displays data for the last 30 days.

You can make bookmark for the article. All marked articles you can find in TabSection "Favorites". 
This section available offline.

![screeFavorites](https://user-images.githubusercontent.com/10026372/203418452-713bd94f-4143-414d-a64c-23f970d1d518.jpg)

After tapping on article item in the list, app will show you full information about it in a new view. 

![ScreenArticle](https://user-images.githubusercontent.com/10026372/203415862-059a7dde-cdc1-4c01-80e4-8f55ed3b4ee8.jpg)

App looks pretty cool both in vertical and horizontal orientations.

![horyzontalOrientation](https://user-images.githubusercontent.com/10026372/203415309-0ad46741-c305-4583-9f03-d285e05037ca.jpg)

## App uses next Pods:
- Alamofire for the requests;
- SDWebImage for downloading, cache supporting images.

## For local data storing app uses CoreData
Networking with Combine.
