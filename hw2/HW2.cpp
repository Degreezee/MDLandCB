#include <iostream>
#include <string>
#include <vector>
#include <regex>

enum TokenType {
    WHILE, IDENT, DO, ASSIGN, NUM, SEMICOLON, END, INVALID
};

struct Token {
    TokenType type;
    std::string value;
};

// Лексический анализатор
std::vector<Token> lexer(const std::string& input) {
    std::vector<Token> tokens;
    std::regex re(R"((while)|(do)|([a-zA-Z_]\w*)|(:=)|(-?\d+)|(;))");
    auto words_begin = std::sregex_iterator(input.begin(), input.end(), re);
    auto words_end = std::sregex_iterator();

    for (auto it = words_begin; it != words_end; ++it) {
        std::smatch match = *it;
        if (match[1].matched)
            tokens.push_back({ WHILE, "while" });
        else if (match[2].matched)
            tokens.push_back({ DO, "do" });
        else if (match[3].matched)
            tokens.push_back({ IDENT, match[3] });
        else if (match[4].matched)
            tokens.push_back({ ASSIGN, ":=" });
        else if (match[5].matched)
            tokens.push_back({ NUM, match[5] });
        else if (match[6].matched)
            tokens.push_back({ SEMICOLON, ";" });
        else
            tokens.push_back({ INVALID, match.str() });
    }

    tokens.push_back({ END, "" });
    return tokens;
}

// Синтаксический анализатор
bool parse(const std::vector<Token>& tokens) {
    int state = 1;
    for (const auto& token : tokens) {
        switch (state) {
        case 1:
            if (token.type == WHILE) state = 2;
            else return false;
            break;
        case 2:
            if (token.type == IDENT) state = 3;
            else return false;
            break;
        case 3:
            if (token.type == DO) state = 4;
            else return false;
            break;
        case 4:
            if (token.type == WHILE) state = 2;
            else if (token.type == IDENT) state = 5;
            else return false;
            break;
        case 5:
            if (token.type == ASSIGN) state = 6;
            else return false;
            break;
        case 6:
            if (token.type == IDENT || token.type == NUM) state = 7;
            else return false;
            break;
        case 7:
            if (token.type == SEMICOLON) state = 8;
            else return false;
            break;
        case 8:
            return true;
        }
    }
}

using namespace std;
int main() {
    setlocale(LC_ALL, "Russian");

    string input;
    cout << "Введите строку для анализа: ";
    getline(cin, input);

    auto tokens = lexer(input);
    if (parse(tokens)) {
        cout << "Строка корректна по синтаксису." << endl;
    }
    else {
        cout << "Синтаксическая ошибка." << endl;
    }

    return 0;
}