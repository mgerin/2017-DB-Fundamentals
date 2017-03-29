using System.Collections.Generic;
using System.Linq;

namespace OopIntro
{
    class Family
    {
        private List<Person> members;

        public Family()
        {
            this.members = new List<Person>();
        }

        public List<Person> Members
        {
            get { return this.members; }
        }

        public void AddMember(Person member)
        {
            members.Add(member);
        }

        public Person GetOldestPerson()
        {
            return this.members.OrderByDescending(m => m.Age).FirstOrDefault();
        }
    }
}
