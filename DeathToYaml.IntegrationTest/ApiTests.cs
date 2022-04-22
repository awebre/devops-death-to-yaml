using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc.Testing;
using Microsoft.VisualStudio.TestTools.UnitTesting;

namespace DeathToYaml.IntegrationTest;

[TestClass]
public class ApiTests
{
    private WebApplicationFactory<Program> server = null!;

    [TestInitialize]
    public void Init()
    {
        server = new WebApplicationFactory<Program>();
    }

    [TestMethod]
    public async Task BaseUrl_ReturnsDeathToYaml()
    {
        //arrange
        var client = server.CreateDefaultClient();

        //act
        var response = await client.GetAsync("/");

        //assert
        var text = await response.Content.ReadAsStringAsync();
        Assert.AreEqual(text, "Death to YAML!");
    }
}