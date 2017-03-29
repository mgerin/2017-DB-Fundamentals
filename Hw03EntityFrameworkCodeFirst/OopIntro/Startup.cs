using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace OopIntro
{
    class Startup
    {
        static void Main(string[] args)
        {
            // 1.	Define a class Person
            //Person pesho = new Person() {Name = "Pesho", Age = 20};
            //Person gosho = new Person();
            //gosho.Name = "Gosho";
            //gosho.Age = 18;

            //Person stamat = new Person() {Name = "Stamat", Age = 43};

            //Console.WriteLine($"{pesho.Name} {pesho.Age}");
            //Console.WriteLine($"{gosho.Name} {gosho.Age}");
            //Console.WriteLine($"{stamat.Name} {stamat.Age}");

            // 2.	Create Person Constructors

            Person firsPerson = new Person("Marin", 30);

            Console.WriteLine(firsPerson.Name + " " + firsPerson.Age);
        }
    }
}
