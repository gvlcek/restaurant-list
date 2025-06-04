# iOS Technical Test

## To run the project
- Just download the project and press play, it will work!

## Restaurant list
- The app starts in the Main storyboard, I was reading the documentation and Apple doesn't allow any longer to start the app from anything but a Storyboard. All the views are done programatically, though
- I used MVP cause I find it easier to write tests
- I wanted to keep it simple so I didn't use third party libraries to fetch the data and images since it was a very simple json, for more complex stuff I would go for Alamofire
- In order to save the favorites I went for CoreData because I think it would be too messy to work with Userdefaults
- I added the localization for the 3 languages that I speak 🇪🇸 🇬🇧 and 🇨🇿
- As you can see I avoided using singletons. Previous experiences proved me that singletons get messy if there are too many so instead I used dependency injection
- The app is designed to work in light and dark mode, so try it!
- I always avoid what I call 'the magic numbers', so I created the struct Constants for every number and string have a name and purpose
