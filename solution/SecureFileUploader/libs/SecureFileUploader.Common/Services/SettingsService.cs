using AutoMapper;
using Microsoft.EntityFrameworkCore;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Data;
using SettingsDto = SecureFileUploader.Common.Dtos.Settings;
using SettingsModel = SecureFileUploader.Data.Models.Settings;

namespace SecureFileUploader.Common.Services;

public class SettingsService : ISettingsService
{
    private readonly IMapper _mapper;
    private readonly SecureFileUploaderContext _secureFileUploaderContext;
    private readonly ICreateSettingsService _createSettingsService;

    public SettingsService(
        IMapper mapper,
        SecureFileUploaderContext secureFileUploaderContext,
        ICreateSettingsService createSettingsService
    )
    {
        _mapper = mapper;
        _secureFileUploaderContext = secureFileUploaderContext;
        _createSettingsService = createSettingsService;
    }

    /// <summary>
    /// For a given Token, see if the attached Program has a Settings Snapshot - otherwise just return the current
    /// Settings
    /// </summary>
    /// <returns>Latest settings for a program, otherwise the latest system settings</returns>
    public async Task<SettingsDto> GetAllCurrentSettingsForProgramAsync(Guid programId)
    {
        var settingsSnapshot = await _secureFileUploaderContext.ProgramSettingsSnapshot
            .OrderByDescending(x => x.SnapshotOn)
            .Where(x => x.Program.Id == programId)
            .FirstOrDefaultAsync();

        if (settingsSnapshot != null)
        {
            return _mapper.Map<SettingsDto>(settingsSnapshot.Settings);
        }

        return await FindLatestSystemSettings();
    }

    /// <summary>
    /// Find the latest system settings
    /// </summary>
    /// <returns>The latest system settings</returns>
    public async Task<SettingsDto> GetAllCurrentSystemSettingsAsync() =>
        await FindLatestSystemSettings();

    private async Task<SettingsDto> FindLatestSystemSettings()
    {
        var settings = await _secureFileUploaderContext.Settings
            .OrderByDescending(x => x.LastModifiedOn)
            .FirstOrDefaultAsync();

        return _mapper.Map<SettingsDto>(settings);
    }

    public async Task<string> GetCurrentSystemLogo()
    {
        var logo = await _secureFileUploaderContext.Settings
            .OrderByDescending(x => x.LastModifiedOn)
            .Select(x => x.PhnLogo)
            .FirstOrDefaultAsync();

        return Convert.ToBase64String(logo);
    }

    /// <summary>
    /// Update System Settings by inserting a new row
    /// </summary>
    /// <param name="settings">new settings</param>
    /// <returns></returns>
    public async Task<Guid> UpdateSystemSettingsAsync(SettingsDto settings)
    {
        var newSettings = await _createSettingsService.InsertSettingsDataAsync(settings);
        await _secureFileUploaderContext.SaveChangesAsync();
        // Id for now, do we care about the full DTO?
        return newSettings.Id;
    }
}
