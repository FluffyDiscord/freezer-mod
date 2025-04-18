# Factorio freezer mod fork
Fork of the original Freezer mod with a few bugfixes

Changes made with respect to the original mod:
- Changed the structure of the refrigerator to primarily place the chest instead of the energy interface to fix multiple of bugs when using refrigerators in blueprints
- Fixed crash when deconstructing a cryogenic wagon with a ghost in the equipment grid
- Added a limit of 0% productivity to the melting recipes to prevent infinite production loops with furnaces that already have productivity modules in them befor starting the recipe or modded furnaces with a base productivity
- Uses PlanetLibs temperature system instead of a proprietary one
- Added Refrigerators with logistics support

Original Mod page: https://mods.factorio.com/mod/freezer

Freezing

Freeze water into ice. 
Enclose items in ice to slow spoiling. 
Store spoilables in a refrigerator to stop spoiling completely. 
Fridges draw power based on ambient temperature. Also adds cooled wagons.

- Freeze water into ice.
- Enclose items in ice to slow spoiling.
- Adjustable ice effectiveness (default 5X slowdown)
- Spoilables do not spoil while inside a powered refrigerator.
- Wagons, that cool contents like refrigerators, but draw power from equipment grid.
- Dynamic mod support: graphics and spoilage times generated automatically.

![](/sources/Freeze0.png)
![](/sources/Freeze1.png)
![](/sources/Freeze2.png)
![](/sources/Freeze3.png)
