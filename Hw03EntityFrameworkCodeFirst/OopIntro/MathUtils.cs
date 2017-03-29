namespace OopIntro
{
    class MathUtils
    {
        public int Sum(int firstNum, int secondNum)
        {
            return firstNum + secondNum;
        }

        public int Substract(int firstNum, int secondNum)
        {
            return firstNum - secondNum;
        }

        public int Devide(int firstNum, int secondNum)
        {
            return firstNum / secondNum;
        }

        public int Multiply(int firstNum, int secondNum)
        {
            return firstNum * secondNum;
        }

        public int Percentage(int total, int percentage)
        {
            return this.Devide(this.Multiply(total, percentage), 100);
        }
    }
}
