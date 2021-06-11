
#define _XOPEN_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <time.h>

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
        sprintf(cmd, "mediainfo %s | grep Comment", argv[1]);
        execl("/bin/sh", "sh", "-c", cmd, NULL);
    } else {
        close(fds[1]);
        int len = 1024 + 1;
        char buf[len];
        int r = read(fds[0], buf, len); // blocking
        buf[r] = '\0';
        //printf("%s\n", buf);
        char *date_prefix = "Recorded at ";
        char *s = strstr(buf, date_prefix);
        if (s != NULL) {
            struct tm t;
            char format[] = "%H:%M:%S %d/%m/%Y (UTC)";
            strptime(s + strlen(date_prefix), format, &t);
            char iso_format[] = "%Y-%m-%dT%H:%M:%SZ";
            char iso_date[21]; // e.g. 2018-12-29T12:17:25Z
            strftime(iso_date, 21, iso_format, &t);
            printf("Date = %s\n", iso_date);
        }
        char *batt_prefix = "battery state was ";
        s = strstr(s, batt_prefix);
        if (s != NULL) {
            float batt = atof(s + strlen(batt_prefix));
            printf("Batt = %1.2fV\n", batt);
        }
        char *temp_prefix = "temperature was ";
        s = strstr(s, temp_prefix);
        if (s != NULL) {
            float temp = atof(s + strlen(temp_prefix));
            printf("Temp = %2.2fC\n", temp);
        }
        char *ampl_prefix = "Amplitude threshold was ";
        s = strstr(s, ampl_prefix);
        if (s != NULL) {
            int ampl = atoi(s + strlen(ampl_prefix));
            printf("Ampl = %d\n", ampl);
        }
        system("umount /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/umount.2.html
    }
}
