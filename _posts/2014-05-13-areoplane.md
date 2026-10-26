---
title: "Areoplane, the Mars exploration vehicle"
date: 2014-05-13 11:50:23 +0000
slug: areoplane
excerpt: "Introduction With the ideas of manned Mars exploration gaining momentum, in this article we set out design underpinnings for Aareoplane, a fast and reliable vehicle for the Martian environment. Though reminiscent of the…"
tags: ["Space"]
---

<!-- original_nid: 22 -->

![](/assets/articles/areoplane/marsairplane-small.jpg "Ares: Mars airplane by NASA")**Introduction**

With the ideas of manned Mars exploration gaining momentum, in this article we set out design underpinnings for Aareoplane, a fast and reliable vehicle for the Martian environment. Though reminiscent of the recent NASA's [ARES Mars Mission](http://marsairplane.larc.nasa.gov/) project, our idea of a versatile autonomous Martian aircraft differs totally in its implementation principles. We argue that the key technologies needed for building such a vehicle already exist. This means, one can look forward new exciting chapters in the history of space settlement which is being written on the fourth planet of the Solar System right now.

Since the dawn of the Space Age in 1960s, the topic of Mars exploration and colonization has been drawing a lot of attention. One important question here is the transportation on Mars, for which rovers have been typically considered. The total Martian surface area is just slightly less than the total area of Earth’s dry land, and thus the distances over which the Mars exploratory equipment has to be moved are quite significant. In face of that, having rovers as the only means of Martian transportation is just too restrictive, given their range of action, speed, and dependency on the surface relief.

**Choice of type of vehicle**

Mars has atmosphere, and thus the idea of air transportation suggests itself. The benefits of this kind of transport are clear: independence of the surface relief and speed ranges unbeatable by surface vehicles are just a few of them. The feasibility of this means of transport is not certain however, since the atmosphere on Mars has about 1% density of Earth’s atmosphere, resulting in the proportional loss of the ascensional power of wings.

Still, we believe that some type of aircrafts will be feasible on Mars, namely the ground effect vehicles. The lift in such vehicles is produced not only by the wings but also by the air cushion, emerging between the body of the aircraft and the ground surface on low flight altitudes. Ground effect vehicles are known for the following benefits:

● No need of a runway, when moving on an air cushion with circulation control wings.

● High fuel efficiency and high carrying capacity due to the ground effect supporting the lift of the wings.

● The kind of ground is almost indifferent for ground effect.

● Typically equipped with multiple engines, ground effect vehicles are relatively safe, since a failure of one engine can be compensated for by the remaining ones.

● Powerful ground effect vehicles are able to switch to a usual airplane mode for a limited time, raising tens and hundreds meters above the height at which the ground effect is noticeable. This brings a high degree of surface relief independence.

● Velocity ranges from hovering in one place to high speeds.

Some decades ago Soviet engineers have been devising various cargo and passenger ground effect vehicles (known as “Ekranoplans”) of giant size, capable of carrying up to 4000 tons of load.

![Ekranoplan - the dream of the Soviet](/assets/articles/areoplane/Ekranoplan_sovet_giant.jpg "Ekranoplan - the dream of the Soviet")

No ekranoplans of these dimensions have ever been built, however. Still, the tonnage of the machines that have been built and tested exceeds by far the carrying capacity of any other types of aircrafts. The turbojet ekranoplan dubbed the “Caspian Sea Monster” (carrying capacity ca. 500 tons), and the propeller-based A-90 “Orlyonok” are good examples of such heavy lift aircrafts.

<div class="carousel" id="carousel-2014-05-13-areoplane-1">
  <div class="carousel-track">
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/km-4.jpg" alt="“Caspian Sea Monster”" loading="lazy">
      <figcaption>“Caspian Sea Monster”</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/358082_600_0.jpg" alt="A-90 “Orlyonok” above ground" loading="lazy">
      <figcaption>A-90 “Orlyonok” above ground</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/Orlenok.jpg" alt="A-90 “Orlyonok”, view on top" loading="lazy">
      <figcaption>A-90 “Orlyonok”, view on top</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/ekranoplan_8_orlenok.jpg" alt="A-90 “Orlyonok”, discharge the cargo" loading="lazy">
      <figcaption>A-90 “Orlyonok”, discharge the cargo</figcaption>
    </figure>
  </div>
  <button class="carousel-prev" aria-label="Previous image">&#8249;</button>
  <button class="carousel-next" aria-label="Next image">&#8250;</button>
  <div class="carousel-dots"></div>
</div>


The ground effect vehicle can carry much load on board, including scientific equipment, power units, rovers and all other systems necessary for long-haul flights. Such a vehicle as Martian ekranoplan we propose to call “**Areoplane**”.

Making use of the ground effect on Mars is connected with certain difficulties, which however can be remedied by the current technologies.

### **Thermal protection**

It is known that the super-sonic speed of a vehicle causes considerable air compression in front of it. This compression causes heating of the swished air stream, which in turn heats the vehicle itself.  According to the available data, the atmosphere density on Mars corresponds to the speed of sound ranging from ca. 100 m/s in the highland volcanic plateau of the Tharsis region to 230 m/s in Hellas Planitia and the region of Valles Marineris.

The current technology used for terrestrial hyper-sonic planes should be sufficient to cope with this effect. The problem of heat protection has been solved for NASA Space Shuttles and for the Soviet shuttle vehicles Burans, using heat-resistant metal ceramic coverage (C/C composite with the coverage of silicon carbide or metal, for example niobium or boron). Although those spacecrafts have been designed for short-time overheating cycles, it is conceivable that an additional cooling system beneath the heat resistant layer (say, liquid cooling) can be used to mitigate the effect of constant overheating.

<div class="carousel" id="carousel-2014-05-13-areoplane-1">
  <div class="carousel-track">
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/ReEntry_Space_Shuttle.jpg" alt="Aeroheating by reentry of Space Shuttle" loading="lazy">
      <figcaption>Aeroheating by reentry of Space Shuttle</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/supersonic-china-delivery-vehicle.si_.jpg" alt="Aeroheating of a hyper-sonic missile" loading="lazy">
      <figcaption>Aeroheating of a hyper-sonic missile</figcaption>
    </figure>
  </div>
  <button class="carousel-prev" aria-label="Previous image">&#8249;</button>
  <button class="carousel-next" aria-label="Next image">&#8250;</button>
  <div class="carousel-dots"></div>
</div>


### **Propulsion**

A crucial aspect for Martial vehicles is the propulsion principle. The choice is not easy. Rocket engines require large amounts of fuel and yet larger supplies of oxidizer. On Earth, the atmosphere oxygen suffices to make the fuel burn. Unfortunately, Mars atmosphere contains almost no free oxygen, thus rendering jet propulsion not feasible. Another source of thrust utilized by many aircrafts on Earth is propeller engines. We believe that such engines are most efficient for the long-term usage on Mars. Propellers can be powered by electric motors connected to a central power unit. It is not surprising that this type of engines also has significant issues in the Martian conditions. It is well-known that achieving sonic speeds with this propulsion plant is complicated, due to disruptive shock waves and turbulence affecting propellers on transonic speeds and to overheating of vehicle parts in the super-sonic speed range.

The problem of extremely high dynamic load of blades has been successfully solved already in the twentieth century using propfans, means propeller engines with broad curved “scimitar”-shaped blades. Such airscrews have high energy conversion efficiency on transonic and super-sonic flight speeds, comparable with that of usual airscrews at lower speed ranges.

<div class="carousel" id="carousel-2014-05-13-areoplane-2">
  <div class="carousel-track">
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/200px-Swept-propeller7.svg_.png" alt="A scimitar propeller is shaped like a scimitar sword, with increasing sweep along the leading edge." loading="lazy">
      <figcaption>A scimitar propeller is shaped like a scimitar sword, with increasing sweep along the leading edge.</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/dlaA400.jpg" alt="A modern propeller with scimitar-shaped blades for Airbus A-400M" loading="lazy">
      <figcaption>A modern propeller with scimitar-shaped blades for Airbus A-400M</figcaption>
    </figure>
  </div>
  <button class="carousel-prev" aria-label="Previous image">&#8249;</button>
  <button class="carousel-next" aria-label="Next image">&#8250;</button>
  <div class="carousel-dots"></div>
</div>


As disadvantages of such propellers count the high complexity of modeling and increased noise levels. The latter shortcoming will probably not overly disturb Mars explorers though.

A more serious problem of such propulsion engines in the conditions of rarefied Mars’s atmosphere is the size of the blades. To ensure the required thrust the propeller blades must be much larger than those of the modern jumbo Airbus A-400M, reaching up to 15 m in diameter. The reason is that thrust is proportional to the diameter of the airscrew in the fourth power, and only depends quadratically on the rotation speed. That is, the propeller diameter is by far the most efficient way of boosting thrust. Further measures include increasing the rotation speed, using multiple coaxial propellers with different directions of rotation and installing more engines.

Moreover, tiltrotors can be used to facilitate the take-off and landing of the vehicle and improve its flight characteristics, compensating for the large rotor impact, like in the U.S. convertiplane Bell Boeing V-22 "Osprey".

<div class="carousel" id="carousel-2014-05-13-areoplane-2">
  <div class="carousel-track">
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/4226-1d047e20.jpg" alt="Two huge rotors of “Osprey” are ready for take-off" loading="lazy">
      <figcaption>Two huge rotors of “Osprey” are ready for take-off</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/normal_0_57379_6209887f_xl.jpeg" alt="“Osprey” horizontal flight" loading="lazy">
      <figcaption>“Osprey” horizontal flight</figcaption>
    </figure>
  </div>
  <button class="carousel-prev" aria-label="Previous image">&#8249;</button>
  <button class="carousel-next" aria-label="Next image">&#8250;</button>
  <div class="carousel-dots"></div>
</div>


It is important to note that the hyper-sonic propellers would require a thermo-resistant layer to be an integral part of the blades, in contrast to the fuselage protection, where detachable composite plates are used.

### **Energy source**

Given the requirements of the high rotation speed, increased size and the number of propellers and topped by the long-term energy independence concern, the use of nuclear power on martian ekranoplans seems justified. ![TU-95](/assets/articles/areoplane/800px-Tupolev_Tu-95_in_flight.jpg) It should be mentioned that airplanes with nuclear power units have been tested both in the USSR and in the USA in the 1950s. Back then, it was recognized that such an aircraft would be just too insecure, due to the lack of sufficiently light and efficient radiation protection for the crew and for the environment in case of wreck.

In the USSR, the prototype for flight tests has been developed on the basis of the bomber “TU-95LAL” shown on the image left. It is perhaps worth mentioning, that this aircraft was equipped, by chance, with the super-sonic propellers.

Radioactivity protection has become more efficient and lighter since 1950s. Moreover, an atomic reactor on Mars poses a much lesser risk than that on a terrestrial aircraft.

### **Delivery to Mars**

We turn to issues associated with the delivery of a large vehicle to Mars.

### **Entering the Mars’ atmosphere.**

A less problematic part of the delivery process should be entering the Mars atmosphere. The reason is that the aircraft must be sufficiently protected from overheating anyway. The process should be similar to that when a Space Shuttle leaves or enters the atmosphere of Earth. Moreover, the entry velocity at which the aircraft will be approaching Mars using the elliptical Hohmann transfer orbit is approx. 5 km/sec. This is more than twice as low as the escape velocity on Earth (approx. 11 km/sec), and also lower than the first cosmic velocity (circular velocity) of Earth, which is approx. 8 km/sec. Consequently, the requirements to thermal protection for approaching Mars are milder than those Space Shuttles and Burans had to satisfy.

Conceivably, removable protective covers could be used for certain parts of vessel most affected by aeroheating, such as prow, bottom and the large propellers. This additional protection can be indispensable for the few minutes of initial braking effect when entering the Martian atmosphere at the second cosmic velocity. The own thermal protection of the vehicle should suffice at all other phases of the fligth to Mars.

### **Take-off into Space from Earth.**

One of the main problems of such a project is the current lack of heavy launch vehicles for taking a jumbo Areoplane to Space from the surface of Earth.

The solution could be to decompose the aircraft and its load into smaller modules and to finalise the assembly on the Earth’s orbit, in the automatic or in human-assisted mode. In the latter case, the cockpit and the cabin of the aircraft could host cosmonauts during this assembly process, serving a kind of temporary orbital station for them.

To estimate the number of parts the ekranoplan has to be decomposed into for the on-orbit assembly, let us survey the heavy launchers known to-date.

Numerous heavy launcher projects have been considered and developed in the USA: the “Nova” and “Saturn” launch vehicle family date back to 1970s, and “Magna” was developed in 1990s. Nowadays, the private company SpaceX cooperates with NASA to create a new heavy lift launch vehicle project Falcon 9 Heavy. Furthermore, in the year 2017 NASA promises to build its Space Launch System (SLS).

<div class="carousel" id="carousel-2014-05-13-areoplane-3">
  <div class="carousel-track">
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/747px-Nova_Rocket.jpg" alt="Comparison Saturn I and V vs. Nova" loading="lazy">
      <figcaption>Comparison Saturn I and V vs. Nova</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/SLS.jpg" alt="Artist&#x27;s concept of an SLS launch." loading="lazy">
      <figcaption>Artist's concept of an SLS launch.</figcaption>
    </figure>
  </div>
  <button class="carousel-prev" aria-label="Previous image">&#8249;</button>
  <button class="carousel-next" aria-label="Next image">&#8250;</button>
  <div class="carousel-dots"></div>
</div>


The name «Nova» has been used in more than thirty projects of heavy rockets. Thus, the «Nova» design by Martin Marietta should have used fourteen F-1 engines at the first stage and take up to 300 tons to the Low Earth orbit, almost three times as much as Saturn V. In reality, only the “Saturns” have been built, notably the Saturn V launcher for the Moon project, capable of carrying up to 141 tons to the Low Earth orbit. Space Launch System (SLS), which NASA is being currently developing, will have the carrying capacity of up to 130 tons.

In the USSR, the efforts put into building powerful launch vehicles were no less significant. The heavy launcher models include N1F (up to 100 tons), UR-700 (150 – 230 tons planned), Energia (105 tons), Vulcan (up to 200 tons planned). Only N1 and Energia have been brought to the flight test phase, and only Energia project survived the flight testing. The follow-up project should have been Vulcan, a modification of Energia with the forced central block of the launcher and an increased number of side booster modules called “Zenit”: eight against the four such side boosters in Energia. The launcher complex was designed for flexibility achieved by varying the number of rocket stages and the number of side boosters.

<div class="carousel" id="carousel-2014-05-13-areoplane-4">
  <div class="carousel-track">
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/Buran.jpg" alt="Energia launch with the shuttle vehicle Buran" loading="lazy">
      <figcaption>Energia launch with the shuttle vehicle Buran</figcaption>
    </figure>
    <figure class="carousel-slide">
      <img src="/assets/articles/areoplane/Vulkan.jpg" alt="An artistic reconstruction of Vulcan launch." loading="lazy">
      <figcaption>An artistic reconstruction of Vulcan launch.</figcaption>
    </figure>
  </div>
  <button class="carousel-prev" aria-label="Previous image">&#8249;</button>
  <button class="carousel-next" aria-label="Next image">&#8250;</button>
  <div class="carousel-dots"></div>
</div>


The project has been frozen as a consequence of the USSR breakup and the dramatic funding cuts that followed. The ill fate of Vulcan was suspending the project just few steps before entering the flight test phase. The “RKK Energia” construction bureau, the developer of both Energia and Vulcan launch vehicles has claimed 2008 that it was ready to complete the project in six years, provided that an adequate funding becomes available. Thus, the revival of the program is still possible, despite the funding allotted by the Russian government to other launcher programs, with lower carrying capacity.

### **Departure to Mars.**

After the main parts of Areoplane are delivered to the Earth orbit, the vehicle will be assembled and filled with the necessary payload, such as scientific equipment, on-board Mars rovers and so forth. After the subsequent thorough testing phase, a launching module filled with fuel will be attached to the vehicle. When everything is set up, the crew would leave the Areoplane and seal it.

The vessel will then start off to Mars in the fully automatic mode. Chemical rocket engines or ion thrusters can be then used for this phase, and the most energy-efficient trace known as Hohmann transfer orbit should be taken.

Upon landing on Mars, the Areoplane can start its exploratory program with the help of the on-board rovers which can be brought to any spot of the planet’s surface. This mode should continue until the eventual manned mission reaches Mars and is able to use the vehicle in the piloted mode.

### **Benefits of the project**

We have outlined the ideas underpinning a possible design of Areoplane, a Martian ground effect vehicle. It is a versatile long-haul autonomous aircraft capable of moving large loads between distant locations on Mars. We estimate that the speed of Martian ekranoplan can reach 500 km/h with the 240 tons total mass. This is possible due to low gravity: on Mars, the gravity acceleration constant constitutes only 3,7 m/sec2 as opposed to 9,8 m/sec2 on Earth. This makes the effective weight of the loaded vehicle on Mars equivalent to only 90 tons on Earth.

Areoplane will make possible the exploration of Mars with only few rovers, which will be moved by aircraft from one location to another, depending on research needs. Compared to sending multiple rover missions to Mars for exploring isolated small areas of the planet, Areoplane could actually save costs. The vehicle can reach Mars long before the eventual manned expedition and even before any settlement building activities. Remotely controlled from Eearth, it can perform a thorough exploration of Mars surface and its mineral resources, thus determining the optimal locations for Mars settlements. Besides exploration, such a vehicle can be then used for construction works, salvation operations and much more, with the on-board power plant being a useful energy source for any activities required in the future.

This has been our vision of the Areoplane, aircraft with high carrying capacity, which can set a new milestone in the history of the Red Planet settlement.

Petr Solovyev

17.02.2014
