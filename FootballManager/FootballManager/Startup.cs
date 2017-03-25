using FootballManager.Models;

namespace FootballManager
{
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;

    class Startup
    {
        static void Main()
        {
            var context = new FootballManagerContext();

            // context.Database.Initialize(true);

            context.Teams.Add(new Team() {Name = "Barcelona"});
            context.SaveChanges();
        }
    }
}
