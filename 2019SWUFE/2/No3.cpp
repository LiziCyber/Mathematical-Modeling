#include<cstdio>
#include<algorithm>
#include<vector>
using namespace std;
const int N=21;
int dis[N+1][N+1];
int cur_city;
int cur_choice=0;
vector<int>choice[20];

struct node{
    int demand;
    int id;
}city[N+1];

node ways[N+1][N+1];

bool cmp(node &a,node &b){
    return dis[a.id][cur_city]<dis[b.id][cur_city];
}

double cost(vector<int> &A,int len,int weight){
    int st=0;
    for(int i=1;i<len;i++)
        st+=dis[A[i-1]][A[i]]+60;
    st+=60+dis[A[len-1]][1];
    return st/30+(18-weight)*2;
}

void solve(int cid,int cwt){
    choice[cur_choice].push_back(cid);
    if(city[cid].demand+cwt>18){
        city[cid].demand-=(18-cwt);
        cwt=18;
    }else if(city[cid].demand+cwt==18){
        city[cid].demand=0;
        cwt=18;
    }else{
        cwt+=city[cid].demand;
        city[cid].demand=0;
        cur_city=cid;
        sort(ways[cid]+1,ways[cid]+N+1,cmp);

        vector<int> cur;
        for(int i=0;i<choice[cid].size();i++)
            cur.push_back(choice[cid][i]);
        cur.push_back(0);

        int c=1e8,next=2;
        int q=2;
        while(q<=N){
            if(city[ways[cid][q].id].demand==0){
                q++;
                continue;
            }
            cur[cur.size()-1]=q;
            int jud=cost(cur, cur.size(), min(cwt+city[ways[cid][q].id].demand,18));
            if(cwt+city[ways[cid][q].id].demand>18)
                jud+=(60+dis[1][q]*2)/30;
            if(c>jud){
                next=q;
                c=jud;
            }
            q++;
        }
        //printf("---%d---\n",ways[cid][next].id);
        solve(ways[cid][next].id,cwt);
    }
}

int main(){
    freopen("data3.in","r",stdin);
    freopen("data3.out","w",stdout);
    for(int i=1;i<=N;i++)
        for(int j=1;j<=N;j++)
            scanf("%d",&dis[i][j]);

    for(int i=1;i<=N;i++){
        city[i].id=i;
        for(int j=1;j<=N;j++){
            ways[i][j].id=j;
        }
    }
    for(int i=1;i<=13;i++){
        int p;
        scanf("%d",&p);
        scanf("%d",&city[p].demand);
    }
    cur_city=1;
    sort(ways[1]+1,ways[1]+N+1,cmp);
    for(int i=2;i<=N;i++){
        while(city[ways[1][i].id].demand>0){
            solve(ways[1][i].id,0);
            choice[cur_choice].push_back(1);
            cur_choice++;
        }
    }
    for(int i=0;i<cur_choice;i++){
        //printf("1,");
        int tt=dis[1][choice[i][0]]+60;
        for(int j=1;j<choice[i].size();j++){
            tt+=dis[choice[i][j-1]][choice[i][j]]+60;
        }
        for(int j=0;j<choice[i].size()-1;j++){
            printf("%d,",choice[i][j]);
        }
        printf("%d\n",tt);
        //printf("%d\n",choice[i][choice[i].size()-1]);
        //printf("%d\n",tt);
    }

    return 0;
}
