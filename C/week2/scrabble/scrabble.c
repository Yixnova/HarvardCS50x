
#include <cs50.h>
#include <ctype.h>
#include <stdio.h>
#include <string.h>

int compute_score(char word[], int word_length);

char alphabet[26] = {'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K', 'L', 'M',
                     'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z'};

int scores[26] = {1, 3, 3, 2, 1, 4, 2, 4, 1, 8, 5, 1, 3, 1, 1, 3, 10, 1, 1, 1, 1, 4, 4, 8, 4, 10};

int score1 = 0;
int score2 = 0;

int main(void)
{
    string word1 = get_string("Player 1: ");
    string word2 = get_string("Player 2: ");

    score1 += compute_score(word1, strlen(word1));
    score2 += compute_score(word2, strlen(word2));

    if (score1 > score2)
    {
        printf("Player 1 wins!\n");
    }
    else if (score1 < score2)
    {
        printf("Player 2 wins!\n");
    }
    else
    {
        printf("Tie!\n");
    }
}

int compute_score(char word[], int word_length)
{
    int total_score = 0;

    for (int i = 0; i < word_length; i++)
    {
        if (isalpha(word[i]) == false)
        {
            continue;
        }
        int index = toupper(word[i]) - 65;
        total_score += scores[index];
    }
    return total_score;
}
