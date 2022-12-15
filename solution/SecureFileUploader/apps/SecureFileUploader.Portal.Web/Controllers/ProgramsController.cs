using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Mvc;
using SecureFileUploader.Common.Dtos;
using SecureFileUploader.Common.Services;
using SecureFileUploader.Portal.Web.Dtos;
using SecureFileUploader.Portal.Web.Dtos.Request;
using SecureFileUploader.Portal.Web.Interfaces;

namespace SecureFileUploader.Portal.Web.Controllers
{
    [Route("api/[controller]")]
    [ApiController]
    [Authorize(AuthenticationSchemes = "EasyAuth")]
    public class ProgramsController : ControllerBase
    {
        private readonly ILogger<ProgramsController> _logger;
        private readonly IProgramService _programService;
        private readonly ICsvParser _csvParser;

        public ProgramsController(ILogger<ProgramsController> logger, IProgramService programService, ICsvParser csvParser)
        {
            _logger = logger;
            _programService = programService;
            _csvParser = csvParser;
        }

        /// <summary>
        ///     Creates a Program and Invitees.
        /// </summary>
        /// <response code="201">The values have been successfully saved in the Database</response>
        /// <response code="400">The values posted are incorrect</response>
        /// <response code="500">The values posted are incorrect</response>
        [HttpPost("file")]
        [Consumes("multipart/form-data")]
        [ProducesResponseType(typeof(LookupIdentifier), StatusCodes.Status201Created)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [DisableRequestSizeLimit]
        public async Task<IActionResult> File([FromForm] FileUpload fileUpload)
        {
            if (!ModelState.IsValid) return BadRequest("Invalid request - missing parameters.");

            if (fileUpload.File.ContentType != "text/csv") return BadRequest("Only CSV files are accepted.");
            if (fileUpload.File.Length == 0) return BadRequest("The CSV file must not be empty.");

            var errors = ValidationService.ValidateProgram(fileUpload);

            if (errors.ErrorMessage.Count > 0)
            {
                return new BadRequestObjectResult(errors);
            }
            var program = await _programService.CreateProgramAsync(fileUpload);

            return program.Item1 ? Created("api/program/file", new LookupIdentifier { Id = new Guid(program.Item2) }) : StatusCode(400, program.Item2);
        }

        /// <summary>
        ///     Updates a Program with the given Id.
        /// </summary>
        /// <param name="id" example="3eb834fd-573b-4a08-98cf-11f79e3c8e92">The id of the program to update</param>
        /// <param name="values">The values to update</param>
        /// <returns></returns>
        /// <response code="200">Returns the updated program</response>
        /// <response code="400">Program is already commenced or Date Values are incorrect</response>
        /// <response code="404">Not found.</response>

        [HttpPut("{id:guid}")]
        [ProducesResponseType(typeof(Dtos.Program), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Put(Guid id, [FromForm] ProgramUpdate values)
        {
            if (!ModelState.IsValid) return StatusCode(400, "Invalid request - missing parameters");

            // We don't want update the Program with a past submission and commencement date
            if (values.CommencementDate < DateTime.UtcNow) return StatusCode(400, "Commencement date is in the past");
            if (values.SubmissionDeadline < DateTime.UtcNow) return StatusCode(400, "Submission date is in the past");
            if (values.CommencementDate > values.SubmissionDeadline) return StatusCode(400, "Commencement date is after submission date");

            try
            {
                var program = await _programService.UpdateProgramInformationAsync(id, values);
                if (program == null)
                    return NotFound();
                return Ok(program);
            }
            catch (InvalidOperationException e)
            {
                return StatusCode(400, e.Message);
            }
        }

        /// <summary>
        ///     Retrieves the program assigned to the provided id.
        /// </summary>
        /// <param name="id" example="3eb834fd-573b-4a08-98cf-11f79e3c8e92">The id of the program to retrieve.</param>
        /// <returns>The program assigned to the provided id.</returns>
        /// <response code="200">Returns the program assigned to the provided id.</response>
        /// <response code="404">Not found.</response>
        [HttpGet("{id:guid}")]
        [ProducesResponseType(typeof(Dtos.Program), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status404NotFound)]
        public async Task<IActionResult> Get(Guid id)
        {
            var program = await _programService.GetByIdAsync(id);
            if (program == null)
                return NotFound();
            return Ok(program);
        }

        /// <summary>
        ///     Gets a list of programs matching the provided search term.
        /// </summary>
        /// <param name="searchTerm" example="Prog">The search term.</param>
        /// <returns>A list of programs matching the provided search term.</returns>
        /// <response code="200">Returns a list of programs matching the provided search term.</response>
        [HttpPost("search")]
        [ProducesResponseType(typeof(IEnumerable<ProgramSummary>), StatusCodes.Status200OK)]
        public async Task<IEnumerable<ProgramSummary>> Search([FromQuery] string? searchTerm, [FromBody] SearchProgramsFilter searchProgramsFilter) =>
            await _programService.GetAllThatMatchSearchTermAsync(searchTerm, searchProgramsFilter);

        // // PUT : api/Program/{id}/program-practice/{id}
        // [HttpPut("{id:int}/program-practice/{id2:int}")]
        // public void PutProgramPractice(int id, int id2)
        // {
        // }

        [HttpPost("stage-file", Name = "Stage File")]
        [ProducesResponseType(typeof(IEnumerable<InviteCsvRow>), StatusCodes.Status200OK)]
        [ProducesResponseType(StatusCodes.Status400BadRequest)]
        [Consumes("multipart/form-data")]
        // We create a new model with just the file inside it because Swagger IFormFile asks for more than just a file
        public async Task<IActionResult> StageFile([FromForm] PreviewFileUpload fileUpload)
        {
            if (!ModelState.IsValid) return BadRequest("Invalid request - missing parameters.");

            if (fileUpload.File.ContentType != "text/csv") return BadRequest("Only CSV files are accepted.");
            if (fileUpload.File.Length == 0) return BadRequest("The CSV file must not be empty.");

            List<InviteCsvRow> csvRows;
            try
            {
                csvRows = await _csvParser.GetRecordsAsync<InviteCsvRow>(fileUpload.File);
            }
            catch (Exception ex)
            {
                _logger.LogDebug(ex, "Unable to parse the CSV file '{fileName}'.", fileUpload.File.FileName);
                return BadRequest("Unable to parse the CSV file." );
            }

            if (!csvRows.Any())
            {
                return BadRequest("The CSV file must contain a header row at least 1 record row.");
            }

            return Ok(csvRows);
        }
    }
}
