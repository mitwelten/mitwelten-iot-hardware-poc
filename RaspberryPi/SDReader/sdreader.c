#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
//#include <time.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("usage: sudo %s file\n", argv[0]);
        exit(-1);
    }
    // ensure sd card is mounted
    system("mkdir /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/mkdir.2.html
    system("mount /dev/sda1 /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/mount.2.html
    int fds[2];
    pipe(fds);
    int pid = fork();
    if (pid == 0) { // child
        close(fds[0]);
        dup2(fds[1], STDOUT_FILENO);
        char cmd[1024];
        sprintf(cmd, "cat %s", argv[1]);
        execl("/bin/sh", "sh", "-c", cmd, NULL);
    } else {
        close(fds[1]);
        int len = 1024 + 1;
        char buf[len];
        int r = read(fds[0], buf, len); // blocking
        buf[r] = '\0';
        printf("%s", buf);
        system("umount /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/umount.2.html
    }
}
