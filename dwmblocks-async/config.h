#ifndef CONFIG_H
#define CONFIG_H

// String used to delimit block outputs in the status.
#define DELIMITER "  "

// Maximum number of Unicode characters that a block can output.
#define MAX_BLOCK_OUTPUT_LENGTH 45

// Control whether blocks are clickable.
#define CLICKABLE_BLOCKS 0

// Control whether a leading delimiter should be prepended to the status.
#define LEADING_DELIMITER 0

// Control whether a trailing delimiter should be appended to the status.
#define TRAILING_DELIMITER 0

// Define blocks for the status feed as X(icon, cmd, interval, signal).
#define BLOCKS(X)                                                                                   \
    X("MEM: ", "free -h | awk '/^Mem:/ { print $3 }'", 5, 0)                                         \
    X("DISK: ", "df -h / | awk 'NR==2 { print $4 }'", 60, 0)                                         \
    X("UPD: ", "checkupdates | wc -l | awk '{ if ($1 > 0) print $1 }'", 3600, 0) /* Arch Linux only */ \
    X("", "date '+%H:%M'", 60, 0)

#endif  // CONFIG_H
