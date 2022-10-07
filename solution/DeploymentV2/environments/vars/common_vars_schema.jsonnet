local schema = import './common_vars_schema.json';

local properties = schema["properties"];

{
  "SchemaTableForMarkDown":   [  // Object comprehension.
              {
                  ["1.PROPERTY"]: sd,
                  ["2.TYPE"]: properties[sd]["type"],
                  ["3.DESCRIPTION"]: properties[sd]["description"],

                  #["Examples"]: properties[sd]["examples"],
              }
              for sd in std.objectFields(properties)
            ]
}