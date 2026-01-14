// get the ninja-keys element
const ninja = document.querySelector('ninja-keys');

// add the home and posts menu items
ninja.data = [{
    id: "nav-about",
    title: "About",
    section: "Navigation",
    handler: () => {
      window.location.href = "/";
    },
  },{id: "nav-research",
          title: "Research",
          description: "Research",
          section: "Navigation",
          handler: () => {
            window.location.href = "/research/";
          },
        },{id: "nav-discussions",
          title: "Discussions",
          description: "Discussions Slides",
          section: "Navigation",
          handler: () => {
            window.location.href = "/discussion/";
          },
        },{id: "nav-teaching",
          title: "Teaching",
          description: "Materials for courses you taught. Replace this text with your description.",
          section: "Navigation",
          handler: () => {
            window.location.href = "/teaching/";
          },
        },{id: "nav-resources",
          title: "Resources",
          description: "Some interesting materials.",
          section: "Navigation",
          handler: () => {
            window.location.href = "/resources/";
          },
        },];
