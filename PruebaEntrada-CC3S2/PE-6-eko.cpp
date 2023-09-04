#include <bits/stdc++.h>
using namespace std;

int main(){      
    int n, m, dato, suma, height = 0;
    cin >> n >> m;
    vector<int> v;
    for (int i=0; i<n; i++){
        cin >> dato;
        v.push_back(dato);
    }
    sort(v.begin(), v.end(), greater<int>());
    height = v.front();
    while(suma < m){
        height--;
        suma = 0;
        for (auto val: v){
            if (val > height)
                suma += (val - height);
        }
    }
    cout << height << "\n";
    return 0;
}
