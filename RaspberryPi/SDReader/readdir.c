#include <stdio.h>
#include <dirent.h>

int main() {
    DIR *d = opendir(".");
    struct dirent *e = readdir(d);
    while (e != NULL) {
        if (e->d_type == DT_REG) { // regular file
            printf("%s\n", e->d_name);
        }
        e = readdir(d);
    }
    closedir(d);
}
