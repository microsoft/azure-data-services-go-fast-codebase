using System;
using System.Threading.Tasks;

namespace SecureFileUploader.Functions.Interfaces;

public interface IProgramCommencementCheckService
{
    Task MarkProgramCommencementAsync(DateTime commencementDate);
}
