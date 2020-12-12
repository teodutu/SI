// TODO ex1.1: Get all the globes references by the ID defined in index.view
import document from "document";
 
// Get all the globes references by the ID defined in index.view
const globes = [
  document.getElementById("bot1"),
  document.getElementById("bot2"),
  document.getElementById("bot3"),
  document.getElementById("bot4"),
  document.getElementById("bot5"),
  document.getElementById("botmid1"),
  document.getElementById("botmid2"),
  document.getElementById("botmid3"),
  document.getElementById("botmid4"),
  document.getElementById("mid1"),
  document.getElementById("mid2"),
  document.getElementById("mid3"),
  document.getElementById("topmid"),
  document.getElementById("top"),
];

// TODO ex1.2: Get the buttons references
const blinkLightsButton = document.getElementById("lights-1");
const slideLightsButton = document.getElementById("lights-2");
const customLightsButton = document.getElementById("lights-3");

// TODO ex1.3: Define colors for each globe's light turned on and turned off
// Colors for each globe's light turned on
const globeOnColor = [
  "#DC143C",
  "#FFA500",
  "#DC143C",
  "#FFA500",
  "#DC143C",
  "#FFA500",
  "#DC143C",
  "#FFA500",
  "#DC143C",
  "#FFA500",
  "#DC143C",
  "#FFA500",
  "#FFA500",
  "#DC143C",
];
 
// Colors for each globe's light turned off
const globeOffColor = [
  "#CD5C5C",
  "#EEE8AA",
  "#CD5C5C",
  "#EEE8AA",
  "#CD5C5C",
  "#EEE8AA",
  "#CD5C5C",
  "#EEE8AA",
  "#CD5C5C",
  "#EEE8AA",
  "#CD5C5C",
  "#EEE8AA",
  "#EEE8AA",
  "#CD5C5C",
];

// TODO ex1.4: Keep evidence of which globe's light is on/off
const globeLightsOn = [
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
  false,
];

// TODO ex2.1: Create a function to turn all globes' lights off
function turnOffLights() {
  let i;
  for (i = 0; i < globes.length; i++) {
    globeLightsOn[i] = false;
    globes[i].style.fill = globeOffColor[i];
  }
}

// TODO ex3.2: Create first button globes' lights show function
function blinkLights() {
  let i;
  for (i = 0; i < globes.length; i++) {
      if (globeLightsOn[i]) {
        globes[i].style.fill = globeOffColor[i];
      } else {
        globes[i].style.fill = globeOnColor[i];
      }
      globeLightsOn[i] = !globeLightsOn[i];
  }
}

// TODO ex4.2: Create second button globes' lights show function
function slideLights() {
    globes[currentGlobeSlide].style.fill = globeOffColor[currentGlobeSlide];
    globeLightsOn[currentGlobeSlide] = false;
 
    currentGlobeSlide = (currentGlobeSlide + 1) % globes.length;
    globes[currentGlobeSlide].style.fill = globeOnColor[currentGlobeSlide];
    globeLightsOn[currentGlobeSlide] = true;
}

// TODO ex5.2: Create third button globes' lights show function
let level = 0;
let levels = {
  0: [0, 1, 2, 3, 4],
  1: [5, 6 ,7, 8],
  2: [9, 10, 11],
  3: [12],
  4: [13]
};
let levelsLen = Object.keys(levels).length;

function customLights() {  
  for (const i of levels[level]) {
    globes[i].style.fill = globeOnColor[i];
  }
  
  let prevLevel = level === 0 ? levelsLen - 1 : level - 1;
  for (const i of levels[prevLevel]) {
    globes[i].style.fill = globeOffColor[i];
  }
 
  level = (level + 1) % levelsLen;
}

// TODO ex3.1: Add an event when the first button is clicked to begin
//             the first lights show. The lights should all turn on and
//             off at a given interval (e.g. 200 ms). If the button is
//             pressed again the lights show should stop.
// We will recycle the same event handler
let intervalHandler = -1;
 
// First button event
blinkLightsButton.addEventListener("click", (evt) => {
  if (intervalHandler == -1) {
    intervalHandler = setInterval(blinkLights, 200);
  } else { // Turn off event and cleanup
    clearInterval(intervalHandler);
    intervalHandler = -1;
    turnOffLights();
  }
});

// TODO ex4.1: Add an event when the second button is clicked to begin
//             the second lights show. Only one light should turn on and
//             off at a given interval (e.g. 200 ms), then next one to it.
//             If the button is pressed again the lights show should stop.
//             If there was a light show already in action, the button will
//             stop it and it needs to be pressed again in order to start
//             the desired light show.
let currentGlobeSlide; // keep track of the current globe for slide lights show
slideLightsButton.addEventListener("click", (evt) => {
  if (intervalHandler == -1) {
    currentGlobeSlide = 0;
    globes[currentGlobeSlide].style.fill = globeOnColor[currentGlobeSlide];
    globeLightsOn[currentGlobeSlide] = true;
 
    intervalHandler = setInterval(slideLights, 200);
  } else { // Turn off event and cleanup
    clearInterval(intervalHandler);
    intervalHandler = -1;
    turnOffLights();
  }
});

// TODO ex5.1: Add an event when the third button is clicked to begin
//             the third lights show. Be creative and implement it as you
//             want.
//             If the button is pressed again the lights show should stop.
//             If there was a light show already in action, the button will
//             stop it and it needs to be pressed again in order to start
//             the desired light show.
customLightsButton.addEventListener("click", (evt) => {
   if (intervalHandler == -1) {
    intervalHandler = setInterval(customLights, 100); // adjust the interval timer
  } else { // Turn off event and cleanup
    clearInterval(intervalHandler);
    intervalHandler = -1;
    turnOffLights();
    level = 0;
  }
});

// TODO ex2.2: Start with all globes' lights turned off
turnOffLights();