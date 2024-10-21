#include <iostream>
using namespace std;

int main() {
    int k;
    cout << "Enter the value of k: ";
    cin >> k;
    
    for (int i = 2; i < k; i++){

        bool isPrime = true;

        for (int j = 2; j * j <= i; j++){
            if (i %j == 0){
                isPrime = false;
                break;
            }
        }

        if (isPrime){
        cout << i << " ";
        }
    }

   return 0;
}