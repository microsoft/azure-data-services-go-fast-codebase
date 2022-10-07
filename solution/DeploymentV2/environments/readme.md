
This folder contains the configuration settings and feature flags that determine what a specific ADS Go Fast deployment will be comprised of and into which Azure subscription it will be deployed. It contains two sub-folders which are discussed below:

# Feature Templates Directory
This folder contains a file for each of our "Fast Start Templates". Fast Start Templates provide a currated and pre-defined list of "feature toggles" that can be applied to any deployment. The ADS Go Fast deployment has a number of feature toggles that allow various services and features to be turned on or off depending on the particular needs of a deployment. Rather than select these individually the "fast start templates" provide a quick and efficient way of deploying a pre-defined and often used combination of these feature toggles. The standard fast start templates are listed below. You can add your own by simply copying one of the existing files in this directory and renaming it. 

- full_deployment
- basic_deployment
- full_deployment_no_purview
- functional_tests


# Vars Directory
This director contains a sub-directory for each deployment environment. These folders control the number of "Analytics Landing Zones" that can be deployed by the repository. You can use these folders to allow for multiple environments that will support your SDLC (eg. Development, UAT, Production) and you can also use them to allow for multiple hub / spoke production deployments within a decentralised analytics architecture (Eg, EDW, Finance-Analytics, Operations-Analytics etc.).

Within each of these folders is a file called "common_vars_values.jsonc". This file contains all of the configuration settings specific to a single Analytics Lockbox deployment. For a full explaination of each of various settings refer to the json schema file titled "common_vars_schema.json". Visual Studio Code should provide intellisense and contextual help text based on this schema file.
