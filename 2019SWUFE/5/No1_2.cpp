#include<cstdio>
#include<sstream>
#include<iostream>
#include<string>
using namespace std;

const int INF=1e8;
const int N=21;
int A[N+1][N+1];


int main(){
    freopen("data1_2.in","r",stdin);
    freopen("data1_2.out","w",stdout);
    int i,j,k;
    for(i=0;i<31;i++){
        int x,y,dis;
        scanf("%d%d%d\n",&x,&y,&dis);
        A[x][y]=dis;
        A[y][x]=dis;
    }

    for(i=1;i<=N;i++){
        for(j=1;j<=N;j++){
            int sum=0;
            string line;
            getline(cin,line);
            stringstream ss(line);
            int x,x0;
            ss>>x0;
            while(ss>>x){
                sum+=A[x0][x];
                x0=x;
            }
            printf("%d\t",sum);
        }
        printf("\n");
    }
    printf("%d",A[1][6]);
}
