#define _CRT_SECURE_NO_WARNINGS
#include <stdio.h>
#define INF 9999
int x =101;
int fact(int a)
{
    int i=1,ans=1;
    for(;i<=a;i++)
        ans*=i;
    return ans;
}
int main()
{
    int n;
    scanf("%d",&n);
    printf("%d\n",fact(n));
    printf("%d",x);
    return 0;
}