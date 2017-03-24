using System.Security.AccessControl;

namespace FootballManager
{
    using System.Data.Entity;
    using System;
    using System.Collections.Generic;
    using System.Linq;
    using System.Text;
    using System.Threading.Tasks;
    using Models;

    public class FMContext : DbContext
    {
        public FMContext() : base("FootballManagerContext")
        {
            
        }

        private DbSet<Team> Teams { get; set; }

        private DbSet<Player> Players { get; set; }
        private DbSet<Manager> Managers { get; set; }
        private DbSet<League> Leagues { get; set; }
    }
}
