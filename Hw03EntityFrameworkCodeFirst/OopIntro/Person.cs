using System;

namespace OopIntro
{
    public class Person
    {
        private string name;

        private int age;

        // 2.	Create Person Constructors
        public Person() : this ("No name", 1)
        {
        }

        public Person(int age) : this ("No name", age)
        {
        }

        public Person(string name) : this (name, 1)
        {
        }

        public Person(string name, int age)
        {
            this.Name = name;
            this.Age = age;
        }

        public string Name
        {
            get
            {
                return this.name;
            }
            set
            {
                if (string.IsNullOrEmpty(value))
                {
                    throw new ArgumentException("Invalid name!");
                }

                this.name = value;
            }
        }
        public int Age
        {
            get
            {
                return this.age;
            }
            set
            {
                if (value < 0)
                {
                    throw new ArgumentException("Invalid age!");
                }

                this.age = value;
            }
        }
    }
}
