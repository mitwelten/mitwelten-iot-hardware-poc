// $ sudo ./sdreader

#define _XOPEN_SOURCE
#define _DEFAULT_SOURCE

#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <string.h>
#include <time.h>
#include <dirent.h>

char *get_extension(char *name) {
    char *p = NULL;
    while(*name != '\0') {
        if (*name == '.') {
            p = name;
        }
        name++;
    }
    return p;
}

int parse_aminfo(int fd, char *iso_date, float *batt, float *temp, int *ampl) {
    int result = 0;
    int len = 1024 + 1;
    char buf[len];
    int r = read(fd, buf, len); // blocking
    if (r == -1) {
        perror("read");
        exit(-1);
    } else if (r == 0) {
        printf("No metainfo comment found.\n");
        result = -1;
    } else {
        buf[r] = '\0';
        //printf("%s\n", buf);
        char *date_prefix = "Recorded at ";
        char *s = strstr(buf, date_prefix);
        if (s != NULL) {
            struct tm t;
            char format[] = "%H:%M:%S %d/%m/%Y (UTC)";
            strptime(s + strlen(date_prefix), format, &t);
            char iso_format[] = "%Y-%m-%dT%H:%M:%SZ";
            // e.g. 2018-12-29T12:17:25Z
            strftime(iso_date, 21, iso_format, &t);
        }
        char *batt_prefix = "battery state was ";
        s = strstr(s, batt_prefix);
        if (s != NULL) {
            *batt = atof(s + strlen(batt_prefix));
        }
        char *temp_prefix = "temperature was ";
        s = strstr(s, temp_prefix);
        if (s != NULL) {
            *temp = atof(s + strlen(temp_prefix));
        }
        char *ampl_prefix = "Amplitude threshold was ";
        s = strstr(s, ampl_prefix);
        if (s != NULL) {
            *ampl = atoi(s + strlen(ampl_prefix));
        }
        return result;
    }
}

void process_file(char *name) {
    int fds[2];
    pipe(fds);
    int pid = fork();
    if (pid == 0) { // child
        close(fds[0]);
        dup2(fds[1], STDOUT_FILENO);
        char cmd[1024];
        sprintf(cmd, "mediainfo %s | grep Comment", name);
        execl("/bin/sh", "sh", "-c", cmd, NULL);
    } else {
        close(fds[1]);
        char iso_date[21];
        float batt;
        float temp;
        int ampl;
        int res = parse_aminfo(fds[0], iso_date, &batt, &temp, &ampl);
        if (res == 0) {
            printf("Date = %s\n", iso_date);
            printf("Batt = %1.2fV\n", batt);
            printf("Temp = %2.2fC\n", temp);
            printf("Ampl = %d\n", ampl);
        }
        close(fds[0]);
    }
}

int main(int argc, char *argv[]) {
    if (argc != 1) {
        printf("usage: sudo %s\n", argv[0]);
        exit(-1);
    }
    // ensure sd card is mounted
    system("mkdir /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/mkdir.2.html
    system("mount /dev/sda1 /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/mount.2.html

    DIR *d = opendir("/media/sda1");
    if (d == NULL) {
        perror("opendir");
        exit(-1);
    }
    struct dirent *e = readdir(d);
    while (e != NULL) {
        if (e->d_type == DT_REG) { // regular file
            char name[1024];
            strcpy(name, "/media/sda1/");
            strcat(name, e->d_name);
            char *ext = get_extension(name);
            if (ext != NULL &&
                ((strcmp(ext, ".wav") == 0) ||
                (strcmp(ext, ".WAV") == 0)))
            {
                printf("Processing %s\n", name);
                process_file(name);
            } else {
                printf("Skipping %s\n", name);
            }
        }
        e = readdir(d);
    }
    closedir(d);

    system("umount /media/sda1"); // TODO: use https://man7.org/linux/man-pages/man2/umount.2.html
}
