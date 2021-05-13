#include <stdlib.h>
#include <stdio.h>
#include <unistd.h>
#include <time.h>

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("usage: %s file\n", argv[0]);
        exit(-1);
    }
    int fds[2];
    pipe(fds);
    int pid = fork();
    if (pid == 0) { // child
        close(fds[0]);
        dup2(fds[1], STDOUT_FILENO);
        char cmd[1024];
        sprintf(cmd, "mdls %s | grep kMDItemComment", argv[1]);
        execl("/bin/sh", "sh", "-c", cmd, NULL);
    } else { // parent
        close(fds[1]);
        int len = 1024 + 1;
        char buf[len];
        int r = read(fds[0], buf, len); // blocking
        buf[r] = '\0';
        //printf("%s", buf);
        //kMDItemComment                         = "Recorded at 17:22:00 09/02/2021 (UTC) by AudioMoth 24E144085F2569BF at medium-high gain setting while battery state was 4.6V and temperature was 19.4C. Amplitude threshold was 60."
        if (r >= 54) {
            struct tm t;
            char format[] = "%H:%M:%S %d/%m/%Y";
            strptime(&buf[54], format, &t);
            printf("Date = %s", asctime(&t));
        }
        if (r >= 162) {
            float batt = atof(&buf[162]);
            printf("Batt = %1.2fV\n", batt);
        }
        if (r >= 187) {
            float temp = atof(&buf[187]);
            printf("Temp = %2.2fC\n", temp);
        }
    }
}
