<img width=250px src="https://atsign.dev/assets/img/atPlatform_logo_gray.svg?sanitize=true">

# atWwavi

Think of atWavi as a public space for your business, your projects, or
yourself. Provide as little or as much information as you want on your
profile, which will be made available to the public on our directory
(http://wavi.ng). You can opt to publish contact information, location,
media, social media links, even gamer tags. You have total control over
what other people see about you.

## Who is this for?

We have open sourced the @‎wavi mobile and desk app so that you can see how apps on The atPlatform
work. We also welcome issues and pull requests so that we can make atWavi
better.

To access map and location search:
 - Create `.env` file in the root of the project.
 - And add these lines in the `.env` file.
 ```
MAP_KEY = '<insert_your_map_key_here>' 
API_KEY = '<insert_your_api_key_here>'
 ```

### Steps to get mapKey

  - Go to https://cloud.maptiler.com/maps/streets/
  - Click on `sign in` or `create a free account`
  - Come back to https://cloud.maptiler.com/maps/streets/ if not redirected automatically
  - Get your key from your `Embeddable viewer` input text box 
    - Eg : https://api.maptiler.com/maps/streets/?key=<YOUR_MAP_KEY>#-0.1/-2.80318/-38.08702
  - Copy <YOUR_MAP_KEY> and use it.

### Steps to get apiKey

  - Go to https://developer.here.com/tutorials/getting-here-credentials/ and follow the steps

### Contributing

[CONTRIBUTING.md](CONTRIBUTING.md) has detailed guidance on how to make a
pull request.

## Maintainers

Created by [@sarika01](https://github.com/sarika01),
[@sachins-geekyants](https://github.com/sachins-geekyants)
and [@nitesh2599](https://github.com/nitesh2599)
