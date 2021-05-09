// https://fhnw.mit-license.org/

#include <assert.h>
#include <stdio.h>
#include <stdlib.h>
#include <dirent.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <string.h>
#include <time.h>

char *type_to_string(unsigned char type) {
    char *result;
    switch (type) {
        case DT_DIR: result = "DT_DIR"; break;
        case DT_REG: result = "DT_REG"; break;
        default: result = "other";
    }
    return result;
}

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

// TODO: conv_file_name, conv_dir_name
int convert_name(char *name, char *conv, size_t conv_len) {
    assert(conv != NULL);
    assert(conv_len >= 0);
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
        struct tm *t = gmtime(&s.st_mtime);
        printf("%s\n", asctime(t)); // TODO: wrong date
        // file name compatible ISO 8601, yyyy-mm-ddThh-mm-ssZ
        const char *format = "%Y-%m-%dT%H-%M-%SZ"; // => 20
        size_t len = 20 + 1; // '\0' terminated
        assert(len + strlen(ext) <= conv_len);
        size_t len2 = strftime(conv, len, format, t);
        conv[len2] = '\0';
        strcpy(conv + len2, ext); // including '\0'
        result = 0;
    } else {
        conv[0] = '\0';
        result = -1;
    }
    return result;
}

int main() {
    // TODO: add file name prefix = enclosing directory name
    int iso_name_max_len = 32;
    char iso_name[iso_name_max_len];
    DIR *d = opendir(".");
    struct dirent *e = readdir(d);
    while (e != NULL) {
        if (e->d_type == DT_REG) {
            int result = convert_name(e->d_name, iso_name, iso_name_max_len);
            if (result == 0) {
                // TODO: mkdir conv_dir_name
                // TODO: mv name conv_dir_name/conv_name
                printf("%s, %s, %s, SUCCESS\n", e->d_name, type_to_string(e->d_type), iso_name);
            } else {
                //printf("%s, %s, SKIPPED\n", e->d_name, type_to_string(e->d_type));
            }
        } else {
            //printf("%s, %s, SKIPPED\n", e->d_name, type_to_string(e->d_type));
        }
        e = readdir(d);
    }
    closedir(d);
}
