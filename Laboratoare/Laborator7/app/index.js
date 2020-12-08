import clock from "clock";
import document from "document";
import { preferences } from "user-settings";
import * as util from "../common/utils";

// TODO ex4.1: import heart-rate, power and user-activity APIs
import { HeartRateSensor } from "heart-rate";
import { battery } from "power";
import { today } from "user-activity";

// Update the clock every minute
clock.granularity = "seconds";

// Get a handle on the clock text element
const clockLabel = document.getElementById("clock");

// Get arcs UI elements and create an array with them
const arcSteps = document.getElementById("steps");

// TODO ex2.1: get the rest of UI elements for hr, floors
//             and battery, then add them to an array
const arcHR = document.getElementById("hr");
const arcFloors = document.getElementById("floors");
const arcBattery = document.getElementById("battery");
const arcs = [arcSteps, arcHR, arcFloors, arcBattery];

// TODO ex2.2: create an array with 4 colors, one for each
//             one for each of the 4 stats
const arcColors = ["darkturquoise", "fb-red", "orange", "limegreen"];

// current selected stat
let currStat;

// Get a handle on the stat text element
const statLabel = document.getElementById("stat");
const statNames = ["Steps", "HR", "Floors", "Battery"]

// Get a handle to the invisible rectangle which is responsible for the click/tap event
const statButton = document.getElementById("statbutton");

// TODO ex2.3: complete the function such that at start-up
//             it will select the steps as the initial displayed stat
//             Set the label and the color for it
function initializeStat() {
  currStat = 0;
  arcs[0].style.fill = arcColors[0];
  statLabel.text = `${statNames[0]}: ${today.adjusted.steps}`; // this has been changed
  statLabel.style.fill = arcColors[0];
}
// TODO ex3: This function should change the stat after screen click/tap
//           Change it back to the color white if the stat is deselected
//           and set up the new stat's color and label
function changeStat() {
  arcs[currStat].style.fill = "white";
  currStat = (currStat + 1) % 4;
 
  arcs[currStat].style.fill = arcColors[currStat];
 
  statLabel.style.fill = arcColors[currStat];
 
  // this will change the stat label, don't remove
  fillInStatLabel();
}

// heart-rate to conserve the instantiated object between multiple calls
let hrm = undefined;

// TODO ex4.2: Fill in the stat label by querying the current selected stat
//             Use a switch statement and set the label for each case
function fillInStatLabel() {
  switch(currStat) {
    case 0: // Steps
      statLabel.text = `${statNames[currStat]}: ${today.adjusted.steps}`;
      break;
    case 1: // HR
      if (HeartRateSensor && !hrm) {
        hrm = new HeartRateSensor({ frequency: 1 });
        hrm.start();
      }
 
      const hrmStr = hrm.heartRate == null ? '--' : `${hrm.heartRate}`;
      statLabel.text = `${statNames[currStat]}: ${hrmStr}`;
 
      break;
    case 2: // Floors
      statLabel.text = `${statNames[currStat]}: ${today.adjusted.elevationGain}`;
      break;
    case 3: // Battery
      statLabel.text = `${statNames[currStat]}: ${Math.floor(battery.chargeLevel)}%`;
      break;
  }
}

// Every tick, update the clock text element with the current time
// and the stat value with the updated one
clock.ontick = (evt) => {
  let today = evt.date;
  let hours = today.getHours();
  if (preferences.clockDisplay === "12h") {
    // 12h format
    hours = hours % 12 || 12;
  } else {
    // 24h format
    hours = util.zeroPad(hours);
  }
  let mins = util.zeroPad(today.getMinutes());
  clockLabel.text = `${hours}:${mins}`;
  
  fillInStatLabel();
}

// add event listener for tapping the screen (i.e. the rectangle)
statButton.addEventListener('click', changeStat);

// get started with the first stat in place
initializeStat();
