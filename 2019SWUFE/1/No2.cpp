#include<cstdio>
#include<string>
#include<algorithm>
using namespace std;
const int N=33;
const int Top=24*60;

struct obj{
    int id;
    int w;
    int num;
}T[N];

struct Node{
    int id=-1;
    Node* next=NULL;
}node[25];

bool cmp(obj a,obj b){
    return a.w>b.w;
}

int sum_w[25];

Node* root(Node* er){
    while(er->next!=NULL)
        er=er->next;
    return er;
}

int main(){
    freopen("data2.in","r",stdin);
    freopen("data2.out","w",stdout);
    for(int i=0;i<N;i++){
        scanf("%d",&T[i].w);
        T[i].id=i;
        //T[i].w=T[i].w*2+120;
    }
    for(int i=0;i<N;i++){
        scanf("%d",&T[i].num);
    }

    sort(T,T+N,cmp);
    for(int i=0;i<N;i++){
        while(T[i].num>0){
            int j=0;
            while(sum_w[j]+T[i].w>Top)j++;
            //找到可以装入的第一个箱子
            sum_w[j]+=T[i].w;
            T[i].num--;
            Node* er=new Node();
            er->id=T[i].id;
            root(&node[j])->next=er;
        }
    }

    for(int i=0;i<25;i++){
        Node* cur=&node[i];
        while(cur->next!=NULL){
            cur=cur->next;
            printf("%d ",cur->id);
        }
        printf("%\n");
    }
    int ans=0;
    for(int i=0;i<25;i++){
        if(sum_w[i]>0)ans++;
    }
    printf("%d",ans);
}
