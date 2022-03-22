# Introduction 
This test harness uses a test json file to simulate the the results that are returned from GetTaskInstanceJson stored procedure. 
The purpose of this test harness is to generate a set of TaskObjects that would be passed into ADF pipelines as input parameters. 
We can then:
- Compare the outputs from this against known expected inputs to make sure we don't introduce regressions over time
- Call pipelines in bulk without having to schedule executions and wait for Azure functions to trigger.