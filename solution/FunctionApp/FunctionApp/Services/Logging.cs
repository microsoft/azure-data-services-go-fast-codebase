/*-----------------------------------------------------------------------

 Copyright (c) Microsoft Corporation.
 Licensed under the MIT license.

-----------------------------------------------------------------------*/

using System;
using System.Collections.Generic;
using FunctionApp.Models;
using Microsoft.Extensions.Logging;

namespace FunctionApp.Logging
{
    public class Logging
    {

        public enum LogType : short
        {
            Error = 1,
            Warning = 2,
            Performance = 3,
            Information = 4,
            Debug = 5
        }

        private int _maxLogLevelPersistedToDatabase;
        
        public ActivityLogItem DefaultActivityLogItem { get; set; }
        private ILogger _log;
        private List<ActivityLogItem> _activityLogItems;
        public void InitializeLog(ILogger log, ActivityLogItem defaultActivityLogItem)
        {
            _log = log;
            _activityLogItems = new List<ActivityLogItem>();
            DefaultActivityLogItem = defaultActivityLogItem;
            _maxLogLevelPersistedToDatabase = 5;
        }

        public void LogErrors(Exception e)
        {
            LogErrors(e, new ActivityLogItem(DefaultActivityLogItem));
        }

        public void LogErrors(Exception e, ActivityLogItem activityLogItem)
        {
            activityLogItem.LogTypeId = (short)LogType.Error;
            activityLogItem.Status = "Failed";
            string msg = e.Message;

            if (e.StackTrace != null)
            {
                msg += "; Stack Trace: " + e.StackTrace;
            }

            _log.LogError(msg);
            activityLogItem.Comment = msg;

            LogParamsAndTemplate lpt = activityLogItem.WriteToStandardLog();
            _log.LogError(lpt.Template, lpt.Params.ToArray());

            if (activityLogItem.LogTypeId <= _maxLogLevelPersistedToDatabase)
            { _activityLogItems.Add(activityLogItem); }
        }

        public void LogInformation(string Message)
        {
            LogInformation(Message, new ActivityLogItem(DefaultActivityLogItem));
        }

        public void LogInformation(string Message, ActivityLogItem activityLogItem)
        {
            activityLogItem.LogTypeId = (short)LogType.Information;          
            activityLogItem.Comment = Message;
            LogParamsAndTemplate lpt = activityLogItem.WriteToStandardLog();
            _log.LogInformation(lpt.Template, lpt.Params.ToArray());
            if (activityLogItem.LogTypeId <= _maxLogLevelPersistedToDatabase)
            { _activityLogItems.Add(activityLogItem); }
        }

        public void LogWarning(string Message)
        {
            LogWarning(Message, new ActivityLogItem(DefaultActivityLogItem));
        }
        public void LogWarning(string Message, ActivityLogItem activityLogItem)
        {
            activityLogItem.LogTypeId = (short)LogType.Warning;            
            activityLogItem.Comment = Message;
            LogParamsAndTemplate lpt = activityLogItem.WriteToStandardLog();
            _log.LogWarning(lpt.Template, lpt.Params.ToArray());
            if (activityLogItem.LogTypeId <= _maxLogLevelPersistedToDatabase)
            { _activityLogItems.Add(activityLogItem); }
        }

        public void LogDebug(string Message)
        {
            LogDebug(Message, new ActivityLogItem(DefaultActivityLogItem));
        }
        public void LogDebug(string Message, ActivityLogItem activityLogItem)
        {
            activityLogItem.LogTypeId = (short)LogType.Debug;
            activityLogItem.Comment = Message;
            LogParamsAndTemplate lpt = activityLogItem.WriteToStandardLog();
            _log.LogDebug(lpt.Template, lpt.Params.ToArray());
            if (activityLogItem.LogTypeId <= _maxLogLevelPersistedToDatabase)
            { _activityLogItems.Add(activityLogItem); }
        }

        public void LogPerformance(string Message)
        {
            LogPerformance(Message, new ActivityLogItem(DefaultActivityLogItem));
        }
        public void LogPerformance(string Message, ActivityLogItem activityLogItem)
        {
            activityLogItem.LogTypeId = (short)LogType.Performance;
            activityLogItem.Status = "Performance";
            activityLogItem.Comment = Message;
            LogParamsAndTemplate lpt = activityLogItem.WriteToStandardLog();
            _log.LogInformation(lpt.Template, lpt.Params.ToArray());
            if (activityLogItem.LogTypeId <= _maxLogLevelPersistedToDatabase)
            { _activityLogItems.Add(activityLogItem); }
        }
    }

}
