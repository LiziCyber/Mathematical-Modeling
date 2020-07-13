#include<cstdio>
#include<cstdlib>
#include<algorithm>
#include<iostream>
#include<queue>
#include<string>
#include<sstream>
using namespace std;
double T=0;
int m,n,g;

struct hu{
	bool exist;
	double min_d[10];
	int num;
};

vector<hu*> vr[5];

bool cmp0(hu *a,hu *b){
	return a->min_d[0]<b->min_d[0];
}

bool cmp1(hu *a,hu *b){
	return a->min_d[1]<b->min_d[1];
}

bool cmp2(hu *a,hu *b){
	return a->min_d[2]<b->min_d[2];
}

bool cmp3(hu *a,hu *b){
	return a->min_d[3]<b->min_d[3];
}

bool cmp4(hu *a,hu *b){
	return a->min_d[4]<b->min_d[4];
}

hu h[600];

int main(){
	freopen("data.txt","r",stdin);
	cin>>m>>n>>g;
	string s;
	int len=589;
	for(int i=0;i<len;i++){
		h[i].exist=true;
		for(int j=0;j<g;j++){
			cin>>h[i].min_d[j];
		}
		for(int j=0;j<g;j++){
			vr[j].push_back(&(h[i]));
		}
	}
	sort(vr[0].begin(),vr[0].end(),cmp0);
	sort(vr[1].begin(),vr[1].end(),cmp1);
	sort(vr[2].begin(),vr[2].end(),cmp2);
	sort(vr[3].begin(),vr[3].end(),cmp3);
	sort(vr[4].begin(),vr[4].end(),cmp4);

	int a[5];
	for(int i=0;i<len;i++)
		a[i]=len;
	int maxa=*max_element(a,a+len);
	while(maxa>0){
		int i=0;
		while(!(vr[0][i]->exist))i++;

	}
}





//delta{5}.time=[1.78]
//delta{3}.time=[3.77,3.40]
