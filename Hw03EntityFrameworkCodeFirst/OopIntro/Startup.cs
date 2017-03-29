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
            //string[] inputArgs = Console.ReadLine().Split(new char[] { ',' }, StringSplitOptions.RemoveEmptyEntries );

            //if (inputArgs.Length == 0)
            //{
            //    Person p = new Person();
            //    Console.WriteLine($"{p.Name} {p.Age}");
            //}
            //else if (inputArgs.Length == 1)
            //{
            //    string argument = inputArgs[0];
            //    int age = -1;

            //    if (int.TryParse(argument, out age))
            //    {
            //        Person p = new Person(age);
            //        Console.WriteLine($"{p.Name} {p.Age}");
            //    }
            //    else
            //    {
            //        Person p = new Person(argument);
            //        Console.WriteLine($"{p.Name} {p.Age}");
            //    }
            //}
            //else if (inputArgs.Length == 2)
            //{
            //    string name = inputArgs[0];
            //    int age = int.Parse(inputArgs[1]);
            //    Person p = new Person(name, age);
            //    Console.WriteLine($"{p.Name} {p.Age}");
            //}

            // 3. Family members
            Family nakovi = new Family();
            nakovi.AddMember(new Person("Svetlin Nakov"));
            nakovi.AddMember(new Person("Verjinia Nakova"));

            Family gerini = new Family();
            gerini.AddMember(new Person("Marin Gerin", 28));
            gerini.AddMember(new Person("Viktoria Gerina"));

            //foreach (Person member in nakovi.Members)
            //{
            //    Console.WriteLine(member.Name);
            //}

            //foreach (Person member in gerini.Members)
            //{
            //    Console.WriteLine(member.Name);
            //}

            // Person oldestOne = gerini.GetOldestPerson();
            // Console.WriteLine(oldestOne.Name);

            // 4. Students

            string input = Console.ReadLine();

            while (input != "End")
            {
                Student st = new Student(input);

                input = Console.ReadLine();
            }

            Console.WriteLine(Student.count);
        }
    }
}
