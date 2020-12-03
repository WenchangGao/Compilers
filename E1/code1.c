#include <stdio.h>
int main()
{
    int i, n, f;
    f=0;
    scanf("%d", &n);
    if(n % 2 == 0)
        for(i=0;i<=n;i++)
            f += i;
    else
        for(i=1;i<=n;i+=2)
            f += i;
    printf("%d", f);
    return 0;
}