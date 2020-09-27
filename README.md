# FKArchitectureGeneratorCLI

It's a command line interface tool that produces MVVM and VIPER boilerplate modules and configurations.

You can check FKArchitectureGeneratorCLI out for details on [Medium story](https://medium.com/@furkan.kaplan/architecture-module-generator-for-ios-3c043519b2f7).


 ## How to use
 
 <img src="https://github.com/furkankaplan/fk-architecture-generator-cli-macos/blob/master/fk-architecture-generator-cli-macos/Screenshots/example.png">
 
 There are two supported architectural pattern FKArchitectureGeneratorCLI has. These are MVVM and VIPER. You can just produce MVVM by typing below
 
 ```
 fk mvvm GitHub
 ```
 
 You can change the `GitHub` keyword to change module name with whatever you want. 
 
 ## Optional
 
 FKArchitectureGeneratorCLI add a mark as a default to each swift file indicating this module created with this cli. You can hide this mark by adding the flag -u/--unmarked
 
 `fk mvvm ModuleName -u` or `fk mvvm ModuleName -unmarked` 
