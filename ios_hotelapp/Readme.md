# Hotelzzz: Hipmunk iOS challenge

For this challenge, you will make a simple hotel search app by combining iOS and web technology. It is called "Hotelzzz" because it helps you find a place to sleep!

There is a "web server" running at `https://hipmunk.github.io/hipproblems/ios_hotelapp/`.
This page has a JavaScript API; you can call functions from the JS console and get the page to do things.

Visit the page now, open the JS console, and type:

```js
window.JSAPI.runHotelSearch({location: "San Francisco", dateStart: "2017-12-01", dateEnd: "2017-12-05"});
```

After a few seconds, you should see a list of hotel results, and some messages logged to the console.

Now let's look at the app. You should be able to just open `Hotelzzz.xcworkspace` in Xcode and run it.

The first screen of the app is an ugly search form. If you tap "search," you should get to a bare-bones web view that points to our web server, and the hotel results should load for the search you did.

If you tap a row, a mostly-empty view controller is pushed onto the navigation stack.

## The Challenge

You are going to flesh out this app and make your mark on it. Before you begin, you might want to open these pages up in new tabs:

* [NSHipster on WKWebView](http://nshipster.com/wkwebkit/)
* [Apple's WKWebView docs](https://developer.apple.com/reference/webkit/wkwebview)

**Note:** Although all view controllers are laid out in `Main.storyboard`, you are free to change that. We use storyboards at Hipmunk sometimes, but if you prefer to avoid them, that's fine.

### Show hotel details

When you select a hotel result, you're taken to a page titled "hotel details" with nothing on it. Populate this page with the name, image, address, and price of this hotel.

### Nav bar prettification

You might have noticed that the nav bar says 'Searching...' even when the results have loaded. Replace this text with the number of results.

### Sort button

The "Sort" button in the nav bar opens a blank view controller. Populate this with a table view containing the sort options (see "API" below). When the user taps an option, tell the web view to sort the results accordingly.

### Filter button

The "Filter" button also opens a blank view controller. Add an interface for setting the minimum and maximum price, and update the web view when the user finishes their selection.

### Extras

If you have time and motivation, make the app look or behave better. Some ideas:
* Pick an iOS API that a hotel search app would work well with, and try integrating it
* Make the search form more user friendly
* Find a more interesting way to present the sort, filter, or hotel detail view controllers
* Improve iPad support

## API: JS calls

### `window.JSAPI.runHotelSearch({location, dateStart, dateEnd})`

* `location`: Arbitrary string representing a location. Since this is a "fake" API, this doesn't need to be sanitized at all.
* `dateStart`: Date formatted as `YYYY-MM-DD`
* `dateEnd`: Date formatted as `YYYY-MM-DD`

Example:

```js
window.JSAPI.runHotelSearch({
  location: "San Francisco",
  dateStart: "2017-12-01",
  dateEnd: "2017-12-05",
});
```

### `window.JSAPI.setHotelSort(sortId)`

* `sortId`: one of `{"name", "priceAscend", "priceDescend"}`

Example:

```js
window.JSAPI.setHotelSort("priceAscend");
```

### `window.JSAPI.setHotelFilters({priceMin, priceMax})`

* `priceMin`: `null` or a number
* `priceMax`: `null` or a number

Example:

```js
window.JSAPI.setHotelFilters({priceMin: 100, priceMax: null});
```

## API: Messages

These are the messages you can listen for in `WKScriptMessageHandler` in iOS. The setup is already done for this, you just need to keep adding entries to the `WKUserContentController` definition and `userContentController(:didReceive:)` implementation.

### `API_READY {}`

Sent as soon as `window.JSAPI` exists

### `HOTEL_API_SEARCH_READY {search: {location, dateStart, dateEnd}}`

Sent when the search you passed in `runHotelSearch()` has been interpreted and validated. The search object is just the `{location, dateStart, dateEnd}` object you provided earlier.

### `HOTEL_API_RESULTS_READY {results: [HotelResult]}`

Sent when search results are ready and rendered.

A `HotelResult` is an object that looks like this:

```js
{
    price: a number,
    hotel: {
        id: a number,
        name: "Blah",
        address: "123 Example Dr",
        imageURL: "http://blah",
    },
}
```

### `HOTEL_API_HOTEL_SELECTED {result: HotelResult}`

Sent when the user taps a row in the results list. See `HOTEL_API_RESULTS_READY` for what a `HotelResult` looks like.

## FAQ

**Can I add 3rd party libraries?** Yes, as long as you provide working build
instructions for us.

**What if I don't have time to finish?** That's okay, just get in touch with
us with what you have.