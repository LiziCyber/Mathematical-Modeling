#include<cstdio>
using namespace std;

const int INF=1e8;
const int N=21;
int A[N+1][N+1];
int R[N+1][N+1];

int main(){
    freopen("data1_3.in","r",stdin);
    freopen("data1_3.out","w",stdout);
    int i,j,k,t;
    for(i=1;i<=N;i++){
        for(j=1;j<=N;j++){
            R[i][j]=j;
            if(i==j)A[i][j]=0;
            else A[i][j]=INF;
        }
    }
    while(scanf("%d%d%d",&i,&j,&t)==3)
        A[i][j]=A[j][i]=t;

    for(k=1;k<=N;k++){
        for(i=1;i<=N;i++){
            for(j=1;j<=N;j++){
                if(A[i][k]+A[k][j]<A[i][j]&&A[i][k]<INF&&A[k][j]<INF){
                    A[i][j]=A[i][k]+A[k][j];
                    R[i][j]=R[i][k];
                }
            }
        }
    }
    for(i=1;i<=N;i++){
        for(j=1;j<=N;j++){
            printf("%d ",A[i][j]);
        }
        printf("\n");
    }
    //printf("\n-------");
    for(i=1;i<=N;i++){
        for(j=1;j<=N;j++){
            printf("%d ",i);
            int s=i;
            while(R[s][j]!=j){
                printf("%d ",R[s][j]);
                s=R[s][j];
            }
            printf("%d\n",j);
        }
    }
}
