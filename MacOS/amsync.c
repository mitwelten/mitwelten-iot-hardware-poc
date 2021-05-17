// https://fhnw.mit-license.org/

// MacOS only
// Compile with $ gcc -o amsync amsync.c
// Copy amsync to SD card (this is done once)
// Make sure SD-card name is, e.g. "0000-0001"
// Make sure external disk name is "Elements"
// Open a terminal, run $ amsync for a dry run
// If console output looks fine, run $ amsync !

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>
#include <limits.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <time.h>

char *get_dir(char *path) {
    char *p = NULL;
    while(*path != '\0') {
        if (*path == '/') {
            p = path;
        }
        path++;
    }
    if (p != NULL) {
        p++; // skip '/'
    }
    return p;
}

char *get_extension(char *name) {
    char *p = NULL;
    while(*name != '\0') {
        if (*name == '.') {
            p = name;
        }
        name++;
    }
    if (p != NULL) {
        p++; // skip '.'
    }
    return p;
}

void to_lower(/* inout */ char *s) {
    if (s != NULL) {
        char *p = s;
        while(*p != '\0') {
            if ('A' <= *p && *p <= 'Z') {
                *p = *p - ('A' - 'a');
            }
            p++;
        }
    }
}

void readAudioMothDateUtc(char *name, /* out */ struct tm *t) {
    int fds[2];
    pipe(fds);
    int pid = fork();
    if (pid == 0) { // child
        close(fds[0]);
        dup2(fds[1], STDOUT_FILENO);
        char cmd[1024];
        sprintf(cmd, "mdls %s | grep kMDItemComment", name);
        execl("/bin/sh", "sh", "-c", cmd, NULL);
    } else { // parent
        close(fds[1]);
        int len = 1024 + 1;
        char buf[len];
        int r = read(fds[0], buf, len);
        buf[r] = '\0';
        //printf("%s", buf);
        //kMDItemComment                         = "Recorded at 17:22:00 09/02/2021 (UTC) by AudioMoth 24E144085F2569BF at medium-high gain setting while battery state was 4.6V and temperature was 19.4C. Amplitude threshold was 60."
        //kMDItemComment                         = "Recorded at 14:00:00 16/04/2021 (UTC) by AudioMoth 247475055F2569A5 at medium gain setting while battery state was 4.1V and temperature was 21.2C."
        if (r >= 54) {
            //struct tm t;
            char format[] = "%H:%M:%S %d/%m/%Y";
            strptime(&buf[54], format, t);
        } else {
            t = NULL;
        }
    }
}

int convert_name(char *name, char *cur_dir,
    char *conv_name, size_t conv_name_len,
    char *conv_dir, size_t conv_dir_len) 
{
    assert(name != NULL);
    assert(cur_dir != NULL);
    assert(conv_name != NULL);
    assert(conv_name_len >= 0);
    assert(conv_dir != NULL);
    assert(conv_dir_len >= 0);
    int result;
    char *ext = get_extension(name);
    to_lower(ext);
    if (ext != NULL &&
        ((strcmp(ext, "jpg") == 0) ||
        (strcmp(ext, "mp4") == 0) ||
        (strcmp(ext, "wav") == 0)))
    {
        // https://developer.apple.com/library/archive/documentation/System/Conceptual/ManPages_iPhoneOS/man2/stat.2.html
        //struct stat s;
        //stat(name, &s); // seems to work only from current directory

        //time_t *t = &s.st_ctime; // last change
        //time_t *t = &s.st_mtime; // last modify
        //time_t *t = &s.st_atime; // last access
        //time_t *t = &s.st_birthtime; // created // works on MacOS
        //struct tm *tm = gmtime(t);        
        //struct tm *tm = localtime(t);
        
        struct tm t;
        readAudioMothDateUtc(name, &t);
        //printf("Date = %s", asctime(&t));

        // ISO8601, replace ':' with '-'
        char *format = "%Y-%m-%dT%H-%M-%SZ";
        // yyyy-mm-ddThh-mm-ssZ => 20 characters
        size_t len = 20 + 1; // including '\0'
        char date[len];
        len = strftime(date, len, format, &t);
        date[len] = '\0';

        assert(strlen(cur_dir) + 1 + len + 1 + strlen(ext) + 1 <= conv_name_len);
        int len1 = sprintf(conv_name, "%s_%s.%s", cur_dir, date, ext);
        conv_name[len1] = '\0';

        char *format2 = "%Y-%m-%d";
        // yyyy-mm-dd => 10 characters
        size_t len2 = 10 + 1; // '\0' terminated
        assert(len2 <= conv_dir_len);
        len2 = strftime(conv_dir, 10 + 1, format2, &t);
        conv_dir[len2] = '\0';
        result = 0;
    } else {
        conv_name[0] = '\0';
        conv_dir[0] = '\0';
        result = -1;
    }
    return result;
}

int main(int argc, char *argv[]) {
    char buf[PATH_MAX];
    char *cur_path = realpath(".", buf);
    char *cur_dir = get_dir(cur_path);

    int conv_str_max = 1024;
    char conv_name[conv_str_max];
    char conv_dir[conv_str_max];
    DIR *d = opendir(".");
    struct dirent *e = readdir(d);
    while (e != NULL) {
        if (e->d_type == DT_REG) { // regular file
            int result = convert_name(e->d_name, cur_dir, 
                conv_name, conv_str_max, 
                conv_dir, conv_str_max);
            if (result == 0) {
                // TODO: use sprintf
                char *mkdir_cmd = malloc(1024 * sizeof(char));
                mkdir_cmd[0] = '\0';
                mkdir_cmd = strcat(mkdir_cmd, "mkdir -pv /Volumes/Elements/");
                mkdir_cmd = strcat(mkdir_cmd, cur_dir);
                mkdir_cmd = strcat(mkdir_cmd, "/");
                mkdir_cmd = strcat(mkdir_cmd, conv_dir);
                char *mv_cmd =  malloc(1024 * sizeof(char));
                mv_cmd[0] = '\0';
                mv_cmd = strcat(mv_cmd, "mv -nv ./");
                mv_cmd = strcat(mv_cmd, e->d_name);
                mv_cmd = strcat(mv_cmd, " /Volumes/Elements/"); // TODO: move up
                mv_cmd = strcat(mv_cmd, cur_dir);
                mv_cmd = strcat(mv_cmd, "/");
                mv_cmd = strcat(mv_cmd, conv_dir);
                mv_cmd = strcat(mv_cmd, "/");
                mv_cmd = strcat(mv_cmd, conv_name);
                if ((argc == 2) && (argv[1][0] == '!')) {
                    system(mkdir_cmd);
                    system(mv_cmd);
                } else {
                    printf("%s\n", mkdir_cmd);
                    printf("%s\n", mv_cmd);
                }
                free(mkdir_cmd);
                free(mv_cmd);
            }
        }
        e = readdir(d);
    }
    closedir(d);
}

