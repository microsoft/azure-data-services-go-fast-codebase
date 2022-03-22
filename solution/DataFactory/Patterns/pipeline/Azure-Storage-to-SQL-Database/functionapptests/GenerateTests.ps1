$testfile = "./tests/tests.json"
jsonnet "./GenerateTests.jsonnet" | Set-Content($testfile)
Copy-Item -Path $testfile -Destination '../../../../../FunctionApp/consoleapp/UnitTests/tests.json'