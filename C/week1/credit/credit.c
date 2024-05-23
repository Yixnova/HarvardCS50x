#include <stdio.h>
#include <cs50.h>

long NumDigits(long number)
{
    long cnt = 0;
    while(number > 0)
        cnt++, number /= 10;
    return cnt;
}

bool isValid(long number)
{
    long sum = 0;
    while(number > 0){
        sum += number % 10;
        number /= 10;
        long a = (number % 10) * 2;
        if(a > 9)
            sum += a % 10, a /= 10, sum += a;
        else sum += a;
        number /= 10;
    }
    return sum % 10 == 0;
}

bool checkAMEX(long number)
{
    for(int i = 1; i <= 13; ++i)
        number /= 10;
    return number == 34 || number == 37;
}

bool checkMASTERCARD(long number)
{
    for(int i = 1; i <= 14; ++i)
        number /= 10;
    return number >= 51 && number <= 55;
}

bool checkVISA(long number, long numDigits)
{
    for(int i = 1; i < numDigits; ++i)
        number /= 10;
    return number == 4;
}

void checkCard(long number)
{
    long numDigits = NumDigits(number);
    if(numDigits == 15 && checkAMEX(number)){
        printf("AMEX\n");
        return;
    }
    if(numDigits == 16 && checkMASTERCARD(number)){
        printf("MASTERCARD\n");
        return;
    }
    if((numDigits == 16 || numDigits == 13) && checkVISA(number, numDigits)){
        printf("VISA\n");
        return;
    }
    printf("INVALID\n");
    return;
}

int main()
{
    long number;
    number = get_long("Enter your credit card's number: ");
    if(!isValid(number))
    {
        printf("INVALID\n");
    }
    else
        checkCard(number);


    return 0;
}
