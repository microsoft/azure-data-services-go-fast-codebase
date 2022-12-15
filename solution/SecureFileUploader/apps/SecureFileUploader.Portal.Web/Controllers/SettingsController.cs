using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Interfaces;
using SecureFileUploader.Portal.Web.Dtos;

namespace SecureFileUploader.Portal.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
[Authorize(AuthenticationSchemes = "EasyAuth")]
public class SettingsController : ControllerBase
{
    private readonly ISettingsService _settingsService;

    public SettingsController(ISettingsService settingsService)
    {
        _settingsService = settingsService;
    }

    /// <summary>
    /// List current System Settings
    /// </summary>
    /// <returns>Current system settings</returns>
    [HttpGet]
    [ProducesResponseType(typeof(Settings), StatusCodes.Status200OK)]
    public async Task<IActionResult> Get()
    {
        var settings = await _settingsService.GetAllCurrentSystemSettingsAsync();

        return Ok(settings);
    }

    [HttpGet]
    [Route("logo")]
    [ProducesResponseType(typeof(SettingsSummary), StatusCodes.Status200OK)]
    public async Task<SettingsSummary> GetLogo()
    {
        var logo = await _settingsService.GetCurrentSystemLogo();

        return new SettingsSummary{
            Logo = logo
        };
    }

    /// <summary>
    ///
    /// </summary>
    /// <param name="settings"></param>
    /// <returns></returns>
    [HttpPut]
    [Consumes("multipart/form-data")]
    [ProducesResponseType(typeof(Guid), StatusCodes.Status201Created)]
    [ProducesResponseType(typeof(BadRequestResult), StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Put([FromForm]Settings settings)
    {
        if (!Enum.IsDefined(typeof(AllowedFileSizeUnits), settings.FileUnit))
        {
            return BadRequest("Invalid FileUnit");
        }

        var id = await _settingsService.UpdateSystemSettingsAsync(settings);

        return Created("/api/settings", id);
    }

}
