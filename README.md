Project for CMPM179, 2025 Summer

Current design questions:
- I'm coding this game in a more functional/procedural style (?) (ian used the terms prodecural/declarative/paradigm), instead of using OOP. what are some foreseeable roadblocks that may arise from this decision?
- Should i switch to OOP???
- How do I differentiate between data/varaibles that goes into the global module, and those kept inside plant.lua, for example?
- What is the purpose of calling init functions (e.g. plant.initPlantData() inside main) at load? Should I call a function to initialize my global variables, instead of just declaring them right inside the module?? (I feel like the answer is yes, considering i see this practice a lot in other people's codes. i just need to figure out why this is necessary)
- does my method of keeping track of plants, ui, interactables etc. (using a global table) open up to issues? will this method hold up in larger projects? what are other ways to do this; in ways that i can understand?