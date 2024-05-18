# arduinooo - An Arduino of Our Own


<!-- PROJECT LOGO -->
<br />
<div align="center">
  <a href="https://github.com/phthallo/arduinooo">
    <img src="preview.jpg" alt="The AO3 Logo on the Arduino OLED screen" width="400" height="400">
  </a>
</div>


Very experimental, very jank transformative fanwork viewer (sourced from the Archive of Our Own) using the Arduino UNO and a 0.96" 128x64 graphical SPI SSD1306 OLED Display. More of a proof-of-concept than anything usable :) 

## What it does
Takes a single work ID, then fetches the work from [AO3](https://archiveofourown.org/) and displays its metadata, the author's summary/notes and the work itself on the OLED screen. 

The content of the fanfiction has been truncated into sections due to some technical constraints [^1] - meaning it'll only scroll one section at a time. Pressing the switch at any point will load the next section.

Basically, it's "Can it run Doom?" but for terminally online teenagers. 

https://github.com/phthallo/arduinooo/assets/84078890/dc814895-6ec4-45f5-ac8c-ded58b10df7f



The answer is yes, it can!

### Setup
* [Processing](https://processing.org/) and the [Processing Serial library](https://processing.org/reference/libraries/serial/index.html)
* [Arduino kit](https://www.arduino.cc/)
* [Jsoup library](https://jsoup.org/)
* [Adafruit SSD1306 libraries](https://learn.adafruit.com/monochrome-oled-breakouts/arduino-library-and-examples)

For this project, I used an Arduino UNO microcontroller set which was graciously provided for free by the [University of South Australia](https://study.unisa.edu.au/services-for-schools/experiences/curriculum-linked-education/gender-equity-in-stem/stem-girls-academy/). 
It makes use of the following components:

| Component | Quantity |
| --------- | -------- |
| Arduino UNO | 1 |
| SPI OLED Screen | 1 | 
| Switch | 1 |
| Male-male connecting wires | 8 |
| Breadboard | 1 |

![image](https://github.com/phthallo/arduinooo/assets/84078890/729ddb42-dde9-424b-8043-dcae5230f1ac)


Using Processing in conjunction with the standard Arduino libraries allows internet access without the need for a Wi-Fi shield. Since Processing has Java support, AO3 content can be obtained using Jsoup (a Java library for webscraping) in Processing (`getFic.pde`). This is then sent to the Arduino and its components, using the Serial library. 
Likewise, information from the Arduino (in this case, registering the switch being pressed) can be read in Processing and used to trigger another event (loading the next section of content). 

This requires the Arduino program (`output.ino`) to be uploaded to the Arduino first, then the Processing program to be run when the Arduino IDE is closed (to avoid conflicts with the port).

## Roadmap
- [ ] Back button/switch to navigate backwards 
- [ ] Option to disable scrolling 

 
## Known Issues
* Jsoup only retrieves the first chapter of content 
* getFic doesn't limit button presses to the amount of sections returned; will raise IndexOutofBoundsException if button presses > sections.

## Notes
I've never used Processing (or Java, which it is based on) before this. I've used C++ maybe once before (for another Arduino project), so everything is likely to be very unoptimised.

### Limitations
There is no support for custom text formatting (bold, italics, centre-align etc), or for images/other non-text content embedded in the fic.  


[^1]: The Adafruit SSD1306 library doesn't officially have support for vertical scrolling, but it does have support for horizontal and diagonal ones. My workaround is liable to errors, since it draws text in a negative region to imitate the scrolling effect.
