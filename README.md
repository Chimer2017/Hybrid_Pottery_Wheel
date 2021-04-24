
# Hybrid Pottery Wheel 

## The Idea:

When I was a kid, my dad always let me take apart his old computers. There is something surreal and critical in physical experiences that no virtual environment can stimulate. However, the conveniences of the virtual realm cannot be overlooked. Items and activities that were once inaccessible and ludicrous are now within reach. You can tour far away places; speak with celebrities; you name it - probably exists. How about pottery. I took a pottery-making class. I don't mean to flex, but it was absurdly fun. At the same time, it is messy and requires a bunch of resources and as a result, it's not that accessible of an activity and art form. Comes in digital pottery. No mess and no need to buy expensive clay and throwing wheels, but it lacks the physical experience of shaping. You can push and pull pots on a screen, but it is just not the same. This was the inspiration for my idea. I wanted to create something that blends physical and digital. I want users to still have a physical experience crafting with the conveniences of the virtual environment.

## The Specifics:

With an idea in mind, I set off to create a physical pottery wheel that takes in physical user input and manipulates a digital model of clay. Think racing video games, except the remote control is a pottery wheel instead of a racing wheel and the racecar is actually clay.

## How I Built It:

This project requires a good amount of materials and tools to design and build.

### Materials
- Stepper Motor ( to drive the pottery wheel)
- Stepper Motor Relay
- ESP-32
- 3D printed throwing wheel design
- 3D printer filament
- 3x Pressure Sensors
- Tons of wires and 10k Ohm resistors
- Tape (lots of tape)

### Hardware

The first step in this project was getting all the hardware working. Before any wiring or electronics were implemented, I had to print the enclosure. The enclosure was the body of the pottery wheel. This included the base as wheel as the wheel. I used an open-source design for this part. Model files can be found here.

Now, once the enclosure was printed, it was time to start wiring things up. The first part was to get all the pressure sensors working. These pressure sensors were wired up and then tested using serial print. For this project, I ended up using three pressure sensors. To mimic the push and pull motions in physical pottery making, I placed two sensors on the outside of the wheel and one sensor in the middle of the wheel.




The two sensors on the outside represent a pulling or widening motion while pressing the center is equivalent to a pushing or narrowing motion. The next step in the hardware process was getting the disk to spin. This was straightforward enough. Just set the wheel to spin continuously, however, I quickly ran into some issues. No matter which way I threaded the wiring of the pressure sensors, they would start to loop over themselves and pull out. So, I had to come up with another solution that would mimic the rotating motion of the wheel that would also not self-destruct the device.  I settled on a clockwise - counterclockwise motion. The spinning wheel would rotate back and forth about 30 degrees at a medium speed. The pressure sensors are constantly moving and it feels like the wheel is spinning, but this way the wires stay intact.

### Software




This was the next part of the project and most critical: the 3D ceramic model. The idea for this was to have a perfect replica of clay and then you could push and pull at will; however; every time I start one of these projects I realize I am a bit naive. No matter, small adjustments to the dream were made. From testing the pressure sensors, it became quickly apparent that their sensitivity frankly isn't very sensitive. It's more of a switch than a sensor. So any fine increments in the model were impossible to map to user inputs. Instead, I found a model online that builds 3D shapes layer by layer and manipulated the code to allow user input to increase and decrease radius. In essence, the software model grows at a constant rate, stacking slice after slice to build a 3D shape. The user can manipulate the diameter or the circumference of the shape. It leads to some very interesting designs. Here is an example.




*** Much of the code was inspired/based on this repo: https://github.com/nylki/potterswheel




Now, this is where things get cool. Once a user is happy with his or her design, they press "r" on the keyboard, and the model is saved as a .obj file. This file can then be imported into 3d printing software and printed. So an end-to-end cycle is possible: use the wheel to model a digital pottery piece and then 3D print it. The only issue is the stacking mechanism doesn't create truly manifold shapes, so minor adjustments still need to be made to the model. I could see this being a cool hybrid digital/physical toy for kids.




## Technical Obstacles

There were so many small technical obstacles that slowly altered the original idea. None of them were enormous, but for example, the issue regarding tangling worse required altering the motion of the wheel that is not entirely authentic to the physical experience. These issues could definitely be fixed. I believed my design is an okay prototype and provides a basis on which to improve. For example, have pivot contacts for the pressure sensors so the wheel can spin continuously in one direction. I would also reconsider using pressure as the input mechanism. Maybe ultrasonic sensors may be more accurate and natural to the experience of pottery making.




Here are some examples of the project in action:

First, the example of the pottery model

https://youtu.be/NkbFiTU-9vA

Next, here is an example of me making an object

https://youtu.be/lxy4daV4zs4



## In Conclusion

I loved this project. It was challenging and fun and rewarding and honestly maybe not a bad idea for a toy. Let me know if you have any questions or have suggestions. 


