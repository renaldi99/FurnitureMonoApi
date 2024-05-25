using Microsoft.AspNetCore.Mvc;

namespace FurnitureMonoApi.Controllers;

[ApiController]
[Route("api/v1/[controller]")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public ActionResult GetHealth()
    {
        return Ok("Oke Health");
    }
}

