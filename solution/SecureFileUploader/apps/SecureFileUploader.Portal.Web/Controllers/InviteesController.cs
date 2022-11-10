using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SecureFileUploader.Common.Interfaces;
using AccessTokenDto = SecureFileUploader.Common.Dtos.AccessToken;
using Invitee = SecureFileUploader.Common.Dtos.Invitee;

namespace SecureFileUploader.Portal.Web.Controllers;

[Route("api/[controller]")]
[ApiController]
[Authorize(AuthenticationSchemes = "EasyAuth")]
public class InviteesController : ControllerBase
{
    private readonly IInviteeService _inviteeService;
    private readonly IAccessTokenService _tokenService;

    public InviteesController(IInviteeService inviteeService, IAccessTokenService tokenService)
    {
        _inviteeService = inviteeService;
        _tokenService = tokenService;
    }

    /// <summary>
    ///     Retrieves the invitee assigned to the provided id.
    /// </summary>
    /// <param name="id" example="14d30e58-2cf6-46ff-ba72-f88956631785">The id of the invitee to retrieve.</param>
    /// <returns>The invitee assigned to the provided id.</returns>
    /// <response code="200">Returns the invitee assigned to the provided id.</response>
    /// <response code="404">Not found.</response>
    [HttpGet("{id:guid}")]
    [ProducesResponseType(typeof(Invitee), StatusCodes.Status200OK)]
    public async Task<IActionResult> Get(Guid id)
    {
        var invitee = await _inviteeService.GetByIdAsync(id);
        if (invitee == null)
            return NotFound();
        return Ok(invitee);
    }

    /// <summary>
    ///     Create a token by a given Invitee.
    /// </summary>
    /// <param name="id">An Invitee Id</param>
    /// <returns></returns>
    [HttpPost("token/{id:guid}")]
    [ProducesResponseType(typeof(AccessTokenDto), StatusCodes.Status200OK)]
    [ProducesResponseType(StatusCodes.Status400BadRequest)]
    public async Task<IActionResult> Token(Guid id)
    {
        try
        {
            var token = await _tokenService.GenerateForInviteeAsync(id);

            return Ok(token);
        }
        catch (Exception e)
        {
            return StatusCode(400, "Unable to create token for user.");
        }
    }
}
