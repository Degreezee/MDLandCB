#include <iostream>
#include <cstring>

using namespace std;

// Объявление внешней ассемблерной функции
extern "C" int countVowels(const char* str, int (*isVowelFunc)(int));

// Функция проверки на гласную
extern "C" int isVowel(int ch) {
    ch |= 0x20; // Перевод в нижний регистр
    return ch == 'a' || ch == 'e' || ch == 'i' || ch == 'o' || ch == 'u';
}

int main() {
    const int MAX_LEN = 256;
    char str1[MAX_LEN], str2[MAX_LEN];

    cout << "Enter first string (max 255 chars): ";
    cin.getline(str1, MAX_LEN);

    cout << "Enter second string (max 255 chars): ";
    cin.getline(str2, MAX_LEN);

    // Вызываем ассемблерную функцию, передаём указатель на isVowel
    int count1 = countVowels(str1, isVowel);
    int count2 = countVowels(str2, isVowel);

    // Сравниваем количество гласных
    if (count1 > count2) {
        cout << "First string has more vowels (" << count1 << " vs " << count2 << ")" << endl;
    } else if (count2 > count1) {
        cout << "Second string has more vowels (" << count2 << " vs " << count1 << ")" << endl;
    } else if (count1 == 0 && count2 == 0){
        cout << "Both strings do not contain vowels" << endl;
    } else {
        cout << "Both strings have the same number of vowels (" << count1 << ")" << endl;
    }

    return 0;
}
