Your app will fetch a list of hotels using our Coding Challenge API (documented below) and display each hotel’s name and image in a scrolling list. Tapping on a hotel image should expand that image to full screen. Tapping on it again, or pressing the back button, should return to the list of results. Your app must support both landscape and portrait orientations, but you may choose to support either a phone or tablet-sized device.

Please emphasize optimizing the speed of results loading and the performance of scrolling down the list. We would look at how your code would perform in a real world scenario: if the hotels were more complex objects with more complex views representing them, and if there was a lot more data than just a couple dozen hotels.

We will be evaluating how the app performs: it should be stable and responsive at all times. We will also be looking at your implementation code; so please make sure it is properly documented. Don't be shy to pay extra attention to detail on any specific part of the challenge that's appealing to you, but don’t lose sight of the fundamentals. 

# Deliverables

A zip file or GitHub link with your project. We should be able to view the source and build the app using gradle. In the zip file, feel free to include an apk that’s ready to run, and a README if needed.

If you want to use outside sources for parts of your submission, please cite them with a direct URL.

# API

`GET https://hipmunk.com/mobile/coding_challenge`

This endpoint returns a JSON dictionary with a single key “hotels” containing an array of dictionaries with the following keys:

 * `name`: the display name of the hotel
 * `image_url`: URL to a photo of this hotel


Example response:

```json
{
  
  "hotels": [
    {
      "name": "Chippy’s Motel",
      "image_url": "http://.../image.png"
    },
    ...
  ]
}
```
