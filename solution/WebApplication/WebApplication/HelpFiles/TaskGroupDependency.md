## TaskGroupDependency


This table describes the dependency between 2 TaskGroups. In order for one task to depend on another, the following configuration must be established:
* a row in the TaskGroupDependency table - with a reference to the Ancestor and Descendent task groups
* for each pair of dependent tasks (one from each group) - a matching value in the TaskMaster row for each task. This should be a value unique to this pairing - eg, a Table name, or filename.

The current dependency types available are:
* TasksMatchedByTagAndSchedule