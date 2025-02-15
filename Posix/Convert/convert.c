// https://fhnw.mit-license.org/

// $ stat 20210209_173300T.WAV
// "Feb 11 14:47:48 2021"
// "Feb  9 17:33:54 2021"
// "May  9 14:36:32 2021"
// "Feb  9 17:32:58 2021"

// $ ./convert               
// 20210209_173300T.WAV => 2021-02-09/2021-02-09T16-33-54Z.WAV

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <time.h>

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

int convert_name(char *name,
    char *conv_name, size_t conv_name_len,
    char *conv_dir, size_t conv_dir_len) 
{
    assert(conv_name != NULL);
    assert(conv_name_len >= 0);
    assert(conv_dir != NULL);
    assert(conv_dir_len >= 0);
    int result;
    char *ext = get_extension(name);
    if (ext != NULL &&
        ((strcmp(ext, ".wav") == 0) || 
        (strcmp(ext, ".WAV") == 0) ||
        (strcmp(ext, ".mp4") == 0) ||
        (strcmp(ext, ".MP4") == 0)))
    {
        struct stat s;
        stat(name, &s);
        //time_t *t = &s.st_ctime; // last change
        //time_t *t = &s.st_mtime; // last modify
        //time_t *t = &s.st_atime; // last access
        time_t *t = &s.st_birthtime; // created
        //struct tm *tm = gmtime(t);
        struct tm *tm = localtime(t);
        // ISO8601, replace ':' with '-'
        char *format = "%Y-%m-%dT%H-%M-%SZ";
        // yyyy-mm-ddThh-mm-ssZ => 20 characters
        size_t len = 20 + 1; // '\0' terminated
        assert(len + strlen(ext) <= conv_name_len);
        len = strftime(conv_name, len, format, tm);
        conv_name[len] = '\0';
        strcpy(conv_name + len, ext); // including '\0'
        char *format2 = "%Y-%m-%d";
        // yyyy-mm-dd => 10 characters
        size_t len2 = 10 + 1; // '\0' terminated
        assert(len2 <= conv_dir_len);
        len2 = strftime(conv_dir, 10 + 1, format2, tm);
        conv_dir[len2] = '\0';
        result = 0;
    } else {
        conv_name[0] = '\0';
        conv_dir[0] = '\0';
        result = -1;
    }
    return result;
}

int main() {
    // TODO: add file name prefix = enclosing directory name
    int conv_str_max = 32;
    char conv_name[conv_str_max];
    char conv_dir[conv_str_max];
    DIR *d = opendir(".");
    struct dirent *e = readdir(d);
    while (e != NULL) {
        if (e->d_type == DT_REG) { // regular file
            int result = convert_name(e->d_name, 
                conv_name, conv_str_max, 
                conv_dir, conv_str_max);
            if (result == 0) {
                // TODO: use sprintf
                char *mkdir_cmd = malloc(1024 * sizeof(char));
                mkdir_cmd[0] = '\0';
                mkdir_cmd = strcat(mkdir_cmd, "mkdir ");
                mkdir_cmd = strcat(mkdir_cmd, conv_dir);
                char *mv_cmd =  malloc(1024 * sizeof(char));
                mv_cmd[0] = '\0';
                mv_cmd = strcat(mv_cmd, "mv ");
                mv_cmd = strcat(mv_cmd, e->d_name);
                mv_cmd = strcat(mv_cmd, " ");
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
